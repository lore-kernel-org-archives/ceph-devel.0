From: Smart Weblications GmbH - Florian Wiessner
	<f.wiessner@smart-weblications.de>
Subject: cannot ceph-osd -i 1 --mkfs - mkfs: BTRFS_IOC_SUBVOL_CREATE failed
 with error (22) Invalid argument
Date: Sun, 26 Aug 2012 23:44:53 +0200
Message-ID: <503A98D5.8010908@smart-weblications.de>
Reply-To: f.wiessner@smart-weblications.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx04.smart-weblications.de ([188.65.144.39]:60689 "EHLO
	mx04.smart-weblications.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752773Ab2HZVpC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Sun, 26 Aug 2012 17:45:02 -0400
Received: from office.smart-weblications.net (office.smart-weblications.net [91.204.168.193])
	by mx04.smart-weblications.de (Postfix) with ESMTPA id 4F559278624C
	for <ceph-devel@vger.kernel.org>; Sun, 26 Aug 2012 21:45:00 +0000 (UTC)
Received: from [192.168.201.110] (unknown [192.168.201.110])
	by office.smart-weblications.net (Postfix) with ESMTPA id 76FC95A17AF
	for <ceph-devel@vger.kernel.org>; Sun, 26 Aug 2012 23:44:59 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi List,

i try to recreate osd on ext4 after a crash:

node02:/data/ceph_backend# ceph --version
ceph version 0.51 (commit:c03ca95d235c9a072dcd8a77ad5274a52e93ae30)

node02:/data/ceph_backend# ceph-osd -c /etc/ceph/ceph.conf -i 1 --mkfs =
--monmap
/tmp/monmap  --mkkey
2012-08-26 23:43:24.572064 f733e710 -1 filestore(/data/ceph_backend/osd=
) mkfs:
BTRFS_IOC_SUBVOL_CREATE failed with error (22) Invalid argument
2012-08-26 23:43:24.572088 f733e710 -1 OSD::mkfs: FileStore::mkfs faile=
d with
error -22
2012-08-26 23:43:24.572104 f733e710 -1  ** ERROR: error creating empty =
object
store in /data/ceph_backend/osd: (22) Invalid argument



[global]
       pid file =3D /var/run/ceph/$name.pid
#       debug ms =3D 1
        auth supported =3D cephx
        keyring =3D /etc/ceph/keyring
       osd journal =3D /data/ceph_backend/ceph.journal
       osd_journal_size =3D 512
       filestore journal writeahead =3D true
#       filestore journal parallel =3D true
        filestore_xattr_use_omap =3D 1
        mds max =3D 5
 filestore btrfs snap =3D false
 filestore btrfs trans =3Dfalse

[mon]
       mon data =3D /data/ceph_backend/mon
[mon.0]
       host =3D node01
       mon addr =3D xxx.xxx.xxx.xxx:6789
[mon.1]
       host =3Dnode02
       mon addr =3D xxx.xxx.xxx.xxx:6789
[mon.2]
       host =3D node03
       mon addr =3D xxx.xxx.xxx.xxx:6789


[mds]
        keyring =3D /etc/ceph/keyring.$name
#       mds dir max commit size 32

[mds.0]
       host =3D node01
[mds.1]
       host =3D node02
[osd]
       sudo =3D true
       osd data =3D /data/ceph_backend/osd
        keyring =3D /etc/ceph/keyring.$name



[osd.0]
       host =3D node01
 btrfs devs =3D

       osd data =3D /data/ceph_backend/osd
        keyring =3D /etc/ceph/keyring.$name

[osd.1]
       host =3D node02
        btrfs devs =3D
       osd data =3D /data/ceph_backend/osd
        keyring =3D /etc/ceph/keyring.$name

--=20

Mit freundlichen Gr=FC=DFen,

=46lorian Wiessner

Smart Weblications GmbH
Martinsberger Str. 1
D-95119 Naila

fon.: +49 9282 9638 200
fax.: +49 9282 9638 205
24/7: +49 900 144 000 00 - 0,99 EUR/Min*
http://www.smart-weblications.de

--
Sitz der Gesellschaft: Naila
Gesch=E4ftsf=FChrer: Florian Wiessner
HRB-Nr.: HRB 3840 Amtsgericht Hof
*aus dem dt. Festnetz, ggf. abweichende Preise aus dem Mobilfunknetz
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
