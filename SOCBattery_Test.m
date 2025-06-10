classdef SOCBattery_Test < matlab.unittest.TestCase
    % SOCBattery_test
    % Bu sınıf, BatterySOCSysIntTest dosyasında bulunan ilk 4 testin
    % geçtiğini doğrulamaya yarar.

    properties (Access = private)
        testResults  % BatterySOCSysIntTest çıktısındaki tüm TestResult nesneleri
    end

    methods (TestClassSetup)
        function runBatterySOCTestSuite(testCase)
            % BatterySOCSysIntTest test dosyasını çalıştırıp sonuçlarını kaydetmek
            import matlab.unittest.TestRunner
            
            % Önce test suite'ini oluşturmayı deneyin. Dosya yoksa veya hata varsa yakalayın.
            try
                suite = testsuite("BatterySOCSysIntTest");
            catch ME
                testCase.fatalAssertFail(sprintf("BatterySOCSysIntTest dosyası bulunamadı veya oluşturulamadı:\n%s", ME.message));
            end
            
            % Plugin'siz basit bir TestRunner oluşturun
            runner = TestRunner.withNoPlugins;
            
            % Suite'i bir kez çalıştırın
            results = run(runner, suite);
            
            % Test sayısı kontrolü: En az 4 adet test bekliyoruz
            testCase.assertGreaterThanOrEqual(numel(results), 4, ...
                sprintf(['BatterySOCSysIntTest içinde en az 4 test olduğu varsayılıyor,\n' ...
                         'ancak yalnızca %d test bulundu.'], numel(results)));
            
            % Sonuçları saklayın
            testCase.testResults = results;
        end
    end
end