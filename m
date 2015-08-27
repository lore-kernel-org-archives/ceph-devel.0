From: Noah Watkins <noahwatkins@gmail.com>
Subject: newstore OSD magic error
Date: Thu, 27 Aug 2015 13:33:07 -0600
Message-ID: <CAB2gnbUkJmwKjmJtP77tnz_eBHoNdWv6vXfcTcyEt457ZtRt6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f43.google.com ([209.85.192.43]:35100 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751492AbbH0TdJ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Aug 2015 15:33:09 -0400
Received: by qgj62 with SMTP id 62so17234227qgj.2
        for <ceph-devel@vger.kernel.org>; Thu, 27 Aug 2015 12:33:08 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

I've deployed a cluster with one monitor and one OSD using
ceph-deploy. The OSD is spinning up, and there are some errors in the
log after `ceph-deploy create osd osd0:/dev/sdb`.

2015-08-27 14:23:28.061297 7f46d6811980 -1 OSD magic @??7?V !=3D my cep=
h
osd volume v026

ceph.conf:

[global]
fsid =3D 9126937a-c39c-42c5-a00d-30625ce8fa11
mon_initial_members =3D mon0
mon_host =3D 10.10.2.3
auth_cluster_required =3D cephx
auth_service_required =3D cephx
auth_client_required =3D cephx
filestore_xattr_use_omap =3D true
enable experimental unrecoverable data corrupting features =3D newstore=
 rocksdb

public network =3D 10.10.2.0/8
cluster network =3D 10.10.1.0/8

[mon.a]
host =3D mon0
mon addr =3D 10.10.2.3:6789

[osd]
#osd objectstore =3D memstore
osd objectstore =3D newstore

[osd.0]
public addr =3D 10.10.2.1
cluster addr =3D 10.10.1.2

full config log:

2015-08-27 14:23:05.227604 7f1db823b980  0 ceph version
0.46-24817-g94ce100 (94ce1007fdde72a67281c18447a7ac879f2614ad),
process ceph-osd, pid 13468
2015-08-27 14:23:05.227632 7f1db823b980 -1 WARNING: experimental
feature 'newstore' is enabled
Please be aware that this feature is experimental, untested,
unsupported, and may result in data corruption, data loss,
and/or irreparable damage to your cluster.  Do not use
feature with important data.

2015-08-27 14:23:05.247424 7f5576b43980  0 ceph version
0.46-24817-g94ce100 (94ce1007fdde72a67281c18447a7ac879f2614ad),
process ceph-osd, pid 13493
2015-08-27 14:23:05.247449 7f5576b43980 -1 WARNING: experimental
feature 'newstore' is enabled
Please be aware that this feature is experimental, untested,
unsupported, and may result in data corruption, data loss,
and/or irreparable damage to your cluster.  Do not use
feature with important data.

2015-08-27 14:23:05.274768 7fbe45229980  0 ceph version
0.46-24817-g94ce100 (94ce1007fdde72a67281c18447a7ac879f2614ad),
process ceph-osd, pid 13497
2015-08-27 14:23:05.274797 7fbe45229980 -1 WARNING: experimental
feature 'newstore' is enabled
Please be aware that this feature is experimental, untested,
unsupported, and may result in data corruption, data loss,
and/or irreparable damage to your cluster.  Do not use
feature with important data.

2015-08-27 14:23:25.171436 7ff6a3816980  0 ceph version
0.46-24817-g94ce100 (94ce1007fdde72a67281c18447a7ac879f2614ad),
process ceph-osd, pid 13677
2015-08-27 14:23:25.171457 7ff6a3816980 -1 WARNING: experimental
feature 'newstore' is enabled
Please be aware that this feature is experimental, untested,
unsupported, and may result in data corruption, data loss,
and/or irreparable damage to your cluster.  Do not use
feature with important data.

2015-08-27 14:23:25.173214 7ff6a3816980 -1 WARNING: the following
dangerous and experimental features are enabled: newstore,rocksdb
2015-08-27 14:23:25.173623 7ff6a3816980  1
newstore(/var/lib/ceph/tmp/mnt.sU2pxt) mkfs path
/var/lib/ceph/tmp/mnt.sU2pxt
2015-08-27 14:23:25.173633 7ff6a3816980  1
newstore(/var/lib/ceph/tmp/mnt.sU2pxt) _open_path using fs driver
'generic'
2015-08-27 14:23:25.173651 7ff6a3816980  1
newstore(/var/lib/ceph/tmp/mnt.sU2pxt) mkfs fsid is already set to
db74b022-d47b-4313-8367-44ed6ab5a2ce
2015-08-27 14:23:25.173994 7ff6a3816980 -1 WARNING: experimental
feature 'rocksdb' is enabled
Please be aware that this feature is experimental, untested,
unsupported, and may result in data corruption, data loss,
and/or irreparable damage to your cluster.  Do not use
feature with important data.

2015-08-27 14:23:25.235063 7ff6a3816980  1
newstore(/var/lib/ceph/tmp/mnt.sU2pxt) _open_db opened rocksdb path
/var/lib/ceph/tmp/mnt.sU2pxt options
2015-08-27 14:23:25.235237 7ff6a3816980  1
newstore(/var/lib/ceph/tmp/mnt.sU2pxt) mount path
/var/lib/ceph/tmp/mnt.sU2pxt
2015-08-27 14:23:25.235254 7ff6a3816980  1
newstore(/var/lib/ceph/tmp/mnt.sU2pxt) _open_path using fs driver
'generic'
2015-08-27 14:23:25.235281 7ff6a3816980 -1 WARNING: experimental
feature 'rocksdb' is enabled
Please be aware that this feature is experimental, untested,
unsupported, and may result in data corruption, data loss,
and/or irreparable damage to your cluster.  Do not use
feature with important data.

2015-08-27 14:23:25.263694 7ff6a3816980  1
newstore(/var/lib/ceph/tmp/mnt.sU2pxt) _open_db opened rocksdb path
/var/lib/ceph/tmp/mnt.sU2pxt options
2015-08-27 14:23:25.263865 7ff6a3816980  1
newstore(/var/lib/ceph/tmp/mnt.sU2pxt) _recover_next_fid old fid_max
0/0
2015-08-27 14:23:25.263887 7ff6a3816980  1
newstore(/var/lib/ceph/tmp/mnt.sU2pxt) _recover_next_nid old nid_max 0
2015-08-27 14:23:25.303719 7ff6a3816980  1
newstore(/var/lib/ceph/tmp/mnt.sU2pxt) umount
2015-08-27 14:23:25.525720 7ff6a3816980 -1 created object store
/var/lib/ceph/tmp/mnt.sU2pxt journal
/var/lib/ceph/tmp/mnt.sU2pxt/journal for osd.0 fsid
9126937a-c39c-42c5-a00d-30625ce8fa11
2015-08-27 14:23:25.525785 7ff6a3816980 -1 auth: error reading file:
/var/lib/ceph/tmp/mnt.sU2pxt/keyring: can't open
/var/lib/ceph/tmp/mnt.sU2pxt/keyring: (2) No such file or directory
2015-08-27 14:23:25.525984 7ff6a3816980 -1 created new key in keyring
/var/lib/ceph/tmp/mnt.sU2pxt/keyring
2015-08-27 14:23:27.154726 7f929cf3b980  0 ceph version
0.46-24817-g94ce100 (94ce1007fdde72a67281c18447a7ac879f2614ad),
process ceph-osd, pid 13909
2015-08-27 14:23:27.154752 7f929cf3b980 -1 WARNING: experimental
feature 'newstore' is enabled
Please be aware that this feature is experimental, untested,
unsupported, and may result in data corruption, data loss,
and/or irreparable damage to your cluster.  Do not use
feature with important data.

2015-08-27 14:23:27.154935 7f929cf3b980 -1 OSD magic
@^@=C3=BF?7=C3=88^P^@^@^@^@^@?^@^@^@^@^@^@^@V !=3D my ceph osd volume v=
026
2015-08-27 14:23:27.459807 7f3b397f7980  0 ceph version
0.46-24817-g94ce100 (94ce1007fdde72a67281c18447a7ac879f2614ad),
process ceph-osd, pid 13974
2015-08-27 14:23:27.459824 7f3b397f7980 -1 WARNING: experimental
feature 'newstore' is enabled
Please be aware that this feature is experimental, untested,
unsupported, and may result in data corruption, data loss,
and/or irreparable damage to your cluster.  Do not use
feature with important data.

2015-08-27 14:23:27.459944 7f3b397f7980 -1 OSD magic
@^@=C3=BF?7=C3=88^P^@^@^@^@^@?^@^@^@^@^@^@^@V !=3D my ceph osd volume v=
026
2015-08-27 14:23:27.772705 7fed333b4980  0 ceph version
0.46-24817-g94ce100 (94ce1007fdde72a67281c18447a7ac879f2614ad),
process ceph-osd, pid 14039
2015-08-27 14:23:27.772720 7fed333b4980 -1 WARNING: experimental
feature 'newstore' is enabled
Please be aware that this feature is experimental, untested,
unsupported, and may result in data corruption, data loss,
and/or irreparable damage to your cluster.  Do not use
feature with important data.

2015-08-27 14:23:27.772819 7fed333b4980 -1 OSD magic
@^@=C3=BF?7=C3=88^P^@^@^@^@^@?^@^@^@^@^@^@^@V !=3D my ceph osd volume v=
026
2015-08-27 14:23:28.061033 7f46d6811980 -1 WARNING: the following
dangerous and experimental features are enabled: newstore,rocksdb
2015-08-27 14:23:28.061084 7f46d6811980 -1 WARNING: the following
dangerous and experimental features are enabled: newstore,rocksdb
2015-08-27 14:23:28.061130 7f46d6811980  0 ceph version
0.46-24817-g94ce100 (94ce1007fdde72a67281c18447a7ac879f2614ad),
process ceph-osd, pid 14104
2015-08-27 14:23:28.061141 7f46d6811980 -1 WARNING: experimental
feature 'newstore' is enabled
Please be aware that this feature is experimental, untested,
unsupported, and may result in data corruption, data loss,
and/or irreparable damage to your cluster.  Do not use
feature with important data.

2015-08-27 14:23:28.061297 7f46d6811980 -1 OSD magic
@^@=C3=BF?7=C3=88^P^@^@^@^@^@?^@^@^@^@^@^@^@V !=3D my ceph osd volume v=
026
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
