From: Sage Weil <sage@newdream.net>
Subject: Re: RBD/OSD questions
Date: Thu, 6 May 2010 14:31:20 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1005061430230.18563@cobra.newdream.net>
References: <190959.13001.qm@web36108.mail.mud.yahoo.com>
 <20100506222409.f1f464be.ctpm@ist.utl.pt>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1288171377-1273181480=:18563"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49516 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751771Ab0EFV22 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 6 May 2010 17:28:28 -0400
In-Reply-To: <20100506222409.f1f464be.ctpm@ist.utl.pt>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?Q2zDoXVkaW8=?= Martins <ctpm@ist.utl.pt>
Cc: Martin Fick <mogulguy@yahoo.com>, ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1288171377-1273181480=:18563
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 6 May 2010, Cl=E1udio Martins wrote:
> On Thu, 6 May 2010 14:02:40 -0700 (PDT) Martin Fick <mogulguy@yahoo.com> =
wrote:
> >=20
> > Hmm, I wonder if using a local FS on top of RBD would
> > be such a different use case from ceph that this may
> > not be very difficult to produce such a workload with. =20
> > With a local FS on RBD I would expect massive local=20
> > kernel level caching.  With this in mind I wonder how
> > effective OSD level caching would actually be.
> >=20
> > I am particularly thinking of heavy seeky workloads=20
> > which perhaps are somewhat already spreadout due to
> > stripping.  In other words RAID1 (mirroring) can=20
> > decrease latencies over a non RAID setup locally even
> > though that is not the objective of RAID1, but does
> > RAID01 decrease latencies much over RAID0, maybe not?
> > That might explain the difficulty in creating such
> > a scenario.
> >=20
> > To put this in the perspective of OSD setups, if you=20
> > already have stripping, using the replicas also may=20
> > not make much of a difference, but I wonder how a two
> > node OSD setup with double redundancy would fair? =20
> > With such a setup there will not really be any=20
> > stripping will there?  With such a setup (one that I=20
> > can easily see being popular for simple/minimal RBD
> > redundancy setups), perhaps replica "stripping"
> > would help.  A 'smart' RBD could detect non=20
> > contiguous reads and spread the reads out in that
> > case.
> >=20
>=20
>  Unless I understood wrongly the Ceph papers, the current situation is
> not that bad.
>=20
>  IIRC, a big file will be stripped over many different objects. Each
> object ID will map to its own primary replica, which will be vary from
> object to object. Thus, given many clients reading different chunks of
> that file, even 2 OSDs should see a fairly equal amount of traffic. The
> same should be true for small files. Unless you have lots of clients
> all reading the same file.

Yeah, you've got it right.  The rbd image is striped over small objects,=20
which are independently assigned to OSDs.  The load should be very well=20
distributed.

sage
--557981400-1288171377-1273181480=:18563--
