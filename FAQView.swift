import SwiftUI

struct FAQView: View {
    @Environment(\.presentationMode) var presentationMode
    
    // 定义FAQ问题数组
    let faqs = [
        FAQ(question: "如何测量血压？", 
            answer: "血压测量应在安静环境下进行，测量前30分钟避免剧烈运动、吸烟和饮用咖啡因饮料。测量时保持坐姿，上臂与心脏同高，袖带应紧贴上臂。建议每次测量3次，间隔1-2分钟，取平均值。"),
        
        FAQ(question: "为什么会有不同的血压结果？", 
            answer: "血压值会受到多种因素影响，包括测量时间、身体姿势、情绪状态、测量设备以及测量技术。建议在固定时间段测量并记录，以便更准确地了解血压趋势。"),
        
        FAQ(question: "什么是正常血压范围？", 
            answer: "正常血压范围通常是收缩压90-120 mmHg，舒张压60-80 mmHg。收缩压120-129且舒张压低于80被视为血压偏高，收缩压130-139或舒张压80-89被视为一级高血压。"),
        
        FAQ(question: "服用降压药应该注意什么？", 
            answer: "应严格按医嘱服药，不可擅自停药或调整剂量。服药时间应固定，并避免与某些食物（如葡萄柚）同时服用。如出现不适，应及时咨询医生，而非自行更改用药。"),
        
        FAQ(question: "如何导出我的血压数据？", 
            answer: "在主页"我的记录"界面右上角，点击导出按钮，选择导出格式（CSV或PDF），然后选择导出时间范围，系统将生成相应格式的报告供您保存或分享。"),
        
        FAQ(question: "拍照识别功能如何使用？", 
            answer: "在添加记录页面点击相机图标，将手机对准血压仪显示屏，确保数字清晰可见且在取景框内，系统将自动识别收缩压、舒张压和心率值。识别后可手动修正不准确的数值。"),
        
        FAQ(question: "如何设置血压测量提醒？", 
            answer: "在"设置"页面中选择"测量提醒"，点击添加新提醒，设置提醒时间和重复周期，还可以添加标签和备注。开启后系统会在指定时间发送通知提醒您测量血压。"),
        
        FAQ(question: "如何恢复已删除的记录？", 
            answer: "会员用户可在设置中找到"数据备份"选项，点击"恢复数据"并选择之前的备份点进行恢复。非会员用户一旦删除记录将无法恢复，请谨慎操作。"),
        
        FAQ(question: "我可以在多个设备上同步我的数据吗？", 
            answer: "会员用户可通过数据备份功能将数据备份到iCloud，然后在其他已登录相同Apple ID的设备上恢复数据。您也可以使用导出功能将数据手动传输到其他设备。"),
        
        FAQ(question: "应用占用的存储空间会随时间增长吗？", 
            answer: "随着记录数量增加，应用占用的存储空间会略有增长，但我们对数据进行了优化以减少占用。如有需要，可以在应用中导出数据后删除旧记录来释放空间。")
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // 页面标题
                    Text("常见问题")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                        .padding(.top, 10)
                    
                    // FAQ列表
                    VStack(alignment: .leading, spacing: 16) {
                        ForEach(faqs) { faq in
                            FAQItem(faq: faq)
                        }
                    }
                    .padding(.horizontal)
                    
                    // 分隔线
                    Divider()
                        .padding(.vertical, 20)
                    
                    // 联系我们部分
                    VStack(alignment: .leading, spacing: 12) {
                        Text("联系我们")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                        
                        VStack(alignment: .leading, spacing: 10) {
                            ContactRow(icon: "envelope.fill", text: "邮箱：support@xyrj-app.com")
                            ContactRow(icon: "globe", text: "网站：https://xyrj-app.com")
                            ContactRow(icon: "wechat", text: "微信公众号：血压日记助手")
                            ContactRow(icon: "phone.fill", text: "电话：+86 123-4567-8910")
                        }
                        .padding(.horizontal)
                        
                        Text("我们的技术支持团队将在24小时内回复您的咨询。")
                            .font(.callout)
                            .foregroundColor(.secondary)
                            .padding(.horizontal)
                            .padding(.top, 5)
                    }
                    
                    // 版权信息
                    Text("© 2023-2024 血压日记. 保留所有权利。")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top, 30)
                        .padding(.bottom, 20)
                }
                .padding(.bottom, 30)
            }
            .navigationBarTitle("常见问题", displayMode: .inline)
            .navigationBarItems(trailing: Button("完成") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

// FAQ数据模型
struct FAQ: Identifiable {
    let id = UUID()
    let question: String
    let answer: String
}

// FAQ展示组件
struct FAQItem: View {
    let faq: FAQ
    @State private var isExpanded = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Button(action: {
                withAnimation {
                    isExpanded.toggle()
                }
            }) {
                HStack {
                    Text(faq.question)
                        .font(.headline)
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.leading)
                    
                    Spacer()
                    
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .foregroundColor(.blue)
                        .font(.system(size: 14))
                }
            }
            
            if isExpanded {
                Text(faq.answer)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .padding(.top, 5)
                    .transition(.opacity)
            }
        }
        .padding()
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(10)
    }
}

// 联系方式行组件
struct ContactRow: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundColor(.blue)
                .frame(width: 24, height: 24)
            
            Text(text)
                .foregroundColor(.primary)
        }
        .padding(.vertical, 5)
    }
}

struct FAQView_Previews: PreviewProvider {
    static var previews: some View {
        FAQView()
    }
} 