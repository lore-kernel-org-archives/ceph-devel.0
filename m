From: Tomasz Paszkowski <ss7pro@gmail.com>
Subject: Re: OSD died
Date: Wed, 25 Apr 2012 12:11:14 +0200
Message-ID: <CAMvP8PAs+4AW-PiVO=5p7Q2CLC3=uz-hSUKD7C9NW-dcDCJ=1w@mail.gmail.com>
References: <CAMvP8PD-zKg6OhWEjM4QWSdtXmkdoca-6LghvgTgdHoiOyPPwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:43525 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757133Ab2DYKLf convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Apr 2012 06:11:35 -0400
Received: by ghrr11 with SMTP id r11so981595ghr.19
        for <ceph-devel@vger.kernel.org>; Wed, 25 Apr 2012 03:11:34 -0700 (PDT)
In-Reply-To: <CAMvP8PD-zKg6OhWEjM4QWSdtXmkdoca-6LghvgTgdHoiOyPPwg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

osd dump is like this:

pool 0 'data' rep size 2 crush_ruleset 0 object_hash rjenkins pg_num
768 pgp_num 768 lpg_num 2 lpgp_num 2 last_change 1 owner 0
crash_replay_interval 45
pool 1 'metadata' rep size 2 crush_ruleset 1 object_hash rjenkins
pg_num 768 pgp_num 768 lpg_num 2 lpgp_num 2 last_change 1 owner 0
pool 2 'rbd' rep size 2 crush_ruleset 2 object_hash rjenkins pg_num
768 pgp_num 768 lpg_num 2 lpgp_num 2 last_change 1 owner 0
pool 9 'nova' rep size 2 crush_ruleset 0 object_hash rjenkins pg_num
2568 pgp_num 2568 lpg_num 0 lpgp_num 0 last_change 1435 owner
18446744073709551615
	removed_snaps [1~1]
pool 10 'glance' rep size 2 crush_ruleset 0 object_hash rjenkins
pg_num 2568 pgp_num 2568 lpg_num 0 lpgp_num 0 last_change 132 owner
18446744073709551615


On Wed, Apr 25, 2012 at 11:04 AM, Tomasz Paszkowski <ss7pro@gmail.com> =
wrote:
> Hi,
>
> After making and removing snapshot from one of the pools, all of the
> osd in cluster are dying with log like below:
>
>
> 2012-04-25 11:01:00.938313 7f66694b9700 osd.1 1434 =A0removing old
> osdmap epoch 966
> 2012-04-25 11:01:00.938330 7f66694b9700 osd.1 1434 =A0removing old
> osdmap epoch 967
> 2012-04-25 11:01:00.938348 7f66694b9700 osd.1 1434 =A0advance to epoc=
h
> 1435 (<=3D newest 1470)
> 2012-04-25 11:01:00.939437 7f66694b9700 osd.1 1435 advance_map epoch
> 1435 =A01325 pgs
> 2012-04-25 11:01:00.939455 7f66694b9700 osd.1 1435 =A0pool 0 removed
> snaps [], unchanged (snap_epoch =3D 0)
> 2012-04-25 11:01:00.939469 7f66694b9700 osd.1 1435 =A0pool 1 removed
> snaps [], unchanged (snap_epoch =3D 0)
> 2012-04-25 11:01:00.939482 7f66694b9700 osd.1 1435 =A0pool 2 removed
> snaps [], unchanged (snap_epoch =3D 0)
> ./include/interval_set.h: In function 'void interval_set<T>::erase(T,
> T) [with T =3D snapid_t]' thread 7f66694b9700 time 2012-04-25
> 11:01:00.939509
> ./include/interval_set.h: 382: FAILED assert(_size >=3D 0)
> =A0ceph version 0.44.1 (commit:c89b7f22c8599eb974e75a2f7a5f855358199d=
ee)
> =A01: (OSD::advance_map(ObjectStore::Transaction&, C_Contexts*)+0x297=
1) [0x5cfb51]
> =A02: (OSD::handle_osd_map(MOSDMap*)+0x193c) [0x5d162c]
> =A03: (OSD::_dispatch(Message*)+0x2eb) [0x5d34fb]
> =A04: (OSD::ms_dispatch(Message*)+0x129) [0x5d3a59]
> =A05: (SimpleMessenger::dispatch_entry()+0x78b) [0x67513b]
> =A06: (SimpleMessenger::DispatchThread::entry()+0xd) [0x52124d]
> =A07: (()+0x7e9a) [0x7f6676226e9a]
> =A08: (clone()+0x6d) [0x7f66747db4bd]
> =A0ceph version 0.44.1 (commit:c89b7f22c8599eb974e75a2f7a5f855358199d=
ee)
> =A01: (OSD::advance_map(ObjectStore::Transaction&, C_Contexts*)+0x297=
1) [0x5cfb51]
> =A02: (OSD::handle_osd_map(MOSDMap*)+0x193c) [0x5d162c]
> =A03: (OSD::_dispatch(Message*)+0x2eb) [0x5d34fb]
> =A04: (OSD::ms_dispatch(Message*)+0x129) [0x5d3a59]
> =A05: (SimpleMessenger::dispatch_entry()+0x78b) [0x67513b]
> =A06: (SimpleMessenger::DispatchThread::entry()+0xd) [0x52124d]
> =A07: (()+0x7e9a) [0x7f6676226e9a]
> =A08: (clone()+0x6d) [0x7f66747db4bd]
> *** Caught signal (Aborted) **
> =A0in thread 7f66694b9700
> =A0ceph version 0.44.1 (commit:c89b7f22c8599eb974e75a2f7a5f855358199d=
ee)
> =A01: /usr/bin/ceph-osd() [0x6fa0c6]
> =A02: (()+0xfcb0) [0x7f667622ecb0]
> =A03: (gsignal()+0x35) [0x7f667471f445]
> =A04: (abort()+0x17b) [0x7f6674722bab]
> =A05: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7f667506d69=
d]
> =A06: (()+0xb5846) [0x7f667506b846]
> =A07: (()+0xb5873) [0x7f667506b873]
> =A08: (()+0xb596e) [0x7f667506b96e]
> =A09: (ceph::__ceph_assert_fail(char const*, char const*, int, char
> const*)+0x200) [0x68f420]
> =A010: (OSD::advance_map(ObjectStore::Transaction&, C_Contexts*)+0x29=
71)
> [0x5cfb51]
> =A011: (OSD::handle_osd_map(MOSDMap*)+0x193c) [0x5d162c]
> =A012: (OSD::_dispatch(Message*)+0x2eb) [0x5d34fb]
> =A013: (OSD::ms_dispatch(Message*)+0x129) [0x5d3a59]
> =A014: (SimpleMessenger::dispatch_entry()+0x78b) [0x67513b]
> =A015: (SimpleMessenger::DispatchThread::entry()+0xd) [0x52124d]
> =A016: (()+0x7e9a) [0x7f6676226e9a]
> =A017: (clone()+0x6d) [0x7f66747db4bd]
>
>
> --
> Tomasz Paszkowski
> SS7, Asterisk, SAN, Datacenter, Cloud Computing
> +48500166299



--=20
Tomasz Paszkowski
SS7, Asterisk, SAN, Datacenter, Cloud Computing
+48500166299
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
