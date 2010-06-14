From: Andre Noll <maan@systemlinux.org>
Subject: Re: osd: terminate called after throwing an instance of 'std::bad_alloc'
Date: Mon, 14 Jun 2010 10:48:58 +0200
Message-ID: <20100614084858.GC17950@skl-net.de>
References: <Pine.LNX.4.64.1006021115240.1269@cobra.newdream.net> <20100604084521.GO1211@skl-net.de> <Pine.LNX.4.64.1006040944331.2384@cobra.newdream.net> <20100607080754.GU1211@skl-net.de> <20100607080932.GV1211@skl-net.de> <Pine.LNX.4.64.1006071016470.20365@cobra.newdream.net> <20100608122838.GA9152@skl-net.de> <Pine.LNX.4.64.1006082246540.3595@cobra.newdream.net> <20100609081604.GG9152@skl-net.de> <Pine.LNX.4.64.1006091025500.28853@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FsscpQKzF/jJk6ya"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from systemlinux.org ([83.151.29.59]:59862 "EHLO m18s25.vlinux.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755292Ab0FNItL (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 14 Jun 2010 04:49:11 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1006091025500.28853@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org


--FsscpQKzF/jJk6ya
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 09, 10:29, Sage Weil wrote:

> > I'll let you know if I can trigger it reliably.

I recreated the cephfs using the same setup (7 osds, 3 mons, 3 mds),
and the problem happened again, this time while running "stress"
=66rom two clients over the weekend.

This morning all stress processes were stuck in state D and access
to the ceph fs blocks. Not even ls -l works.  I rebooted one machine
that was running stress, cosd, cmds and cmon. Had to power cycle it
as reboot was unable to kill the stress processes.

On reboot, cosd crashes after a few seconds due to hitting

	assert(recovering_oids.count(soid) =3D=3D 0

in start_recovery_op(). gdb output:


	osd/PG.cc: In function 'void PG::start_recovery_op(const sobject_t&)':
	osd/PG.cc:1833: FAILED assert(recovering_oids.count(soid) =3D=3D 0)
	 1: (ReplicatedPG::issue_repop(ReplicatedPG::RepGather*, utime_t, eversion=
_t, bool, unsigned long, eversion_t)+0x84e) [0x49c88e]
	 2: (ReplicatedPG::do_op(MOSDOp*)+0xa9a) [0x4a22ba]
	 3: (OSD::dequeue_op(PG*)+0x402) [0x4e4dc2]
	 4: (ThreadPool::worker()+0x1fc) [0x5ec64c]
	 5: (ThreadPool::WorkThread::entry()+0xd) [0x50480d]
	 6: (Thread::_entry_func(void*)+0x7) [0x476f57]
	 7: /lib/libpthread.so.0 [0x7fc9556523f7]
	 8: (clone()+0x6d) [0x7fc9548a7b4d]
	 NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed =
to interpret this.
	terminate called after throwing an instance of 'ceph::FailedAssertion*'

	Program received signal SIGABRT, Aborted.

	(gdb) bt
	#0  0x00007fc954802095 in raise () from /lib/libc.so.6
	#1  0x00007fc954803af0 in abort () from /lib/libc.so.6
	#2  0x00007fc9550870e4 in __gnu_cxx::__verbose_terminate_handler () from /=
usr/lib/libstdc++.so.6
	#3  0x00007fc955085076 in ?? () from /usr/lib/libstdc++.so.6
	#4  0x00007fc9550850a3 in std::terminate () from /usr/lib/libstdc++.so.6
	#5  0x00007fc95508518a in __cxa_throw () from /usr/lib/libstdc++.so.6
	#6  0x00000000005eb22f in ceph::__ceph_assert_fail (assertion=3D0x6211d0 "=
recovering_oids.count(soid) =3D=3D 0", file=3D0x620113 "osd/PG.cc", line=3D=
1833,=20
	    func=3D0x622140 "void PG::start_recovery_op(const sobject_t&)") at com=
mon/assert.cc:30
	#7  0x0000000000546b68 in PG::start_recovery_op (this=3D0xa846d0, soid=3D@=
0x12ceb98) at osd/PG.cc:1833
	#8  0x000000000049c88e in ReplicatedPG::issue_repop (this=3D0xa846d0, repo=
p=3D0x1296d70, now=3D<value optimized out>, old_last_update=3D
	      {version =3D 249, epoch =3D 137, __pad =3D 0}, old_exists=3Dtrue, ol=
d_size=3D4194304, old_version=3D{version =3D 249, epoch =3D 137, __pad =3D =
0})
	    at osd/ReplicatedPG.cc:2280
	#9  0x00000000004a22ba in ReplicatedPG::do_op (this=3D0xa846d0, op=3D<valu=
e optimized out>) at osd/ReplicatedPG.cc:637
	#10 0x00000000004e4dc2 in OSD::dequeue_op (this=3D0x8a9fc0, pg=3D0xa846d0)=
 at osd/OSD.cc:4456
	#11 0x00000000005ec64c in ThreadPool::worker (this=3D0x8aa478) at common/W=
orkQueue.cc:44
	#12 0x000000000050480d in ThreadPool::WorkThread::entry (this=3D<value opt=
imized out>) at ./common/WorkQueue.h:113
	#13 0x0000000000476f57 in Thread::_entry_func (arg=3D0xa63) at ./common/Th=
read.h:39
	#14 0x00007fc9556523f7 in start_thread () from /lib/libpthread.so.0
	#15 0x00007fc9548a7b4d in clone () from /lib/libc.so.6
	#16 0x0000000000000000 in ?? ()

I also ran the checkpg script as you suggested, but this did not find
any corrupted pgs. The tip of the git branch this cosd was compiled
=66rom is

	214a42798b4a5cd57d09c6a13b39b17c4f616aa3 (mds: handle dup anchorclient ACK=
s gracefully)

Any hints?
Andre
--=20
The only person who always got his work done by Friday was Robinson Crusoe

--FsscpQKzF/jJk6ya
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFMFez6Wto1QDEAkw8RAloZAJ9ZlXxXp+xMZJiS9ybTWZwLA8/mbgCcC6TV
jCvpxdksXfQVfqIUp9+oiwo=
=QfEi
-----END PGP SIGNATURE-----

--FsscpQKzF/jJk6ya--
