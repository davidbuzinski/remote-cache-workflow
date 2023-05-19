function plan = buildfile

plan = buildplan(localfunctions);
plan("lint").Inputs = "src";
plan("mex").Inputs = "mex/convec.c";
plan("mex").Outputs = "build/convec." + mexext;
plan("test").Inputs = ["src", "test", plan("mex").Outputs];
plan.DefaultTasks = ["lint", "test"];
end

function mexTask(ctx)
for f = ctx.Task.Inputs.paths
    mex(f, "-outdir", "build/");
end
end

function lintTask(ctx)
% Identify code issues
codeResults = codeIssues(ctx.Task.Inputs.paths);

errInd = codeResults.Issues.Severity == "error";
if any(errInd)
    disp(" ");
    disp("FAILED! Found critical errors in your code:");
    disp(codeResults.Issues(errInd,:));
    disp(" ");

    errMsg = "Code Analyzer found critical errors in your code." + newline + ...
        "Please see diagnostics above.";
    error(errMsg);
end
end

function testTask(ctx)
% Run all tests
results = runtests("test", ...
    IncludeSubfolders = true, ...
    OutputDetail = "terse");
results.assertSuccess;
end