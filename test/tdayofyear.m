classdef tdayofyear < matlab.unittest.TestCase

    methods (TestMethodSetup)
        function setupPath(testCase)
            import matlab.unittest.fixtures.PathFixture
            testCase.applyFixture(PathFixture("../src"));
        end
    end

    methods (Test)

        function testNonLeapYear(testCase)
            % Create non-leap year date of March 1st, 2021
            dateStr = '03/01/2021';

            % Calculate expected result
            dt = datetime(dateStr,'Format','MM/dd/uuuu');
            doyExpected = day(dt,'dayofyear');

            % Get actual result
            doyActual = dayofyear(dateStr);

            % Verify that the two are equal
            testCase.verifyEqual(doyActual,doyExpected)
        end

        function testLeapYear(testCase)
            % Create leap year date of March 1st, 2020
            dateStr = '03/01/2020';

            % Calculate expected result
            dt = datetime(dateStr,'Format','MM/dd/uuuu');
            doyExpected = day(dt,'dayofyear');

            % Get actual result
            doyActual = dayofyear(dateStr);

            % Verify that the two are equal
            testCase.verifyEqual(doyActual,doyExpected)
        end

        function testInvalidDateFormat(testCase)
            % Create invalid date of April 1st, 2021
            dateStr = '04-01-2021';

            % Verify that our function throws an error
            testCase.verifyError(@() dayofyear(dateStr),'dayofyear:InvalidDateFormat');
        end

        function testCorrectDateFormatButInvalidDate(testCase)
            % Create invalid date of February 30th, 2021
            dateStr = '02/30/2021';

            % Verify that our function throws an error
            testCase.verifyError(@() dayofyear(dateStr),'MATLAB:datetime:ParseErr');
        end

%         function testAlternateDateFormat(testCase)
%             % Create date of April 1st, 2021 in alternate date format
%             dateStr = '01/04/2021';
%             dateFormat = 'dd/mm/yyyy';
% 
%             % Calculate expected result
%             dt = datetime(dateStr,'Format','dd/MM/uuuu');
%             doyExpected = day(dt,'dayofyear');
% 
%             % Get actual result
%             doyActual = dayofyear(dateStr,dateFormat);
% 
%             % Verify that the two are equal
%             testCase.verifyEqual(doyActual,doyExpected)
%         end
        
    end

end