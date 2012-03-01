From: Oliver Francke <Oliver.Francke@filoo.de>
Subject: Still inconsistant pg's, ceph-osd crashes reliably after trying to
 repair
Date: Thu, 01 Mar 2012 18:15:02 +0100
Message-ID: <4F4FAE96.7030801@filoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-5.de-punkt.de ([93.190.64.35]:36206 "EHLO
	mail-5.de-punkt.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932228Ab2CARPG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Mar 2012 12:15:06 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi *,

after some crashes we still had to care for some remaining=20
inconsistancies reported via
     ceph -w
and friends.
Well, we traced one of them down via
     ceph pg dump

and we picked 79. pg=3D79.7 and found the corresponding file in the=20
/var/log/ceph/osd.2.log.
     /data/osd4/current/79.7_head/rb.0.0.00000000136c__head_9FB2FA17
and the dup on
     /data/osd2/...
Strange though, they had the same checksum but reported a stat-error.=20
Anyway. Decided to do a:
     ceph pg repair 79.7
=2E.. byebye ceph-osd on node2!

Here the trace:

=3D=3D=3D 8-< =3D=3D=3D

2012-03-01 17:49:13.024571 7f3944584700 -- 10.10.10.14:6802/4892 >>=20
10.10.10.10:6802/19139 pipe(0xfcd2c80 sd=3D16 pgs=3D0 cs=3D0 l=3D0).con=
nect=20
protocol version mismatch, my 9 !=3D 0
2012-03-01 17:49:23.674162 7f395001b700 log [ERR] : 79.7 osd.4: soid=20
9fb2fa17/rb.0.0.00000000136c/headextra attr _, extra attr snapset
2012-03-01 17:49:23.674222 7f395001b700 log [ERR] : 79.7 repair 0=20
missing, 1 inconsistent objects
*** Caught signal (Aborted) **
  in thread 7f395001b700
  ceph version 0.42-142-gc9416e6=20
(commit:c9416e6184905501159e96115f734bdf65a74d28)
  1: /usr/bin/ceph-osd() [0x5a6b89]
  2: (()+0xeff0) [0x7f3960ca5ff0]
  3: (gsignal()+0x35) [0x7f395f2841b5]
  4: (abort()+0x180) [0x7f395f286fc0]
  5: (__gnu_cxx::__verbose_terminate_handler()+0x115) [0x7f395fb18dc5]
  6: (()+0xcb166) [0x7f395fb17166]
  7: (()+0xcb193) [0x7f395fb17193]
  8: (()+0xcb28e) [0x7f395fb1728e]
  9: (ceph::buffer::list::iterator::copy(unsigned int, char*)+0x13e)=20
[0x67c5ce]
  10: (object_info_t::decode(ceph::buffer::list::iterator&)+0x2c) [0x61=
663c]
  11: (PG::repair_object(hobject_t const&, ScrubMap::object*, int,=20
int)+0x3be) [0x68d96e]
  12: (PG::scrub_finalize()+0x1438) [0x6b8568]
  13: (OSD::ScrubFinalizeWQ::_process(PG*)+0xc) [0x588edc]
  14: (ThreadPool::worker()+0xa26) [0x5bc426]
  15: (ThreadPool::WorkThread::entry()+0xd) [0x585f0d]
  16: (()+0x68ca) [0x7f3960c9d8ca]
  17: (clone()+0x6d) [0x7f395f32186d]
2012-03-01 17:49:30.017269 7f81b662b780 ceph version 0.42-142-gc9416e6=20
(commit:c9416e6184905501159e96115f734bdf65a74d28), process ceph-osd, pi=
d=20
3111
2012-03-01 17:49:30.085426 7f81b662b780 filestore(/data/osd2) mount=20
=46IEMAP ioctl is NOT supported
2012-03-01 17:49:30.085466 7f81b662b780 filestore(/data/osd2) mount did=
=20
NOT detect btrfs
2012-03-01 17:49:30.110409 7f81b662b780 filestore(/data/osd2) mount=20
found snaps <>
2012-03-01 17:49:30.110476 7f81b662b780 filestore(/data/osd2) mount:=20
enabling WRITEAHEAD journal mode: btrfs not detected
2012-03-01 17:49:31.964977 7f81b662b780 journal _open /dev/sdc1 fd 16:=20
10737942528 bytes, block size 4096 bytes, directio =3D 1, aio =3D 0
2012-03-01 17:49:31.967549 7f81b662b780 journal read_entry 9292222464 :=
=20
seq 67841857 11225 bytes

=3D=3D=3D 8-< =3D=3D=3D

=2E.. after some journal-replay things calmed down, but:

     2012-03-01 17:58:29.470446   log 2012-03-01 17:58:24.242369 osd.2=20
10.10.10.14:6801/3111 368 : [WRN] bad locator @56 on object @79 loc @56=
=20
op osd_op(client.44350.0:1412387 rb.0.0.00000000136c [write=20
2465792~49152] 56.9fb2fa17) v4

these type of messages we see ever so often... It corresponds, but in=20
what way?

Can't we assume, if both snipplets "rb.0.0..." are identical, that=20
life's good?
We had some other inconsistancies, where we had to delete the whole poo=
l=20
to get rid of crappy
blocks. The ceph-osd died, too, after doing some
     rbd rm <pool>/<image>
the one block in question remained, visable via
     rados ls -p <pool>

Any idea, o better clue? ;-)

Kind reg's,

Oliver.

--=20

Oliver Francke

filoo GmbH
Moltkestra=DFe 25a
33330 G=FCtersloh
HRB4355 AG G=FCtersloh

Gesch=E4ftsf=FChrer: S.Grewing | J.Rehp=F6hler | C.Kunz

=46olgen Sie uns auf Twitter: http://twitter.com/filoogmbh

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
