From: Sage Weil <sage@newdream.net>
Subject: Re: cmon: PGMonitor::encode_pending() assert failure
Date: Thu, 3 Feb 2011 13:03:17 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1102031301550.19855@cobra.newdream.net>
References: <slrnikk2hd.jh1.chris@chris.onthe.net.au>
 <AANLkTi=SyqVD8MyCt+ybYrhoSHunYrchcdZUvW-nzOgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-2106615332-1296766997=:19855"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40827 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752407Ab1BCVC3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Feb 2011 16:02:29 -0500
In-Reply-To: <AANLkTi=SyqVD8MyCt+ybYrhoSHunYrchcdZUvW-nzOgw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: chris@onthe.net.au
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-2106615332-1296766997=:19855
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Chris,

This is an interesting one.  Would it be possible for you to tar up your=20
mondata directory on the failed node and post it somewhere I can get at=20
it?  From the looks of things the pgmap incremental state file is=20
truncated, but I'd like to confirm.

http://tracker.newdream.net/issues/762

Thanks!
sage


On Thu, 3 Feb 2011, Gregory Farnum wrote:

> ---------- Forwarded message ----------
> From: Chris Dunlop <chris@onthe.net.au>
> Date: Wed, Feb 2, 2011 at 5:51 PM
> Subject: cmon: PGMonitor::encode_pending() assert failure
> To: ceph-devel@vger.kernel.org
>=20
>=20
> G'day,
>=20
> I received this assert failure after copying about 110 GB of data into
> a previously-empty ceph 0.24.2:
>=20
> ceph version 0.25~rc (commit:73e76723e35562c9391872e07cf314b4465f30af)
> 2011-02-03 08:05:26.779951 409b9950 mon.0@0(leader).pg v19635
> PGMonitor::update_from_paxos: error parsing incremental update:
> buffer::end_of_buffer
> 2011-02-03 08:05:28.651238 42b99950 mon.0@0(leader).pg v19635
> PGMonitor::update_from_paxos: error parsing incremental update:
> buffer::end_of_buffer
> mon/PGMonitor.cc: In function 'virtual void
> PGMonitor::encode_pending(ceph::bufferlist&)', In thread 409b9950
> mon/PGMonitor.cc:178: FAILED assert(paxos->get_version() + 1 =3D=3D
> pending_inc.version)
> =A0ceph version 0.25~rc (commit:73e76723e35562c9391872e07cf314b4465f30af)
> =A01: (PGMonitor::encode_pending(ceph::buffer::list&)+0x442) [0x4d4332]
> =A02: (PaxosService::propose_pending()+0x26d) [0x4995ad]
> =A03: (SafeTimer::timer_thread()+0x65f) [0x5602bf]
> =A04: (SafeTimerThread::entry()+0xd) [0x563a3d]
> =A05: (Thread::_entry_func(void*)+0xa) [0x46fe0a]
> =A06: /lib/libpthread.so.0 [0x7f282fd87fc7]
> =A07: (clone()+0x6d) [0x7f282ec6764d]
> =A0NOTE: a copy of the executable, or `objdump -rdS <executable>` is
> needed to interpret this.
> *** Caught signal (Aborted) ***
> in thread 409b9950
> =A0ceph version 0.25~rc (commit:73e76723e35562c9391872e07cf314b4465f30af)
> =A01: /usr/bin/cmon [0x58054e]
> =A02: /lib/libpthread.so.0 [0x7f282fd8fa80]
> =A03: (gsignal()+0x35) [0x7f282ebc9ed5]
> =A04: (abort()+0x183) [0x7f282ebcb3f3]
> =A05: (__gnu_cxx::__verbose_terminate_handler()+0x114) [0x7f282f44d294]
> =A06: /usr/lib/libstdc++.so.6 [0x7f282f44b696]
> =A07: /usr/lib/libstdc++.so.6 [0x7f282f44b6c3]
> =A08: /usr/lib/libstdc++.so.6 [0x7f282f44b7aa]
> =A09: (ceph::__ceph_assert_fail(char const*, char const*, int, char
> const*)+0x3f4) [0x563f84]
> =A0a: (PGMonitor::encode_pending(ceph::buffer::list&)+0x442) [0x4d4332]
> =A0b: (PaxosService::propose_pending()+0x26d) [0x4995ad]
> =A0c: (SafeTimer::timer_thread()+0x65f) [0x5602bf]
> =A0d: (SafeTimerThread::entry()+0xd) [0x563a3d]
> =A0e: (Thread::_entry_func(void*)+0xa) [0x46fe0a]
> =A0f: /lib/libpthread.so.0 [0x7f282fd87fc7]
> =A010: (clone()+0x6d) [0x7f282ec6764d]
>=20
> If needed, the cmon executable is available here:
>=20
> http://www.onthe.net.au/private/cmon.gz
>=20
> If you need any other info, just holler!
>=20
> Cheers,
>=20
> Chris
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-2106615332-1296766997=:19855--
