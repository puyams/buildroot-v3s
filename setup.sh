#!/bin/bash

readonly build_dir="output"
readonly buildroot_dir="buildroot"
readonly download_base="https://buildroot.org/downloads"
readonly tarext="tar.bz2"
buildroot_version="2019.02.1"

set -e

errmsg()
{
   echo -e "\nsomething went wrong!\ncheck error messages above\n"
   exit 1
}

trap "errmsg" ERR

cd "$(dirname "${0}")"

if [ -z "${1}" ]; then
   echo "Usage: ${0} <relative_path_to_config> (additional layer dirs)"
   echo "Available configs are:"
   ls -1 */configs/*_defconfig 2>/dev/null
   echo "Additional layers are:"
   ls -1 */Config.in | sed 's,/Config.in,,g' | tr '\n' ' ' | fold -s ; echo
   dl_dir="$(grep -l '^BR2_DL_DIR=' */configs/*_defconfig || true)"
   if [ -n "${dl_dir}" ]; then
      sed -i -e '/^BR2_DL_DIR=/d' ${dl_dir}
   fi
   exit 0
fi

dl_dir="${PWD}/dl"
defconfig_full="${1}"
defconfig="${defconfig_full##*/}"
configname="${defconfig%_defconfig}"
shift

output_dir="${PWD}/${build_dir}/${configname}"
layer_dir="${PWD}/${defconfig_full%/configs/*}"

if [ -f "${layer_dir}/buildroot.version" ]; then
   buildroot_version="$(cat "${layer_dir}/buildroot.version")"
   buildroot_version="${buildroot_version#buildroot-}"
fi

[ -d "${buildroot_dir}" ] || mkdir "${buildroot_dir}"

if [ ! -d "${buildroot_dir}/buildroot-${buildroot_version}" ]; then
   oldpwd="${PWD}"
   cd "${buildroot_dir}"
   if [ ! -f "buildroot-${buildroot_version}.${tarext}" ]; then
      wget "${download_base}/buildroot-${buildroot_version}.${tarext}"
   fi
   tar xf "buildroot-${buildroot_version}.${tarext}"
   cd "${oldpwd}"
fi

layer_dirs="${layer_dir}"
for extra_layer; do
   extra_layer="$(readlink -f "${extra_layer}")"
   if [ ! -f "${extra_layer}/Config.in" -o \
        ! -f "${extra_layer}/external.mk" -o \
        ! -f "${extra_layer}/external.desc" ]; then
      echo "can't add layer ${extra_layer}: core file(s) missing"
      exit 1
   else
      layer_dirs="${layer_dirs}:${extra_layer}"
   fi
done

sed -i -e '/^BR2_DL_DIR=/d' "${defconfig_full}"
make O="${output_dir}" BR2_EXTERNAL="${layer_dir}" -C "${buildroot_dir}/buildroot-${buildroot_version}" "${defconfig}"
# is there a better way than patching ".config"?
sed -i "${output_dir}/.config" \
    -e "s|^BR2_DL_DIR=.*|BR2_DL_DIR=\"${dl_dir}\"|"

echo "all set, go to \"${output_dir#${PWD}/}\" and run \"make all\""
if [ -x "/usr/bin/dpkg" ]; then
   dpkg --get-selections | grep -q ^libelf-dev || echo "you should install \"libelf-dev\""
fi
