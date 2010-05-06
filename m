From: Sage Weil <sage@newdream.net>
Subject: Re: RBD/OSD questions
Date: Thu, 6 May 2010 10:14:00 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1005060954150.18563@cobra.newdream.net>
References: <853578.71750.qm@web36102.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-20101323-1273166040=:18563"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45392 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753473Ab0EFRLK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 6 May 2010 13:11:10 -0400
In-Reply-To: <853578.71750.qm@web36102.mail.mud.yahoo.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin Fick <mogulguy@yahoo.com>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-20101323-1273166040=:18563
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 6 May 2010, Martin Fick wrote:
> I have a few more questions.
>=20
> -Can files stored in the OSD heal "incrementally"?
>=20
> Suppose there are 3 replicas for a large file and that
> a small byte range change occurs while replica 3 is=20
> down.=A0 Will replica 3 heal efficiently when it=20
> returns?=A0 Will only the small changed byte range=20
> be transferred?

Currently, no.  This is a big item on the TODO list, both for efficiency=20
here, and also to facilitate better memory and network IO when=20
objects are large (recovery currently loads, sends, saves objects in their=
=20
entirety).

> -Also, can reads be spreadout over replicas?
>=20
> This might be a nice optimization to reduce seek
> times under certain conditions, when there are no
> writers or the writer is the only reader (and thus
> is aware of all the writes even before they=20
> complete).  Under these conditions it seems like it
> would be possible to not enforce the "tail reading"
> order of replicas and thus additionally benefit
> from "read stripping" across the replicas the way
> many raid implementations do with RAID1.
>=20
> I thought that this might be particularly useful
> for RBD when it is used exclusively (say by mounting
> a local FS)  since even with replicas, it seems like
> it could then relax the replica tail reading=20
> constraint.

The idea certainly has it's appeal, and I played with it for a while a few=
=20
years back.  At that time I had a _really_ hard time trying to manufacture=
=20
a workload scenario where it actually mades things faster and not slower. =
=20
In general, spreading out reads will pollute caches (e.g., spreading=20
across two replicas means caches are half as effective). =20

What I tried to do was use fast heartbeats between OSDs to shared average=
=20
request queue lengths, so that the primary could 'shed' a read request to=
=20
a replica if it's queue length/request latency was significantly shorter. =
=20
I wasn't really able to make it work.

In the case of very hot objects, the primary will already have it in=20
cache, and the fastest thing is to just serve it up immediately.  Unless=20
the network port is fully saturated. For cold objects, shedding could=20
help, but only if there is a sufficient load disparity between replicas to=
=20
compensate for the overhead of shedding.  At the time I had trouble=20
simluating either situation.  Also, the client/osd interface has changed=20
such that only clients initiate connections, so the previous shed=20
path (client -> osd1 -> osd2 -> client) won't work.

We're certainly open to any ideas in this area...

sage
--557981400-20101323-1273166040=:18563--
