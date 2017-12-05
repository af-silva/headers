#!/bin/bash
# Software License Agreement (BSD)
#
# Author    Mike Purvis <mpurvis@clearpathrobotics.com>
# Copyright (c) 2013, Clearpath Robotics, Inc., All rights reserved.
#
# Redistribution and use in source and binary forms, with or without modification, are permitted provided that the
# following conditions are met:
# * Redistributions of source code must retain the above copyright notice, this list of conditions and the following
#   disclaimer.
# * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following
#   disclaimer in the documentation and/or other materials provided with the distribution.
# * Neither the name of Clearpath Robotics nor the names of its contributors may be used to endorse or promote products
#   derived from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
# INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

HEADERS_BASE_PATH=${HOME}/.headers

if [ -d "$HEADERS_BASE_PATH" ]; then
  cd "$HEADERS_BASE_PATH"
  git remote -v | grep -q origin.*github\.com/clearpathrobotics/headers
  if [ "$?" == "0" ]; then
    echo "Repo already present in $HEADERS_BASE_PATH, skipping clone."
  else
    echo "Path $HEADERS_BASE_PATH, but is not a clone of this repo."
    echo "Back up and remove previous $HEADERS_BASE_PATH folder and run setup script again."
    exit 1
  fi
else
  echo "Cloning repo to $HEADERS_BASE_PATH"
  git clone https://github.com/clearpathrobotics/headers $HEADERS_BASE_PATH
fi

if [ ! -d "${HOME}/bin" ]; then
    echo "Creating ~/bin"
    mkdir ${HOME}/bin
    echo "Warning: Because ~/bin did not already exist, you will need to log out and in again for it to be on your PATH."
fi
echo "Creating ~/bin/use_headers"
cat << EOF > ${HOME}/bin/use_headers
HEADERS_BASE_PATH="$HEADERS_BASE_PATH" $HEADERS_BASE_PATH/use_headers \$*
EOF
chmod +x ${HOME}/bin/use_headers

echo "You may need to log out and in again for ~/bin to be added to your path."
