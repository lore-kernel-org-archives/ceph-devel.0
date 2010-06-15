From: Min Zhou <coderplay@gmail.com>
Subject: setup ceph cluster failed
Date: Wed, 16 Jun 2010 04:09:07 +0800
Message-ID: <AANLkTikdrTuquXK2sr5rz4rRASJWHvkVzkw4Y26rusds@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:64754 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751916Ab0FOUJJ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Jun 2010 16:09:09 -0400
Received: by gye5 with SMTP id 5so3520825gye.19
        for <ceph-devel@vger.kernel.org>; Tue, 15 Jun 2010 13:09:08 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,

I am a newbie of ceph, and didn't  find any ceph mailing list for
users, so I send a mail here ask for helping.
below is the error information

$ mkcephfs --allhosts -c ceph_conf/ceph.conf -v
/home/ceph/ceph/bin/cconf -c ceph_conf/ceph.conf -i 0 -t mon  "mon addr=
" ""
/home/ceph/ceph/bin/cconf -c ceph_conf/ceph.conf -i 1 -t mon  "mon addr=
" ""
/home/ceph/ceph/bin/monmaptool --create --clobber --add
192.168.0.2:6789 --add 192.168.0.3:6789 --print /tmp/monmap.8107
/home/ceph/ceph/bin/monmaptool: monmap file /tmp/monmap.8107
/home/ceph/ceph/bin/monmaptool: generated fsid
2b00c868-cfd6-2473-c27d-302b5cddc194
epoch 1
fsid 2b00c868-cfd6-2473-c27d-302b5cddc194
last_changed 10.06.16 04:02:28.247612
created 10.06.16 04:02:28.247612
        mon0 192.168.0.2:6789/0
        mon1 192.168.0.3:6789/0
/home/ceph/ceph/bin/monmaptool: writing epoch 1 to /tmp/monmap.8107 (2 =
monitors)
max osd in ceph_conf/ceph.conf is 2, num osd is 3
/home/ceph/ceph/bin/osdmaptool: osdmap file '/tmp/osdmap.8107'
/home/ceph/ceph/bin/osdmaptool: writing epoch 1 to /tmp/osdmap.8107
/home/ceph/ceph/bin/cconf -c ceph_conf/ceph.conf -i 1 -t mon  "crush ma=
p src" ""
/home/ceph/ceph/bin/cconf -c ceph_conf/ceph.conf -i 1 -t mon  "crush ma=
p" ""
Building admin keyring at /tmp/admin.keyring.8107
creating /tmp/admin.keyring.8107
Building monitor keyring with all service keys
creating /tmp/monkeyring.8107
importing contents of /tmp/admin.keyring.8107 into /tmp/monkeyring.8107
creating /tmp/keyring.mds.0
importing contents of /tmp/keyring.mds.0 into /tmp/monkeyring.8107
creating /tmp/keyring.mds.1
importing contents of /tmp/keyring.mds.1 into /tmp/monkeyring.8107
creating /tmp/keyring.mds.a
importing contents of /tmp/keyring.mds.a into /tmp/monkeyring.8107
creating /tmp/keyring.osd.0
importing contents of /tmp/keyring.osd.0 into /tmp/monkeyring.8107
creating /tmp/keyring.osd.1
importing contents of /tmp/keyring.osd.1 into /tmp/monkeyring.8107
creating /tmp/keyring.osd.2
importing contents of /tmp/keyring.osd.2 into /tmp/monkeyring.8107
/home/ceph/ceph/bin/cconf -c ceph_conf/ceph.conf -i 0 -t mon  "user" ""
=3D=3D=3D mon0 =3D=3D=3D
/home/ceph/ceph/bin/cconf -c ceph_conf/ceph.conf -i 0 -t mon  "mon data=
" ""
/home/ceph/ceph/lib/ceph/ceph_common.sh: eval: line 167: unexpected
EOF while looking for matching `"'
/home/ceph/ceph/lib/ceph/ceph_common.sh: eval: line 168: syntax error:
unexpected end of file
--- hdp2# /home/ceph/ceph/bin/mkmonfs --clobber --mon-data  -i 0
--monmap /tmp/monmap.8107 --osdmap /tmp/osdmap.8107 -k
/tmp/keyring.8107 ; rm -f /tmp/keyring.8107
usage: ./mkmonfs [--clobber] --mon-data <monfsdir> -i <monid> --monmap
<file> --osdmap <file>
`/tmp/admin.keyring.8107' -> `/admin_keyring.bin'
cp: cannot create regular file `/admin_keyring.bin': Permission denied
/home/ceph/ceph/bin/cconf -c ceph_conf/ceph.conf -i 1 -t mon  "user" ""
/home/ceph/ceph/bin/cconf -c ceph_conf/ceph.conf -i 1 -t mon  "ssh
path" "/home/ceph"
=3D=3D=3D mon1 =3D=3D=3D
/home/ceph/ceph/bin/cconf -c ceph_conf/ceph.conf -i 1 -t mon  "mon data=
" ""
/home/ceph/ceph/lib/ceph/ceph_common.sh: eval: line 167: unexpected
EOF while looking for matching `"'
/home/ceph/ceph/lib/ceph/ceph_common.sh: eval: line 168: syntax error:
unexpected end of file
--- ssh hdp3  "cd /home/ceph ; ulimit -c unlimited ;
/home/ceph/ceph/bin/mkmonfs --clobber --mon-data  -i 1 --monmap
/tmp/monmap.8107 --osdmap /tmp/osdmap.8107 -k /tmp/keyring.8107 ; rm
-f /tmp/keyring.8107"
usage: ./mkmonfs [--clobber] --mon-data <monfsdir> -i <monid> --monmap
<file> --osdmap <file>
scp: /admin_keyring.bin: Permission denied
/home/ceph/ceph/bin/cconf -c ceph_conf/ceph.conf -i 0 -t mds  "user" ""
=3D=3D=3D mds0 =3D=3D=3D
/home/ceph/ceph/bin/cconf -c ceph_conf/ceph.conf -i 0 -t mds  "keyring"=
 ""
WARNING: no keyring specified for mds0
/home/ceph/ceph/bin/cconf -c ceph_conf/ceph.conf -i 1 -t mds  "user" ""
/home/ceph/ceph/bin/cconf -c ceph_conf/ceph.conf -i 1 -t mds  "ssh
path" "/home/ceph"
=3D=3D=3D mds1 =3D=3D=3D
/home/ceph/ceph/bin/cconf -c ceph_conf/ceph.conf -i 1 -t mds  "keyring"=
 ""
WARNING: no keyring specified for mds1
/home/ceph/ceph/bin/cconf -c ceph_conf/ceph.conf -i a -t mds  "user" ""
=3D=3D=3D mds.a =3D=3D=3D
/home/ceph/ceph/bin/cconf -c ceph_conf/ceph.conf -i a -t mds  "keyring"=
 ""
WARNING: no keyring specified for mds.a
/home/ceph/ceph/bin/cconf -c ceph_conf/ceph.conf -i 0 -t osd  "user" ""
/home/ceph/ceph/bin/cconf -c ceph_conf/ceph.conf -i 0 -t osd  "ssh
path" "/home/ceph"
=3D=3D=3D osd0 =3D=3D=3D
/home/ceph/ceph/bin/cconf -c ceph_conf/ceph.conf -i 0 -t osd  "osd data=
" ""
/home/ceph/ceph/bin/cconf -c ceph_conf/ceph.conf -i 0 -t osd  "keyring"=
 ""
/home/ceph/ceph/bin/cconf -c ceph_conf/ceph.conf -i 0 -t osd  "btrfs
path" "(0=B5=E1=3D_OSD_DIR/dev/osd0"
/home/ceph/ceph/bin/cconf -c ceph_conf/ceph.conf -i 0 -t osd  "btrfs de=
vs" ""
/home/ceph/ceph/bin/cconf -c ceph_conf/ceph.conf -i 0 -t osd  "btrfs
options" "noatime"
--- ssh hdp4  "cd /home/ceph ; ulimit -c unlimited ; test -d
(0=B5=E1=3D_OSD_DIR/dev/osd0 || mkdir -p (0=B5=E1=3D_OSD_DIR/dev/osd0"
bash: -c: line 0: syntax error near unexpected token `('
bash: -c: line 0: `cd /home/ceph ; ulimit -c unlimited ; test -d
(0=B5=E1=3D_OSD_DIR/dev/osd0 || mkdir -p (0=B5=E1=3D_OSD_DIR/dev/osd0'
failed: 'ssh hdp4 test -d (0=B5=E1=3D_OSD_DIR/dev/osd0 || mkdir -p
(0=B5=E1=3D_OSD_DIR/dev/osd0'

Can someone help me on this?


Thanks,
Min

--=20
My research interests are distributed systems, parallel computing and
bytecode based virtual machine.

My profile:
http://www.linkedin.com/in/coderplay
My blog:
http://coderplay.javaeye.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
