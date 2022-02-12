#!/bin/bash
PKGSCRIPT="$(dirname "$(readlink -f ${BASH_SOURCE[0]})")/fmakepkg.sh"
DIR="$(dirname "$(readlink -f ${BASH_SOURCE[0]})")/aeon.mover.priority"
TMPDIR=/tmp/tmp.$(( $RANDOM * 19318203981230 + 40 ))
PLUGIN=$(basename ${DIR})
ARCHIVE="$(dirname $(dirname ${DIR}))/archive"
DESTDIR="$TMPDIR/usr/local/emhttp/plugins/${PLUGIN}"
PLG_FILE="$(dirname $(dirname ${DIR}))/plugins/${PLUGIN}.plg"
VERSION=$(date +"%Y.%m.%d")
ARCH="-x86_64"
PACKAGE="${ARCHIVE}/${PLUGIN}-${VERSION}${ARCH}.txz"
MD5="${ARCHIVE}/${PLUGIN}-${VERSION}${ARCH}.md5"

echo $PKGSCRIPT

for x in '' a b c d e d f g h i j k l m n o p q r s t u v w x y z; do
    PKG="${ARCHIVE}/${PLUGIN}-${VERSION}${x}${ARCH}.txz"
    echo "Looking for  ${PKG}"
    if [[ ! -f $PKG ]]; then
      PACKAGE=$PKG
      VERSION="${VERSION}${x}"
      MD5="${ARCHIVE}/${PLUGIN}-${VERSION}${ARCH}.md5"
      break
    fi
done

mkdir -p "${TMPDIR}/"
cd "$DIR"
cp --parents -f $(find . -type f ! \( -iname "pkg_build.sh" -o -iname "sftp-config.json" -o -iname ".DS_Store"  \) ) "${TMPDIR}/"
cd "$TMPDIR/"
$PKGSCRIPT -l y -c y "${PACKAGE}"
cd "$ARCHIVE/"
md5sum $(basename "$PACKAGE") > "$MD5"
rm -rf "$TMPDIR"

# Verify and install plugin package
sum1=$(md5sum "${PACKAGE}")
sum2=$(cat "$MD5")
if [ "${sum1:0:32}" != "${sum2:0:32}" ]; then
  echo "Checksum mismatched.";
  rm "$MD5" "${PACKAGE}"
else
  echo "Checksum matched."
fi
