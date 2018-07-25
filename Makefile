#!/usr/bin/make -f
# SPDX-License-Identifier: MPL-2.0
#{
# Copyright 2018-present Samsung Electronics France SAS, and other contributors
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.*
#}

default: help

topdir?=${CURDIR}
extra_dir?=${topdir}/tmp

arduino_version?=1.8.5
arduino_host?=linux32
arduino_url?=https://downloads.arduino.cc/arduino-${arduino_version}-${arduino_host}.tar.xz
ARDUINO_DIR?=${extra_dir}/arduino-${arduino_version}

arduino_mk_url?=https://github.com/sudar/Arduino-Makefile
ARDMK_DIR?=${extra_dir}/arduino-mk

help:
	@echo "# Usage:"
	@echo "# make rule/setup"
	@echo "# make rule/all"

${ARDUINO_DIR}:
	mkdir -p ${@D}
	cd ${@D} && curl ${arduino_url} | tar -xJ

rule/arduino_dir: ${ARDUINO_DIR}
	ls $<

${ARDMK_DIR}:
	mkdir -p ${@D}
	git clone --recursive --depth 1 ${arduino_mk_url} $@

rule/arduino_mk_dir: ${ARDMK_DIR}
	ls $<

#{ Libraries
USER_LIB_PATH?=${extra_dir}/Arduino/libraries

ArduinoJson_url?=https://github.com/bblanchon/ArduinoJson
ArduinoJson_dir?=${extra_dir}/Arduino/libraries/ArduinoJson

${ArduinoJson_dir}:
	mkdir -p ${@D}
	git clone --depth 1 --recursive ${ArduinoJson_url} $@

ArduinoMDNS_url=https://github.com/arduino-libraries/ArduinoMDNS
ArduinoMDNS_dir?=${extra_dir}/Arduino/libraries/ArduinoMDNS

${ArduinoMDNS_dir}:
	mkdir -p ${@D}
	git clone --depth 1 --recursive ${ArduinoMDNS_url} $@

rule/arduino_lib_dirs: ${ArduinoMDNS_dir} ${ArduinoJson_dir}
	ls $^
#}

rule/setup: rule/arduino_dir rule/arduino_mk_dir rule/arduino_lib_dirs
	sync

rule/all: $(wildcard examples/*/Makefile | sort)
	for file in $^; do \
 dirname=$$(dirname -- "$${file}") ; ${MAKE} -C $${dirname}; \
 done
