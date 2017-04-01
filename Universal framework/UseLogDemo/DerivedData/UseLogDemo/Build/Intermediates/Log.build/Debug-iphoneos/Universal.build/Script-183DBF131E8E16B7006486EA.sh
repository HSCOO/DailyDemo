#!/bin/sh
framework_name="${PROJECT_NAME}"
smiulator_path="${BUILD_DIR}/${CONFIGURATION}-iphonesimulator/${framework_name}.framework"
device_path="${BUILD_DIR}/${CONFIGURATION}-iphoneos/${framework_name}.framework"
universal_dir="${BUILD_DIR}/${CONFIGURATION}-iphoneuniversal"
universal_path="${universal_dir}/${framework_name}.framework"

echo "#######################"

xcodebuild -arch x86_64 -sdk iphonesimulator -configuration Debug clean build
xcodebuild -sdk iphoneos -configuration Debug clean build

rm -rf "${universal_dir}"
mkdir "${universal_dir}"
mkdir "${universal_path}"
echo "###########${CONFIGURATION_BUILD_DIR}############"
echo "${CONFIGURATION_BUILD_DIR}"

cp -r "${device_path}/." "${universal_path}"

lipo "${smiulator_path}/${framework_name}" "${device_path}/${framework_name}" -create -output "${universal_path}/${framework_name}"

