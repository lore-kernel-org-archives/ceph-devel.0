From: Danny Kukawka <danny.kukawka@bisect.de>
Subject: =?UTF-8?q?=5BPATCH=5D=20fix=20keyring=20generation=20for=20mds=20and=20osd?=
Date: Thu, 16 Aug 2012 12:56:58 +0200
Message-ID: <1345114618-3464-1-git-send-email-danny.kukawka@bisect.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:51517 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755254Ab2HPK5C (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Thu, 16 Aug 2012 06:57:02 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Danny Kukawka <dkukawka@suse.de>

=46ix config keys for OSD/MDS data dirs. As in documentation and other
places of the scripts the keys are 'osd data'/'mds data' and not
'osd_data'

In case if MDS: if 'mds data' doesn't exist, create it.

Signed-off-by: Danny Kukawka <danny.kukawka@bisect.de>
---
 src/mkcephfs.in |    5 +++--
 1 Datei ge=C3=A4ndert, 3 Zeilen hinzugef=C3=BCgt(+), 2 Zeilen entfernt=
(-)

diff --git a/src/mkcephfs.in b/src/mkcephfs.in
index 402c870..7ab6664 100644
--- a/src/mkcephfs.in
+++ b/src/mkcephfs.in
@@ -251,14 +251,15 @@ if [ -n "$initdaemon" ]; then
     if [ $type =3D "osd" ]; then
 	$BINDIR/ceph-osd -c $conf --monmap $dir/monmap -i $id --mkfs --mkkey
=20
-	get_conf osd_data "/var/lib/ceph/osd/ceph-$id" "osd_data"
+	get_conf osd_data "/var/lib/ceph/osd/ceph-$id" "osd data"
 	get_conf osd_keyring "$osd_data/keyring" "keyring"
 	$BINDIR/ceph-authtool -p -n $name $osd_keyring > $dir/key.$name
     fi
    =20
     if [ $type =3D "mds" ]; then
-	get_conf mds_data "/var/lib/ceph/mds/ceph-$id" "mds_data"
+	get_conf mds_data "/var/lib/ceph/mds/ceph-$id" "mds data"
 	get_conf mds_keyring "$mds_data/keyring" "keyring"
+	test -d $mds_data || mkdir -p $mds_data
 	echo "creating private key for $name keyring $mds_keyring"
 	$BINDIR/ceph-authtool --create-keyring --gen-key -n $name $mds_keyrin=
g
 	$BINDIR/ceph-authtool -p -n $name $mds_keyring > $dir/key.$name
--=20
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
