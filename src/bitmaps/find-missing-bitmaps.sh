#!/usr/bin/env bash
#
# Description:
#   A script to quickly find files which should have been generated but aren't
#
# Legal Stuff:
#
# This script is free software; you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation; version 3.
#
# This script is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
# details.
#
# You should have received a copy of the GNU General Public License along with
# this program; if not, see <https://www.gnu.org/licenses/gpl-3.0.txt>
set -euo pipefail
IFS=$'\n\t'

cd "$(dirname "${BASH_SOURCE[0]}")"
DIR=$( pwd -P )

THEME="Moka"
SIZES=("8x8" "16x16" "22x22" "24x24" "32x32" "48x48" "64x64" "96x96" "256x256")

for BITMAP in */*.svg; do
        CONTEXT=$(hxselect -c '#context tspan' < "$DIR/$BITMAP");
        ICON_NAME=$(hxselect -c '#icon-name tspan' < "$DIR/$BITMAP");
        for SIZE in "${SIZES[@]}"; do
                if [ $(hxselect -c "#rect$SIZE" < "$DIR/$BITMAP" | head -c1 | wc -c) -ne 0 ]; then
                        if [ ! -f "$DIR/../../$THEME/$SIZE/$CONTEXT/$ICON_NAME.png" ]; then
                                echo "$THEME/$SIZE/$CONTEXT/$ICON_NAME.png"
                        fi
                        if [ ! -f "$DIR/../../$THEME/$SIZE@2x/$CONTEXT/$ICON_NAME.png" ]; then
                                echo "$THEME/$SIZE@2x/$CONTEXT/$ICON_NAME.png"
                        fi
                fi
        done
done
