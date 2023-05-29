//
//  ProjData.swift
//  AsiadCal
//
//  Created by viglong on 2023/5/29.
//

import Foundation

struct projData{
    var id: Int
    var name: String
    var gifurl: String
}

class ProjDataList: ObservableObject{
    @Published var projDatas: [projData] = []
    static func sampleData() -> ProjDataList {
        let sample = ProjDataList()
        
        sample.projDatas.append(projData(id: 0,name: "Athletics", gifurl: "https://www.hangzhou2022.cn/ztzl/dttytbfb/jjxbs/202208/W020220805807613317373.gif"))
        sample.projDatas.append(projData(id: 1,name: "Basketball", gifurl: "https://www.hangzhou2022.cn/ztzl/dttytbfb/qlbs/202208/W020220805587978971301.gif"))
        sample.projDatas.append(projData(id: 2,name: "CyclingRoad", gifurl: "https://www.hangzhou2022.cn/ztzl/dttytbfb/jjxbs/202208/W020220805771109311867.gif"))
        sample.projDatas.append(projData(id: 3,name: "Football", gifurl: "https://www.hangzhou2022.cn/ztzl/dttytbfb/qlbs/202208/W020220805589265300531.gif"))
        sample.projDatas.append(projData(id: 4,name: "CyclingMTB", gifurl: "https://www.hangzhou2022.cn/ztzl/dttytbfb/jjxbs/202208/W020220805803130683224.gif"))
        sample.projDatas.append(projData(id: 5,name: "Boxing", gifurl: "https://www.hangzhou2022.cn/ztzl/dttytbfb/bkxbs/202208/W020220805747575623328.gif"))
        sample.projDatas.append(projData(id: 6,name: "Fencing", gifurl: "https://www.hangzhou2022.cn/ztzl/dttytbfb/bkxbs/202208/W020220805483535625149.gif"))
        sample.projDatas.append(projData(id: 7,name: "CanoeSlalom", gifurl: "https://www.hangzhou2022.cn/ztzl/dttytbfb/ssbs/202208/W020220805570232698924.gif"))
        sample.projDatas.append(projData(id: 8,name: "DragonBoat", gifurl: "https://www.hangzhou2022.cn/ztzl/dttytbfb/ssbs/202208/W020220805567680445570.gif"))
        sample.projDatas.append(projData(id: 9,name: "Swimming", gifurl: "https://www.hangzhou2022.cn/ztzl/dttytbfb/ssbs/202208/W020220805574993310092.gif"))
        sample.projDatas.append(projData(id: 10,name: "RugbySevens", gifurl: "https://www.hangzhou2022.cn/ztzl/dttytbfb/qlbs/202208/W020220805582367526825.gif"))
        sample.projDatas.append(projData(id: 11,name: "TableTennis", gifurl: "https://www.hangzhou2022.cn/ztzl/dttytbfb/qlbs/202208/W020220805581520018480.gif"))
        
        return sample
    }
}
