import Pkg
Pkg.activate(@__DIR__)
Pkg.instantiate()
using Random
using Plots
using GraphRecipes
using LaTeXStrings
using Distributions

# this sets a random seed, which ensures reproducibility of random number generation. You should always set a seed when working with random numbers.
Random.seed!(1)

function minimum(array)
    # initialize the minimum value counter
    min_value = array[1]
    # update minimum values
    for i in 1:length(array)
        if array[i] < min_value
            min_value = array[i]
        end
    end
    # return found minimum
    return min_value
end

array_values = [89, 90, 95, 100, 100, 78, 99, 98, 100, 95]
@show minimum(array_values);


function passadieci()
    # this rand() call samples 3 values from the vector [1, 6]
    roll = rand(1:6, 3) 
    return roll
end
# set number of trials and initialize outcome vector
n_trials = 1_000
outcomes = trues(n_trials)
# simulate number of passadieci rolls and count wins
for i = 1:n_trials
    outcomes[i] = (sum(passadieci()) > 11)
end
win_prob = sum(outcomes) / n_trials # compute average number of wins
#@show win_prob;
#=
A = [0 1 1 1;
    0 0 0 1;
    0 0 0 1;
    0 0 0 0]

names = ["Plant", "Land Treatment", "Chem Treatment", "Pristine Brook"]
# modify this dictionary to add labels
edge_labels = Dict((1, 2) => L"X_1", (1,3) => L"X_2", (1, 4) => L"100-X_1-X_2",(2, 4) => L"0.2X_1",(3, 4) => L"0.005X_2(X_2)")
shapes=[:hexagon, :rect, :rect, :hexagon]
xpos = [0, -1.5, -0.25, 1]
ypos = [1, 0, 0, -1]

p = graphplot(A, names=names,edgelabel=edge_labels, markersize=0.15, markershapes=shapes, markercolor=:white, x=xpos, y=ypos)
display(p)
=#
function WW_model(x1, x2)
    cost = x1*x1/20 + x2*1.5 # equation derrived for cost
    YUK = 0.2*x1 + 0.005*x2*x2+ (100-x1-x2) #eq for YUK in stream
    return(cost, YUK)
end

#set x1 and x2 values
n = 1000 # number of trials
x1 = zeros(n)
x2 = zeros(n)
#d = Dirichlet(3,1)
for i=1:n
    d = Dirichlet(3,1)
    vects = rand(d)
    # seperate the x1 and x2 components and scale to 100
    x1[i]= vects[1]*100
    x2[i]= vects[2]*100
end

#calculate YUK and cost for random x1 and x2 values
output = WW_model.(x1, x2)
cost = [out[1] for out in output]
YUK = [out[2] for out in output]
@show cost;
@show YUK;
