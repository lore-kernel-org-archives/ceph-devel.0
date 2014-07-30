From: "Xue, Chendi" <chendi.xue@intel.com>
Subject: [PATCH]init-ceph: Adding do_cmd_okfail when calling
 ceph-crush-location
Date: Wed, 30 Jul 2014 00:55:13 +0000
Message-ID: <C8CF870384EBCF4CAB89D2041A5C80B301135242@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:47993 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754572AbaG3Azm convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 Jul 2014 20:55:42 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

=46rom 797dbf4f027200bb22ba89d2f616e254321ec023 Mon Sep 17 00:00:00 200=
1
=46rom: Chendi Xue <chendi.xue@intel.com>
Date: Tue, 29 Jul 2014 16:45:45 +0800
Subject: [PATCH 8/8] Adding do_cmd_okfail when calling ceph-crush-locat=
ion

Original init-ceph doesn't use do_cmd_okfail when getting osd_location,=
 which
results in osds wrong mapping( verified by using "ceph osd tree" )

Signed-off-by: Chendi Xue <chendi.xue@intel.com>
---
src/init-ceph.in | 2 +-
1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/init-ceph.in b/src/init-ceph.in
index 86eb87f..09c7cbc 100644
--- a/src/init-ceph.in
+++ b/src/init-ceph.in
@@ -327,7 +327,7 @@ for name in $what; do
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 if [ "${update_crush:-1}" =3D "1" -o "${update_crush=
:-1}" =3D "true" ]; then
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0# update location in crush
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0get_conf osd_location_hook "$BINDIR/ceph=
-crush-location" "osd crush location hook"
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 =A0=A0=A0 osd_location=3D`$osd_location_hook --cluster =
ceph --id $id --type osd`
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 =A0=A0=A0 osd_location=3D$(do_cmd_okfail "$osd_location_ho=
ok --cluster ceph --id $id --type osd")
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0get_conf osd_weight "" "osd crush initia=
l weight"
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0defaultweight=3D"$(df -P -k $osd_data/. =
| tail -1 | awk '{ print sprintf("%.2f",$2/1073741824) }')"
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0get_conf osd_keyring "$osd_data/keyring"=
 "keyring"
--=20
1.9.1


Best Regards,
-Chendi

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
