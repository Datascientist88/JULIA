#using Pkg # uncmment this part of the code to install the dependencies
#Pkg.add(["DifferentialEquations","Plots"])

using Plots
using DifferentialEquations

# Define a custom plot type for three-body problems using @userplot and @recipe
@userplot threebodyplot
@recipe function f(tbp::threebodyplot)
    # Define the parameters for plotting
    x, y, l, xlim, ylim = tbp.args
    xaxis --> ("x", xlim)  # Label the x-axis
    yaxis --> ("y", ylim)  # Label the y-axis
    seriestype --> :scatter  # Scatter plot type
    markertype --> :o  # Marker style
    markercolor --> "black"  # Marker color
    label --> l  # Legend label
    dpi --> 300  # Resolution
    [x], [y]  # Coordinates for plotting
end

# Function to create the animation
function anim()

    # Inertial frame function, calculates the force on the object in a two-body system
    function inertial(ddu, du, u, p, t)
        μ1 = p[1,1]  # Mass of the first body
        μ2 = p[2,1]  # Mass of the second body
        x1 = p[:,2]  # Position of the first body
        x2 = p[:,3]  # Position of the second body

        # Calculate distances to each body
        r1 = sqrt((x1[1] - u[1])^2 + (x1[2] - u[2])^2 )
        r2 = sqrt((x2[1] - u[1])^2 + (x2[2] - u[2])^2 )

        # Set up the differential equations for acceleration
        ddu[1] = μ1*(x1[1] - u[1])/r1^3 + μ2*(x2[1] - u[1])/r2^3
        ddu[2] = μ1*(x1[2] - u[2])/r1^3 + μ2*(x2[2] - u[2])/r2^3
    end

    # Rotating frame function, which includes Coriolis and centrifugal forces
    function rotating(ddu, du, u, p, t)
        μ1, μ2, n = p  # Masses of the two bodies and angular velocity

        # Calculate distances to each body
        r1 = sqrt((u[1] + μ2)^2 + u[2]^2)
        r2 = sqrt((u[1] - μ1)^2 + u[2]^2)

        # Set up the differential equations for acceleration in the rotating frame
        ddu[1] = -(μ1*(u[1] + μ2)/r1^3 + μ2*(u[1] - μ1)/r2^3) + 2n*du[2] + n^2*u[1]
        ddu[2] = -u[2]*(μ1/r1^3 + μ2/r2^3) - 2n*du[1] + n^2*u[2]
    end

    # Hill frame function, specialized for circular orbits
    function hill(ddu, du, u, p, t)
        f = -3/(u[1]^2 + u[2]^2)^1.5  # Gravitational force component

        # Differential equations for acceleration in Hill's frame
        ddu[1] = u[1]*(f + 3) + 2du[2]
        ddu[2] = u[2]*f - 2du[1]
    end

    # Define time range for simulation
    t0 = -100.
    t1 = 150.
    tspan = (t0, t1)

    # Define masses and initial positions of the two primary bodies
    mu1 = .2
    mu2 = .8
    n = 1
    x1 = [1, 1]
    x2 = [-1, -1]

    # Initial parameters for the inertial frame
    p = zeros(2,3)
    p[1,1] = mu1
    p[2,1] = mu2
    p[:,2] = x1
    p[:,3] = x2

    # Initial conditions for position and velocity
    du0 = zeros(2)
    u0 = zeros(2)
    u0[1] = 0.5  # Set initial x position

    # Define and solve the inertial frame problem
    probi = SecondOrderODEProblem(inertial, du0, u0, tspan, p, abstol=1e-8, reltol=1e-8)
    soli = solve(probi, Tsit5())

    # Set parameters for rotating frame
    p = zeros(3)
    p[1] = mu1
    p[2] = mu2
    p[3] = n

    # Initial velocity and position adjustments for rotating frame
    dv0 = zeros(2)
    v0 = zeros(2)
    v0[1] = u0[1]*cos(n*t0) + u0[2]*sin(n*t0)
    v0[2] = -u0[1]*sin(n*t0) + u0[2]*cos(n*t0)

    # Solve rotating frame problem
    probr = SecondOrderODEProblem(rotating, dv0, v0, tspan, p, abstol=1e-8, reltol=1e-8)
    solr = solve(probr, Tsit5())

    # Initial conditions for Hill's frame
    dw0 = zeros(2)
    w0 = zeros(2)
    w0[1] = v0[1] + 1  # Shift in x-axis
    w0[2] = v0[2]

    # Solve Hill frame problem
    probh = SecondOrderODEProblem(hill, dw0, w0, tspan, abstol=1e-8, reltol=1e-8)
    solh = solve(probr, Tsit5())

    # Find minimum length among solutions for animation range
    n = min(length(solh.t), length(solr.t), length(soli.t))

    # Animate the trajectories
    anim = @animate for i in 1:10:n

        # Plot for inertial frame
        p1 = plot((x1[1], x1[2]), markershape=:o, markercolor="blue", label="planet 1",
                  legend=:bottomright, framestyle=:zerolines)
        p1 = plot!((x2[1], x2[2]), markershape=:o, markercolor="green", label="planet 2")
        p1 = threebodyplot!(soli[3,i], soli[4,i], "inertial", (-1.5,1.5), (-1.5,1.5))

        # Plot for rotating frame
        p2 = plot((-mu2, 0), markershape=:o, markercolor="blue",  label="planet 1",
                  legend=:bottomright, framestyle=:zerolines)
        p2 = plot!((mu1, 0), markershape=:o, markercolor="green", label="planet 2")
        p2 = threebodyplot!(solr[3,i], solr[4,i], "rotating", (-1, 1), (-1, 1))

        # Plot for Hill's frame
        p3 = plot((0, 0), markershape=:o, markercolor="green", label="planet 2",
                  legend=:bottomright, framestyle=:zerolines)
        p3 = threebodyplot!(solh[3,i], solh[4,i], "hill", (-1.5,1.5), (-1.5,1.5))

        # Arrange plots in 3 rows, 1 column layout
        plot(p1, p2, p3, layout=(3,1), size=(800,1600))
    end

    # Save the animation as a GIF
    gif(anim, "animi.gif", fps=15)
end

# Call the animation function to generate the animation
anim()
