# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

def share_resources
  pod 'Firebase/Core'
  pod 'Firebase/Database'
  pod 'Firebase/Auth'
  pod 'Firebase/Storage'
  pod 'Firebase/Messaging'
  pod "TPKeyboardAvoidingSwift"
  pod 'SDWebImage', '~> 4.0'
  pod 'Firebase/Functions'
  
  pod 'SwiftEntryKit'
end

def user_pod
  pod 'JTAppleCalendar', '~> 7.0'
end



target 'Trainer' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
share_resources
  # Pods for Trainer

  target 'TrainerTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'TrainerUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end

target 'User' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  share_resources
  user_pod
  # Pods for User

  target 'UserTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'UserUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
