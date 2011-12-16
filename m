From: Samuel Just <sam.just@dreamhost.com>
Subject: Re: ceph-osd not starting
Date: Fri, 16 Dec 2011 15:55:28 -0800
Message-ID: <CACLRD_1TwMN+YNoyizt7+ZnvEtjRWKW21yJuJpnucnY=QwQtGQ@mail.gmail.com>
References: <4EEB3848.8080202@smart-weblications.de>
	<CACLRD_0HD9iFLDQBsccHibPGA6rqjos51c4w13qChB0Xw9nQsw@mail.gmail.com>
	<4EEBB685.4090906@smart-weblications.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:37645 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752164Ab1LPXza convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Dec 2011 18:55:30 -0500
Received: by wgbdr13 with SMTP id dr13so7045625wgb.1
        for <ceph-devel@vger.kernel.org>; Fri, 16 Dec 2011 15:55:28 -0800 (PST)
In-Reply-To: <4EEBB685.4090906@smart-weblications.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: f.wiessner@smart-weblications.de
Cc: ceph-devel@vger.kernel.org

There is no further output?  Does the process die at that point, or
does it hang?
-Sam

On Fri, Dec 16, 2011 at 1:22 PM, Smart Weblications GmbH - Florian
Wiessner <f.wiessner@smart-weblications.de> wrote:
> Am 16.12.2011 21:45, schrieb Samuel Just:
>> Could you try it again with --debug_osd 20 and --debug_filestore 20?
>> -Sam
>
> sure:
>
> node01:/glusterfs/smartweb/tmp/new# ceph-osd -i 0 --debug_ms 20 --deb=
ug_osd 20
> --debug_filestore 20 -d
> 2011-12-16 22:20:35.185189 7f3a40776780 -- :/0 rank.bind :/0
> 2011-12-16 22:20:35.185234 7f3a40776780 -- :/0 accepter.bind
> 2011-12-16 22:20:35.185258 7f3a40776780 -- :/0 accepter.bind bound on=
 random
> port 0.0.0.0:6804/0
> 2011-12-16 22:20:35.185283 7f3a40776780 -- :/0 accepter.bind bound to=
 0.0.0.0:6804/0
> 2011-12-16 22:20:35.185296 7f3a40776780 -- 0.0.0.0:6804/3915 accepter=
=2Ebind
> ms_addr is 0.0.0.0:6804/3915 need_addr=3D1
> 2011-12-16 22:20:35.185304 7f3a40776780 -- :/0 rank.bind :/0
> 2011-12-16 22:20:35.185309 7f3a40776780 -- :/0 accepter.bind
> 2011-12-16 22:20:35.185319 7f3a40776780 -- :/0 accepter.bind bound on=
 random
> port 0.0.0.0:6805/0
> 2011-12-16 22:20:35.185326 7f3a40776780 -- :/0 accepter.bind bound to=
 0.0.0.0:6805/0
> 2011-12-16 22:20:35.185342 7f3a40776780 -- 0.0.0.0:6805/3915 accepter=
=2Ebind
> ms_addr is 0.0.0.0:6805/3915 need_addr=3D1
> 2011-12-16 22:20:35.185349 7f3a40776780 -- :/0 rank.bind :/0
> 2011-12-16 22:20:35.185354 7f3a40776780 -- :/0 accepter.bind
> 2011-12-16 22:20:35.185365 7f3a40776780 -- :/0 accepter.bind bound on=
 random
> port 0.0.0.0:6806/0
> 2011-12-16 22:20:35.185372 7f3a40776780 -- :/0 accepter.bind bound to=
 0.0.0.0:6806/0
> 2011-12-16 22:20:35.185381 7f3a40776780 -- 0.0.0.0:6806/3915 accepter=
=2Ebind
> ms_addr is 0.0.0.0:6806/3915 need_addr=3D1
> =C2=A0** WARNING: Ceph is still under development. =C2=A0Any feedback=
 can be directed =C2=A0**
> =C2=A0** =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0at ceph-devel@vger.kernel.=
org or http://ceph.newdream.net/. =C2=A0 =C2=A0 **
> 2011-12-16 22:20:35.185418 7f3a40776780 ceph version 0.39-128-g739fd9=
f
> (commit:739fd9fee4be00b7a3912e59bf5ce7179b2e54ff), process ceph-osd, =
pid 3915
> starting osd.0 at 0.0.0.0:6804/3915 osd_data /data/ceph/osd /data/cep=
h.journal
> 2011-12-16 22:20:35.185445 7f3a40776780 -- 0.0.0.0:6804/3915 register=
_entity osd.0
> 2011-12-16 22:20:35.185454 7f3a40776780 -- 0.0.0.0:6804/3915 register=
_entity
> osd.0 at 0.0.0.0:6804/3915
> 2011-12-16 22:20:35.185461 7f3a40776780 -- 0.0.0.0:6805/3915 register=
_entity osd.0
> 2011-12-16 22:20:35.185469 7f3a40776780 -- 0.0.0.0:6805/3915 register=
_entity
> osd.0 at 0.0.0.0:6805/3915
> 2011-12-16 22:20:35.185476 7f3a40776780 -- :/0 register_entity osd.0
> 2011-12-16 22:20:35.185483 7f3a40776780 -- :/0 register_entity osd.0 =
at :/0
> 2011-12-16 22:20:35.185491 7f3a40776780 -- 0.0.0.0:6806/3915 register=
_entity osd.0
> 2011-12-16 22:20:35.185498 7f3a40776780 -- 0.0.0.0:6806/3915 register=
_entity
> osd.0 at 0.0.0.0:6806/3915
> 2011-12-16 22:20:35.185673 7f3a40776780 filestore(/data/ceph/osd) bas=
edir
> /data/ceph/osd journal /data/ceph.journal
> 2011-12-16 22:20:35.186724 7f3a40776780 filestore(/data/ceph/osd) mou=
nt FIEMAP
> ioctl is NOT supported
> 2011-12-16 22:20:35.186742 7f3a40776780 filestore(/data/ceph/osd) mou=
nt detected
> btrfs
> 2011-12-16 22:20:35.186758 7f3a40776780 filestore(/data/ceph/osd)
> _do_clone_range 0~1 to 0
> 2011-12-16 22:20:35.186769 7f3a40776780 filestore(/data/ceph/osd) mou=
nt btrfs
> CLONE_RANGE ioctl is supported
> 2011-12-16 22:20:35.695670 7f3a40776780 filestore(/data/ceph/osd) mou=
nt btrfs
> SNAP_CREATE is supported
> 2011-12-16 22:20:35.760652 7f3a40776780 filestore(/data/ceph/osd) mou=
nt btrfs
> SNAP_DESTROY is supported
> 2011-12-16 22:20:35.762562 7f3a40776780 filestore(/data/ceph/osd) mou=
nt btrfs
> START_SYNC got 0 Success
> 2011-12-16 22:20:35.762578 7f3a40776780 filestore(/data/ceph/osd) mou=
nt btrfs
> START_SYNC is supported (transid 34747)
> 2011-12-16 22:20:36.030031 7f3a40776780 filestore(/data/ceph/osd) mou=
nt btrfs
> WAIT_SYNC is supported
> 2011-12-16 22:20:36.051500 7f3a40776780 filestore(/data/ceph/osd) mou=
nt btrfs
> SNAP_CREATE_V2 got 0 Success
> 2011-12-16 22:20:36.051526 7f3a40776780 filestore(/data/ceph/osd) mou=
nt btrfs
> SNAP_CREATE_V2 is supported
> 2011-12-16 22:20:36.125748 7f3a40776780 filestore(/data/ceph/osd) mou=
nt fsid is
> 2026500628
> 2011-12-16 22:20:36.125801 7f3a40776780 filestore(/data/ceph/osd) mou=
nt found
> snaps <1015722,1015733>
> 2011-12-16 22:20:36.125824 7f3a40776780 filestore(/data/ceph/osd) =C2=
=A0current/ seq
> was 1015733
> 2011-12-16 22:20:36.125833 7f3a40776780 filestore(/data/ceph/osd) =C2=
=A0most recent
> snap from <1015722,1015733> is 1015733
> 2011-12-16 22:20:36.125841 7f3a40776780 filestore(/data/ceph/osd) mou=
nt rolling
> back to consistent snap 1015733
> 2011-12-16 22:20:36.454954 7f3a40776780 filestore(/data/ceph/osd) mou=
nt op_seq
> is 1015733
> 2011-12-16 22:20:36.454966 7f3a40776780 filestore(/data/ceph/osd) ope=
n_journal
> at /data/ceph.journal
> 2011-12-16 22:20:36.454973 7f3a40776780 filestore(/data/ceph/osd) mou=
nt:
> enabling PARALLEL journal mode: btrfs, SNAP_CREATE_V2 detected and 'f=
ilestore
> btrfs snap' mode is enabled
> 2011-12-16 22:20:36.454978 7f3a40776780 filestore(/data/ceph/osd) lis=
t_collections
> 2011-12-16 22:20:36.464421 7f3a40776780 journal _open /data/ceph.jour=
nal fd 13:
> 536870912 bytes, block size 4096 bytes, directio =3D 1
> 2011-12-16 22:20:36.464449 7f3a3d6f3700 filestore(/data/ceph/osd) syn=
c_entry
> waiting for max_interval 5.000000
> 2011-12-16 22:20:36.464463 7f3a40776780 journal read_entry 495902720 =
: seq
> 1015723 18121 bytes
> 2011-12-16 22:20:36.464492 7f3a40776780 journal read_entry 495927296 =
: seq
> 1015724 18121 bytes
> 2011-12-16 22:20:36.464515 7f3a40776780 journal read_entry 495951872 =
: seq
> 1015725 18663 bytes
> 2011-12-16 22:20:36.464606 7f3a40776780 journal read_entry 495976448 =
: seq
> 1015726 181429 bytes
> 2011-12-16 22:20:36.464637 7f3a40776780 journal read_entry 496164864 =
: seq
> 1015727 17589 bytes
> 2011-12-16 22:20:36.464658 7f3a40776780 journal read_entry 496189440 =
: seq
> 1015728 17589 bytes
> 2011-12-16 22:20:36.464676 7f3a40776780 journal read_entry 496214016 =
: seq
> 1015729 5301 bytes
> 2011-12-16 22:20:36.464698 7f3a40776780 journal read_entry 496226304 =
: seq
> 1015730 13493 bytes
> 2011-12-16 22:20:36.465053 7f3a40776780 journal read_entry 496246784 =
: seq
> 1015731 17589 bytes
> 2011-12-16 22:20:36.465075 7f3a40776780 journal read_entry 496271360 =
: seq
> 1015732 17589 bytes
> 2011-12-16 22:20:36.465095 7f3a40776780 journal read_entry 496295936 =
: seq
> 1015733 17589 bytes
> 2011-12-16 22:20:36.465119 7f3a40776780 journal _open /data/ceph.jour=
nal fd 13:
> 536870912 bytes, block size 4096 bytes, directio =3D 1
> 2011-12-16 22:20:36.465279 7f3a3aeee700 filestore(/data/ceph/osd) flu=
sher_entry
> start
> 2011-12-16 22:20:36.465298 7f3a3aeee700 filestore(/data/ceph/osd) flu=
sher_entry
> sleeping
> 2011-12-16 22:20:36.465334 7f3a40776780 FileStore is up to date.
> 2011-12-16 22:20:36.465355 7f3a40776780 filestore(/data/ceph/osd) umo=
unt
> /data/ceph/osd
> 2011-12-16 22:20:36.465380 7f3a3d6f3700 filestore(/data/ceph/osd) syn=
c_entry
> force_sync set
> 2011-12-16 22:20:36.465395 7f3a3aeee700 filestore(/data/ceph/osd) flu=
sher_entry
> awoke
> 2011-12-16 22:20:36.465400 7f3a3aeee700 filestore(/data/ceph/osd) flu=
sher_entry
> finish
> 2011-12-16 22:20:36.465459 7f3a40776780 journal close /data/ceph.jour=
nal
> 2011-12-16 22:20:36.465662 7f3a40776780 filestore(/data/ceph/osd) tes=
t_mount
> basedir /data/ceph/osd journal /data/ceph.journal
> Abgebrochen
>
>
>
> --
>
> Mit freundlichen Gr=C3=BC=C3=9Fen,
>
> Florian Wiessner
>
> Smart Weblications GmbH
> Martinsberger Str. 1
> D-95119 Naila
>
> fon.: +49 9282 9638 200
> fax.: +49 9282 9638 205
> 24/7: +49 900 144 000 00 - 0,99 EUR/Min*
> http://www.smart-weblications.de
>
> --
> Sitz der Gesellschaft: Naila
> Gesch=C3=A4ftsf=C3=BChrer: Florian Wiessner
> HRB-Nr.: HRB 3840 Amtsgericht Hof
> *aus dem dt. Festnetz, ggf. abweichende Preise aus dem Mobilfunknetz
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
