//
//  ViewController.swift
//  GetHealthStep
//
//  Created by ADMIN on 17/6/16.
//  Copyright © 2017年 ADMIN. All rights reserved.
//

import UIKit
import HealthKit
class ViewController: UIViewController {
    //必须要在plist文件配置权限操作，不然在iOS10 以上系统会崩溃
    
    var healthStore: HKHealthStore!
    
    
    fileprivate lazy var stepLabel: UILabel = {
        let stepLabel = UILabel();
        stepLabel.textAlignment = .center;
        return stepLabel;
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        getAuthorization();
        
        view.addSubview(stepLabel);
        stepLabel.frame = CGRect(x: 100, y: 100, width: 100, height: 100);
    }

    fileprivate func getAuthorization(){
        //判断是否支持
        if HKHealthStore.isHealthDataAvailable() == false {
            return;
        }
        //创建healthStore对象
        self.healthStore = HKHealthStore();
        //只获取步数这一种类型数据
        let stepType = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount);
        let healthSet = Set<HKObjectType>(arrayLiteral: stepType!);
        //请求授权
        self.healthStore.requestAuthorization(toShare: nil, read: healthSet) { (success, error) in
            //成功
            if success == true{
                self.getUserStep();
            }
        }
        
    }
    //获取步数
    
    fileprivate func getUserStep(){
        
        let sampleType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount);
        //健康数据按照时间排序
        let start = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false);
        let end = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false);
        
        let now = Date();
        let calender = Calendar.current;
        //放入组成日期的成分单位
        let coms = Set<Calendar.Component>(arrayLiteral: Calendar.Component.year,Calendar.Component.month,Calendar.Component.day,Calendar.Component.hour,Calendar.Component.minute,Calendar.Component.second);
      let dataComponent = calender.dateComponents(coms, from: now);
        
        let hour = dataComponent.hour;
        let minute = dataComponent.minute;
        let second = dataComponent.second;
        
        let nowDay = Date(timeIntervalSinceNow: -Double(hour!*3600 + minute! * 60 + second!));
        let nextDay = Date(timeIntervalSinceNow: -Double(hour!*3600 + minute! * 60 + second!) + 86400);
        
        let predicate = HKQuery.predicateForSamples(withStart: nowDay, end: nextDay, options: [HKQueryOptions.init(rawValue: 0)]);
        
        let sampleQuery = HKSampleQuery(sampleType: sampleType!, predicate: predicate, limit: 0, sortDescriptors: [start,end]) { (query, results, error) in
            var allStep = 0;
            guard let results = results else{
                return;
            }
            for i in 0..<results.count{
                let result = results[i] as? HKQuantitySample
                let quantity = result?.quantity
                if let quantity = quantity{
                    let strStep = "\(quantity)"
                    let step = strStep.components(separatedBy: " ")[0];
                    allStep = allStep + Int(step)!;
                }
                
               
            }
            //回到主线程
            OperationQueue.main.addOperation({ 
                self.stepLabel.text = "\(allStep)步";
            })
            
        }
        
        self.healthStore.execute(sampleQuery);
        
        
    }
   

}

