 / Generic genetic algorithm for finding an optimal solution to an optimization problem.
 / Inputs are:
 /  an inputcontext: represents the problem modelization
 /  a runtimecontext: represents the run time parameters
.math.geneticSolver.run:{[inputcontext;runtimecontext]
    result:()!(); result[`inputcontext]:inputcontext; result[`runtimecontext]:runtimecontext;
    startTime:.z.T; exitFlag:0b; minScore:0w; iterations:0i; optimalSolution:`;
    / generate initial random solutions
    inputcontext[`populationSize]:runtimecontext[`populationSize];
    inputcontext[`generateInitialSolutions][];
    while[not exitFlag;
        iterations+:1;
        show "In iteration ",(string iterations),"...";
        / compute score for each solution
        inputcontext[`scoreSolutions][];
        / apply natural selection
        inputcontext[`naturalSelection][runtimecontext[`populationSelectionRate]];
        / breed
        inputcontext[`breedSolutions][];
        / mutate
        inputcontext[`mutateSolutions][runtimecontext[`populationMutationRate]];
        / check exit conditions
        $[runtimecontext[`maxGeneticCycles]<iterations;
            [show "MaxGeneticCycles reached: exit";exitFlag:1b];
        $[runtimecontext[`maxRuntime]<`float$.z.T-startTime;
            [show "MaxRuntime reached: exit";exitFlag:1b];[]
        ]];
        / also exit if optimum does not improve
        / ...
    ];
    result};

 / Util function to generate a sample input context
.math.geneticSolver.generateInputContext:{[]
    context:()!();
    / table storing the current population. Each row represents a valid solution.
    context[`populationSize]:1000;
    context[`population]:([]solution:""$(); score:`float$());
    context[`generateInitialSolution]:{[]
        / function to generate a valid initial solution to the problem
        / solution must be a dictionary with (at least) an id (symbol) and score (float) attributes
        / ...
        };
    context[`generateInitialSolutions]:{[]
        / function to generate a valid initial solution to the problem
        / solution must be a dictionary with (at least) a score attribute
        context[`population]:update solution:context[`generateInitialSolution][] peach til context[`populationSize], score:0w from context[`population];
        };
    context[`score]:{[solution]
        / scoring function. Must return a float >=0
        / the purpose of the genetic algorithm will be to find the solution with minimum scores

        };
    context[`scoreSolutions]:{[]
        / score all solutions
        context[`population]:update score:context[`score] peach solution from context[`population];
        };
    context[`naturalSelection]:{[selectionRate]
        / function to apply natural selection
        / when applied, only the 'best' x% of the population will survive,
        / with 'best' being defined by having a lower score, and x being the selectionRate (for example 20%)
        rate:0.20;
        / ...
        };
    context[`breed]:{[solutionA;solutionB]
        / breeding function
        / takes 2 solutions and return a valid hybrid of the 2
        };
    context[`breedSolutions]:{[]
        / breed all population
        };
    context[`mutate]:{[solution;mutationRate]
        / mutation function: modify slightly an existing solution
        / must return a valid solution
        /...
        };
    context[`mutateSolutions]:{[mutationRate]
        / mutate all population

        };
    context};

 / Util function to generate a sample runtime context
.math.geneticSolver.generateRuntimeContext:{[]
 runtimecontext:()!();
 runtimecontext[`maxGeneticCycles]:1000; / number of {select+breed+mutate} cycles
 runtimecontext[`maxRuntime]:1000; / in ms
 runtimecontext[`populationSize]:1000;
 runtimecontext[`populationSelectionRate]:0.20;
 runtimecontext[`populationMutationRate]:0.05;
 runtimecontext};

\
 / unit tests
ictx:.math.geneticSolver.generateInputContext[1000];
rctx:.math.geneticSolver.generateRuntimeContext[];
result:.math.geneticSolver.run[ictx;rctx];
