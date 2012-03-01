From: Oliver Francke <Oliver.Francke@filoo.de>
Subject: Re: Still inconsistant pg's, ceph-osd crashes reliably after trying to repair
Date: Thu, 1 Mar 2012 19:07:55 +0100
Message-ID: <7E04D561-51D9-4BD4-ACC9-96063B3B48BF@filoo.de>
References: <4F4FAE96.7030801@filoo.de>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-3.de-punkt.de ([93.190.64.33]:60930 "EHLO
	mail-3.de-punkt.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753839Ab2CASOe convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Mar 2012 13:14:34 -0500
In-Reply-To: <4F4FAE96.7030801@filoo.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Well,

Am 01.03.2012 um 18:15 schrieb Oliver Francke:

> Hi *,
>=20
> after some crashes we still had to care for some remaining inconsista=
ncies reported via
>    ceph -w
> and friends.
> Well, we traced one of them down via
>    ceph pg dump
>=20
> and we picked 79. pg=3D79.7 and found the corresponding file in the /=
var/log/ceph/osd.2.log.
>    /data/osd4/current/79.7_head/rb.0.0.00000000136c__head_9FB2FA17
> and the dup on
>    /data/osd2/...
> Strange though, they had the same checksum but reported a stat-error.=
 Anyway. Decided to do a:
>    ceph pg repair 79.7
> ... byebye ceph-osd on node2!
>=20
> Here the trace:
>=20
> =3D=3D=3D 8-< =3D=3D=3D
>=20
> 2012-03-01 17:49:13.024571 7f3944584700 -- 10.10.10.14:6802/4892 >> 1=
0.10.10.10:6802/19139 pipe(0xfcd2c80 sd=3D16 pgs=3D0 cs=3D0 l=3D0).conn=
ect protocol version mismatch, my 9 !=3D 0
> 2012-03-01 17:49:23.674162 7f395001b700 log [ERR] : 79.7 osd.4: soid =
9fb2fa17/rb.0.0.00000000136c/headextra attr _, extra attr snapset

one clarification by ourselves done: one copy is missing the xattrs, ch=
ecked via
	getfattr
but why can't it be corrected, and worse this crash happens?

> 2012-03-01 17:49:23.674222 7f395001b700 log [ERR] : 79.7 repair 0 mis=
sing, 1 inconsistent objects
> *** Caught signal (Aborted) **
> in thread 7f395001b700
> ceph version 0.42-142-gc9416e6 (commit:c9416e6184905501159e96115f734b=
df65a74d28)
> 1: /usr/bin/ceph-osd() [0x5a6b89]
> 2: (()+0xeff0) [0x7f3960ca5ff0]
> 3: (gsignal()+0x35) [0x7f395f2841b5]
> 4: (abort()+0x180) [0x7f395f286fc0]
> 5: (__gnu_cxx::__verbose_terminate_handler()+0x115) [0x7f395fb18dc5]
> 6: (()+0xcb166) [0x7f395fb17166]
> 7: (()+0xcb193) [0x7f395fb17193]
> 8: (()+0xcb28e) [0x7f395fb1728e]
> 9: (ceph::buffer::list::iterator::copy(unsigned int, char*)+0x13e) [0=
x67c5ce]
> 10: (object_info_t::decode(ceph::buffer::list::iterator&)+0x2c) [0x61=
663c]
> 11: (PG::repair_object(hobject_t const&, ScrubMap::object*, int, int)=
+0x3be) [0x68d96e]
> 12: (PG::scrub_finalize()+0x1438) [0x6b8568]
> 13: (OSD::ScrubFinalizeWQ::_process(PG*)+0xc) [0x588edc]
> 14: (ThreadPool::worker()+0xa26) [0x5bc426]
> 15: (ThreadPool::WorkThread::entry()+0xd) [0x585f0d]
> 16: (()+0x68ca) [0x7f3960c9d8ca]
> 17: (clone()+0x6d) [0x7f395f32186d]
> 2012-03-01 17:49:30.017269 7f81b662b780 ceph version 0.42-142-gc9416e=
6 (commit:c9416e6184905501159e96115f734bdf65a74d28), process ceph-osd, =
pid 3111
> 2012-03-01 17:49:30.085426 7f81b662b780 filestore(/data/osd2) mount F=
IEMAP ioctl is NOT supported
> 2012-03-01 17:49:30.085466 7f81b662b780 filestore(/data/osd2) mount d=
id NOT detect btrfs
> 2012-03-01 17:49:30.110409 7f81b662b780 filestore(/data/osd2) mount f=
ound snaps <>
> 2012-03-01 17:49:30.110476 7f81b662b780 filestore(/data/osd2) mount: =
enabling WRITEAHEAD journal mode: btrfs not detected
> 2012-03-01 17:49:31.964977 7f81b662b780 journal _open /dev/sdc1 fd 16=
: 10737942528 bytes, block size 4096 bytes, directio =3D 1, aio =3D 0
> 2012-03-01 17:49:31.967549 7f81b662b780 journal read_entry 9292222464=
 : seq 67841857 11225 bytes
>=20
> =3D=3D=3D 8-< =3D=3D=3D
>=20
> ... after some journal-replay things calmed down, but:
>=20
>    2012-03-01 17:58:29.470446   log 2012-03-01 17:58:24.242369 osd.2 =
10.10.10.14:6801/3111 368 : [WRN] bad locator @56 on object @79 loc @56=
 op osd_op(client.44350.0:1412387 rb.0.0.00000000136c [write 2465792~49=
152] 56.9fb2fa17) v4
>=20
> these type of messages we see ever so often... It corresponds, but in=
 what way?
>=20
> Can't we assume, if both snipplets "rb.0.0..." are identical, that li=
fe's good?
> We had some other inconsistancies, where we had to delete the whole p=
ool to get rid of crappy
> blocks. The ceph-osd died, too, after doing some
>    rbd rm <pool>/<image>
> the one block in question remained, visable via
>    rados ls -p <pool>
>=20
> Any idea, o better clue? ;-)
>=20
> Kind reg's,
>=20
> Oliver.
>=20
> --=20
>=20
> Oliver Francke
>=20
> filoo GmbH
> Moltkestra=DFe 25a
> 33330 G=FCtersloh
> HRB4355 AG G=FCtersloh
>=20
> Gesch=E4ftsf=FChrer: S.Grewing | J.Rehp=F6hler | C.Kunz
>=20
> Folgen Sie uns auf Twitter: http://twitter.com/filoogmbh
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
