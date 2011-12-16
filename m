From: Smart Weblications GmbH - Florian Wiessner
	<f.wiessner@smart-weblications.de>
Subject: Re: ceph-osd not starting
Date: Fri, 16 Dec 2011 22:22:13 +0100
Message-ID: <4EEBB685.4090906@smart-weblications.de>
References: <4EEB3848.8080202@smart-weblications.de> <CACLRD_0HD9iFLDQBsccHibPGA6rqjos51c4w13qChB0Xw9nQsw@mail.gmail.com>
Reply-To: f.wiessner@smart-weblications.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx02.smart-weblications.de ([188.65.144.37]:45730 "EHLO
	mx02.smart-weblications.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754193Ab1LPVWE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Fri, 16 Dec 2011 16:22:04 -0500
In-Reply-To: <CACLRD_0HD9iFLDQBsccHibPGA6rqjos51c4w13qChB0Xw9nQsw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

Am 16.12.2011 21:45, schrieb Samuel Just:
> Could you try it again with --debug_osd 20 and --debug_filestore 20?
> -Sam

sure:

node01:/glusterfs/smartweb/tmp/new# ceph-osd -i 0 --debug_ms 20 --debug=
_osd 20
--debug_filestore 20 -d
2011-12-16 22:20:35.185189 7f3a40776780 -- :/0 rank.bind :/0
2011-12-16 22:20:35.185234 7f3a40776780 -- :/0 accepter.bind
2011-12-16 22:20:35.185258 7f3a40776780 -- :/0 accepter.bind bound on r=
andom
port 0.0.0.0:6804/0
2011-12-16 22:20:35.185283 7f3a40776780 -- :/0 accepter.bind bound to 0=
=2E0.0.0:6804/0
2011-12-16 22:20:35.185296 7f3a40776780 -- 0.0.0.0:6804/3915 accepter.b=
ind
ms_addr is 0.0.0.0:6804/3915 need_addr=3D1
2011-12-16 22:20:35.185304 7f3a40776780 -- :/0 rank.bind :/0
2011-12-16 22:20:35.185309 7f3a40776780 -- :/0 accepter.bind
2011-12-16 22:20:35.185319 7f3a40776780 -- :/0 accepter.bind bound on r=
andom
port 0.0.0.0:6805/0
2011-12-16 22:20:35.185326 7f3a40776780 -- :/0 accepter.bind bound to 0=
=2E0.0.0:6805/0
2011-12-16 22:20:35.185342 7f3a40776780 -- 0.0.0.0:6805/3915 accepter.b=
ind
ms_addr is 0.0.0.0:6805/3915 need_addr=3D1
2011-12-16 22:20:35.185349 7f3a40776780 -- :/0 rank.bind :/0
2011-12-16 22:20:35.185354 7f3a40776780 -- :/0 accepter.bind
2011-12-16 22:20:35.185365 7f3a40776780 -- :/0 accepter.bind bound on r=
andom
port 0.0.0.0:6806/0
2011-12-16 22:20:35.185372 7f3a40776780 -- :/0 accepter.bind bound to 0=
=2E0.0.0:6806/0
2011-12-16 22:20:35.185381 7f3a40776780 -- 0.0.0.0:6806/3915 accepter.b=
ind
ms_addr is 0.0.0.0:6806/3915 need_addr=3D1
 ** WARNING: Ceph is still under development.  Any feedback can be dire=
cted  **
 **          at ceph-devel@vger.kernel.org or http://ceph.newdream.net/=
=2E     **
2011-12-16 22:20:35.185418 7f3a40776780 ceph version 0.39-128-g739fd9f
(commit:739fd9fee4be00b7a3912e59bf5ce7179b2e54ff), process ceph-osd, pi=
d 3915
starting osd.0 at 0.0.0.0:6804/3915 osd_data /data/ceph/osd /data/ceph.=
journal
2011-12-16 22:20:35.185445 7f3a40776780 -- 0.0.0.0:6804/3915 register_e=
ntity osd.0
2011-12-16 22:20:35.185454 7f3a40776780 -- 0.0.0.0:6804/3915 register_e=
ntity
osd.0 at 0.0.0.0:6804/3915
2011-12-16 22:20:35.185461 7f3a40776780 -- 0.0.0.0:6805/3915 register_e=
ntity osd.0
2011-12-16 22:20:35.185469 7f3a40776780 -- 0.0.0.0:6805/3915 register_e=
ntity
osd.0 at 0.0.0.0:6805/3915
2011-12-16 22:20:35.185476 7f3a40776780 -- :/0 register_entity osd.0
2011-12-16 22:20:35.185483 7f3a40776780 -- :/0 register_entity osd.0 at=
 :/0
2011-12-16 22:20:35.185491 7f3a40776780 -- 0.0.0.0:6806/3915 register_e=
ntity osd.0
2011-12-16 22:20:35.185498 7f3a40776780 -- 0.0.0.0:6806/3915 register_e=
ntity
osd.0 at 0.0.0.0:6806/3915
2011-12-16 22:20:35.185673 7f3a40776780 filestore(/data/ceph/osd) based=
ir
/data/ceph/osd journal /data/ceph.journal
2011-12-16 22:20:35.186724 7f3a40776780 filestore(/data/ceph/osd) mount=
 FIEMAP
ioctl is NOT supported
2011-12-16 22:20:35.186742 7f3a40776780 filestore(/data/ceph/osd) mount=
 detected
btrfs
2011-12-16 22:20:35.186758 7f3a40776780 filestore(/data/ceph/osd)
_do_clone_range 0~1 to 0
2011-12-16 22:20:35.186769 7f3a40776780 filestore(/data/ceph/osd) mount=
 btrfs
CLONE_RANGE ioctl is supported
2011-12-16 22:20:35.695670 7f3a40776780 filestore(/data/ceph/osd) mount=
 btrfs
SNAP_CREATE is supported
2011-12-16 22:20:35.760652 7f3a40776780 filestore(/data/ceph/osd) mount=
 btrfs
SNAP_DESTROY is supported
2011-12-16 22:20:35.762562 7f3a40776780 filestore(/data/ceph/osd) mount=
 btrfs
START_SYNC got 0 Success
2011-12-16 22:20:35.762578 7f3a40776780 filestore(/data/ceph/osd) mount=
 btrfs
START_SYNC is supported (transid 34747)
2011-12-16 22:20:36.030031 7f3a40776780 filestore(/data/ceph/osd) mount=
 btrfs
WAIT_SYNC is supported
2011-12-16 22:20:36.051500 7f3a40776780 filestore(/data/ceph/osd) mount=
 btrfs
SNAP_CREATE_V2 got 0 Success
2011-12-16 22:20:36.051526 7f3a40776780 filestore(/data/ceph/osd) mount=
 btrfs
SNAP_CREATE_V2 is supported
2011-12-16 22:20:36.125748 7f3a40776780 filestore(/data/ceph/osd) mount=
 fsid is
2026500628
2011-12-16 22:20:36.125801 7f3a40776780 filestore(/data/ceph/osd) mount=
 found
snaps <1015722,1015733>
2011-12-16 22:20:36.125824 7f3a40776780 filestore(/data/ceph/osd)  curr=
ent/ seq
was 1015733
2011-12-16 22:20:36.125833 7f3a40776780 filestore(/data/ceph/osd)  most=
 recent
snap from <1015722,1015733> is 1015733
2011-12-16 22:20:36.125841 7f3a40776780 filestore(/data/ceph/osd) mount=
 rolling
back to consistent snap 1015733
2011-12-16 22:20:36.454954 7f3a40776780 filestore(/data/ceph/osd) mount=
 op_seq
is 1015733
2011-12-16 22:20:36.454966 7f3a40776780 filestore(/data/ceph/osd) open_=
journal
at /data/ceph.journal
2011-12-16 22:20:36.454973 7f3a40776780 filestore(/data/ceph/osd) mount=
:
enabling PARALLEL journal mode: btrfs, SNAP_CREATE_V2 detected and 'fil=
estore
btrfs snap' mode is enabled
2011-12-16 22:20:36.454978 7f3a40776780 filestore(/data/ceph/osd) list_=
collections
2011-12-16 22:20:36.464421 7f3a40776780 journal _open /data/ceph.journa=
l fd 13:
536870912 bytes, block size 4096 bytes, directio =3D 1
2011-12-16 22:20:36.464449 7f3a3d6f3700 filestore(/data/ceph/osd) sync_=
entry
waiting for max_interval 5.000000
2011-12-16 22:20:36.464463 7f3a40776780 journal read_entry 495902720 : =
seq
1015723 18121 bytes
2011-12-16 22:20:36.464492 7f3a40776780 journal read_entry 495927296 : =
seq
1015724 18121 bytes
2011-12-16 22:20:36.464515 7f3a40776780 journal read_entry 495951872 : =
seq
1015725 18663 bytes
2011-12-16 22:20:36.464606 7f3a40776780 journal read_entry 495976448 : =
seq
1015726 181429 bytes
2011-12-16 22:20:36.464637 7f3a40776780 journal read_entry 496164864 : =
seq
1015727 17589 bytes
2011-12-16 22:20:36.464658 7f3a40776780 journal read_entry 496189440 : =
seq
1015728 17589 bytes
2011-12-16 22:20:36.464676 7f3a40776780 journal read_entry 496214016 : =
seq
1015729 5301 bytes
2011-12-16 22:20:36.464698 7f3a40776780 journal read_entry 496226304 : =
seq
1015730 13493 bytes
2011-12-16 22:20:36.465053 7f3a40776780 journal read_entry 496246784 : =
seq
1015731 17589 bytes
2011-12-16 22:20:36.465075 7f3a40776780 journal read_entry 496271360 : =
seq
1015732 17589 bytes
2011-12-16 22:20:36.465095 7f3a40776780 journal read_entry 496295936 : =
seq
1015733 17589 bytes
2011-12-16 22:20:36.465119 7f3a40776780 journal _open /data/ceph.journa=
l fd 13:
536870912 bytes, block size 4096 bytes, directio =3D 1
2011-12-16 22:20:36.465279 7f3a3aeee700 filestore(/data/ceph/osd) flush=
er_entry
start
2011-12-16 22:20:36.465298 7f3a3aeee700 filestore(/data/ceph/osd) flush=
er_entry
sleeping
2011-12-16 22:20:36.465334 7f3a40776780 FileStore is up to date.
2011-12-16 22:20:36.465355 7f3a40776780 filestore(/data/ceph/osd) umoun=
t
/data/ceph/osd
2011-12-16 22:20:36.465380 7f3a3d6f3700 filestore(/data/ceph/osd) sync_=
entry
force_sync set
2011-12-16 22:20:36.465395 7f3a3aeee700 filestore(/data/ceph/osd) flush=
er_entry
awoke
2011-12-16 22:20:36.465400 7f3a3aeee700 filestore(/data/ceph/osd) flush=
er_entry
finish
2011-12-16 22:20:36.465459 7f3a40776780 journal close /data/ceph.journa=
l
2011-12-16 22:20:36.465662 7f3a40776780 filestore(/data/ceph/osd) test_=
mount
basedir /data/ceph/osd journal /data/ceph.journal
Abgebrochen



--=20

Mit freundlichen Gr=C3=BC=C3=9Fen,

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
Gesch=C3=A4ftsf=C3=BChrer: Florian Wiessner
HRB-Nr.: HRB 3840 Amtsgericht Hof
*aus dem dt. Festnetz, ggf. abweichende Preise aus dem Mobilfunknetz
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
