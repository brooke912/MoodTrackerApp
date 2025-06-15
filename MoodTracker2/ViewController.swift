//
//  ViewController.swift
//  MoodTracker2
//
//  Created by Brooke Gates on 6/15/25.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - UI Elements
    let moodLabel = UILabel()
    let moodSlider = UISlider()
    let datePicker = UIDatePicker()
    let saveButton = UIButton(type: .system)
    let savedMoodLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemPink.withAlphaComponent(0.15) // PINKKKK
        setupUI() //
    }

    // MARK: - Setup UI
    func setupUI() {
        let heartBackground = UIImageView(image: UIImage(named: "cute wallpaper"))
            heartBackground.translatesAutoresizingMaskIntoConstraints = false
        heartBackground.contentMode = .scaleAspectFill
                heartBackground.clipsToBounds = true
                view.addSubview(heartBackground)
                view.sendSubviewToBack(heartBackground)

        NSLayoutConstraint.activate([
                    heartBackground.topAnchor.constraint(equalTo: view.topAnchor),
                    heartBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                    heartBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    heartBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        //First Label
        moodLabel.text = "Happy? 😊"
        moodLabel.font = UIFont.systemFont(ofSize: 34, weight: .heavy)
        moodLabel.textColor = .systemPink
        moodLabel.textAlignment = .center
        moodLabel.adjustsFontSizeToFitWidth = true
        moodLabel.minimumScaleFactor = 0.5
        moodLabel.numberOfLines = 2

        // The PINK slider
        moodSlider.minimumValue = 0
        moodSlider.maximumValue = 100
        moodSlider.value = 50
        moodSlider.tintColor = .systemPink
        moodSlider.addTarget(self, action: #selector(sliderChanged(_:)), for: .valueChanged)

        // The Date Picker
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels

        //The Save Button
        saveButton.setTitle("💾 Save Mood 💖", for: .normal)
        saveButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        saveButton.addTarget(self, action: #selector(saveMood), for: .touchUpInside)

        // The MOOD Label
        savedMoodLabel.text = ""
        savedMoodLabel.textColor = .systemPink
        savedMoodLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        savedMoodLabel.textAlignment = .center
        savedMoodLabel.numberOfLines = 2
        savedMoodLabel.adjustsFontSizeToFitWidth = true
        savedMoodLabel.minimumScaleFactor = 0.5
        savedMoodLabel.lineBreakMode = .byWordWrapping

        // Stack View
        let stackView = UIStackView(arrangedSubviews: [
            moodLabel, moodSlider, datePicker, saveButton, savedMoodLabel
        ])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stackView)

        // Constraints
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }

    // MARK: - Mood Logic
    @objc func sliderChanged(_ sender: UISlider) {
        let moodValue = Int(sender.value)
        moodLabel.text = moodDescription(for: moodValue)
    }

    func moodDescription(for value: Int) -> String {
        switch value {
        case 0...20:
            return "Very Sad😢 - You want to talk about it?"
        case 21...40:
            return "Sad🙁 - Hope it gets better!"
        case 41...60:
            return "Neutral😐 - only vibing"
        case 61...80:
            return "Happy🙂- YAYY for good days!"
        case 81...100:
            return "Very Happy😄- Love that for you💕"
        default:
            return "Neutral😐"
        }
    }

    @objc func saveMood() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        let dateText = formatter.string(from: datePicker.date)
        let moodText = moodLabel.text ?? ""
        savedMoodLabel.text = "On \(dateText), you felt \(moodText)"
    }
}
