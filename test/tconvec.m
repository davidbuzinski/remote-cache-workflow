classdef tconvec < matlab.unittest.TestCase
    methods (Test)
        % Test methods 

        function convecTest(testCase)
            import matlab.unittest.fixtures.PathFixture
            testCase.applyFixture(PathFixture("../build"));
            x = [3-1i, 4+2i, 7-3i];
            y = [8-6i, 12+16i, 40-42i];
            testCase.verifyEqual(convec(x,y), conv(x,y), "Mex implmentation of convolution does not match MATLAB builtin");
        end
    end

end
