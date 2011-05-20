From: Sage Weil <sage@newdream.net>
Subject: Re: (un)stability of ceph
Date: Fri, 20 May 2011 12:45:15 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1105201238250.25242@cobra.newdream.net>
References: <C424A186-75DB-4CC5-A662-A538E7D5BA4C@uni-osnabrueck.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-732496624-1305920305=:25242"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45114 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757170Ab1ETToG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 May 2011 15:44:06 -0400
In-Reply-To: <C424A186-75DB-4CC5-A662-A538E7D5BA4C@uni-osnabrueck.de>
Content-ID: <Pine.LNX.4.64.1105201238310.6453@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Udo Waechter <udo.waechter@uni-osnabrueck.de>
Cc: Ceph Developers <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-732496624-1305920305=:25242
Content-Type: TEXT/PLAIN; CHARSET=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <Pine.LNX.4.64.1105201238311.6453@cobra.newdream.net>

Hi Udo,

On Thu, 19 May 2011, Udo Waechter wrote:
> Hi there.
> I'm new to the list, but am following the development of ceph for a=20
> while now. Great project. It really looks like the next big things.
>=20
> After researching parallel/shared filesystems for a last year, we tried=
=20
> to implement lustre. This project basically died for us with Oracle's=20
> aquirement of sun and all the confusion that came afterwards. Anyway, we=
=20
> then decided for another FS, which now turns out to be an error of the=20
> big kind. Its unstable und unreliable.

Just out of curiousity, what was the other fs?

> Now, I am in the bad position to quickly have to switch to another FS.=20
> Before I start implementing another FS, I would like to ask about the=20
> status of ceph. I know that it is not supposed to be used in an=20
> production environment. Nevertheless, I am inclined to give ceph a try.=
=20
> Our plans were to switch to ceph anyway as soon as it is considered=20
> stable. Our usage scenarios are these:
>=20
> * multiple OSDs, multiple MDs.
> * shared storage for KVM and XEN (does not need to be Rados Block device,=
 can be images as we have it now)
> ** the VM-servers are interconnected via internal 2x1Gbit nics and also h=
ave 1Gbit nic to the external LAN.
> ** traffic for vm-images or RBD should go over internal NICS (can ceph ha=
ndle such a scenario?).
> * shared storage for user data. workloads are not very high, but potentia=
lly many clients (currently 100-200)
> ** POSIX compatibity is a must (directory permissions, primary and second=
ary group access, for personal files and working group files)
> ** speed is not of great importance, our LAN is 1Gbit.
> ** Workstations are Debian/Ubuntu Linux (most of them) and OS X, the fewe=
st are Windows. Is it possible (without great hassle) to reexport ceph volu=
mes via nfs/samba (for OS X, windows)

Based on your requirements, it sounds like Ceph is a good fit.  As for=20
status, here is the latest update:

- Ceph is not yet ready for production however, we are confident that we=20
  are only a few months away
- We have not experienced any data loss on our pseudo-production=20
  test clusters for quite some time now.
- We (DreamHost) have expanded the core team on Ceph to 7 people who are
  primarily working on stability and performance
- Each month more and more people are digging in and getting involved in=20
  the project which we hope will accelerate development further
- We are very close to launching a hosted beta of the object store layer=20
  which will help us identify foundational issues

In addition to the technical efforts, DreamHost is working on formalizing=
=20
the Enterprise Support services. We hope to have this support=20
infrastructure in place by end of Q2, beginning of Q3.

A few other specific points:
- The single MDS configuration is much more stable than a clustered one. =
=20
  Given your current scale I suspect a single MDS will be sufficient.
- We haven't done much of any work getting the fuse client to work under=20
  OS X.  You'll probably be best off reexporting via cifs or nfs.  There=20
  is ongoing work to allow samba talk directly to libceph.

I hope that gives you a bit more information to base your decision on!

sage



> Our storage server currenlty are: 2x Dell R510 with 12x1TB (one of=20
> them), 12x2TB (the second), 16Gbs ram and a i7QuadCore. A third (with=20
> 12x2Tb) and fourth are on their way. These would make OSDs and MDses, I=
=20
> guess.
>=20
> What are your opinions? Is ceph considered unstable in all use-cases, or=
=20
> would a moderate work-load work even in production environments? Are=20
> there any compatibility-breaking updates on their way?
>=20
> I would rather start using ceph now, even if it is not 100% performant.=
=20
> As long as it is 99% stable and data-loss or corruption is not really=20
> expected....
>=20
> Thanks for your thoughts,
> udo.
> --=20
> :: udo waechter - root@zoide.net :: N 52=BA16'30.5" E 8=BA3'10.1"
> :: genuine input for your ears: http://auriculabovinari.de=20
> ::                          your eyes: http://ezag.zoide.net
> ::                          your brain: http://zoide.net
>=20
>=20
>=20
>=20
>=20
--557981400-732496624-1305920305=:25242--
