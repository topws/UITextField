//
//  ViewController.swift
//  UITextFieldDemo
//
//  Created by Avazu Holding on 2019/4/9.
//  Copyright © 2019 Avazu Holding. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {

	override func viewDidLoad() {
		super.viewDidLoad()
		setupViews()
		
		// 功能一: 常用的属性设置
		setTextFieldStyle()
		
		// 功能二: UITextField继承自 UIControl类
		textField.addTarget(self, action: #selector(didChange(_:)), for: UIControl.Event.editingChanged)
		
		// 功能三: 添加系统的键盘通知
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
	}

	// MARK: - property
	let textField = UITextField()
	
	// MARK: - UITextField常用的属性设置
	private func setTextFieldStyle() {
		
		// MARK: - 添加 输入框样式
		textField.borderStyle = .roundedRect // .roundedRect经典圆角，.bezel阴影边框, .line单线条, .none无
		
		// MARK: - 添加 占位文字
		textField.placeholder = "placeholder" // 6.0后支持 attributedPlaceholder
		
		// MARK: - 输入框中是否有个叉号，在什么时候显示，用于一次性删除输入框中的内容(系统自带的UI)
		textField.clearButtonMode = .always
	
		// MARK: - 可以赋值 左视图和右视图（比如光标距离左边太近时，可以加一个LeftView），并且指定左右视图的展示模式
		let leftView = UIView()
		leftView.frame = CGRect(x: 0, y: 0, width: 10, height: 0)
		textField.leftView = leftView
		textField.leftViewMode = .always
		
		// MARK: - Keyboard mode
		textField.keyboardType = .twitter
		
		// MARK: - return键变成 什么键
		textField.returnKeyType = .search
		
		// MARK: - 光标颜色
		textField.tintColor = UIColor.orange
		
		// MARK: - 开始编辑时 是否清空TextField原有的输入内容
		textField.clearsOnBeginEditing = true
		
		// MARK: - 背景图片; 也支持: disabledBackground(禁用时的背景图片)
		textField.background = nil
		
		// MARK: - 再次编辑时 允许在内容中间插入内容
		textField.clearsOnInsertion = true
	}
	// MARK: - textField  常用代理方法
	// 将要开始编辑，返回NO 则不能编辑
	func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
		return true
	}
	// 已经开始编辑
	func textFieldDidBeginEditing(_ textField: UITextField) {
		
	}
	// 将要结束编辑时调用的方法，返回YES则可以结束编辑状态，NO则不能
	func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
		return true
	}
	// 结束编辑
	func textFieldDidEndEditing(_ textField: UITextField) {
		
	}
	// 编辑中输入字符时会调用以下方法(常用于 是否允许用户输入文字，限制输入长度(复制进来的字符串没有办法限制长度)等)
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		return true
	}
	// 点击return 键触发的方法
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		return true
	}
	// MARK: - 监听的方法
	@objc private func didChange(_ textField: UITextField) {
		// 这里做字数的限制更为准确，复制进来的字符串也可以监控到
		if let text = textField.text,text.count > 5 {
			textField.text = String(text[text.startIndex ..< text.index(text.startIndex, offsetBy: 5)])
		}
	}
	@objc private func keyboardWillChangeFrame(notification: NSNotification) {
		// 键盘的最终frame
		let rect = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]
		let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey]
		// 下面可以对 view做动画处理，达到跟系统同步动画的效果
		
		if let keyBoardFrame: CGRect = rect as? CGRect,let animationDuration: Double = duration as?
			Double {
			print(keyBoardFrame.size,animationDuration)
		}
	}
	// MARK: - setupViews
	private func setupViews() {
		view.backgroundColor = UIColor.orange
		view.addSubview(textField)
		
		textField.backgroundColor = UIColor.white
		textField.frame = CGRect.init(x: 30, y: 60, width: 280, height: 44)
		textField.delegate = self
	}
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		UIApplication.shared.keyWindow?.endEditing(false)
	}
}

