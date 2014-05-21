From: Sage Weil <sage@inktank.com>
Subject: Re: [Performance] Improvement on DB Performance
Date: Wed, 21 May 2014 11:41:52 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1405211141180.16657@cobra.newdream.net>
References: <CACJqLyY5VSQubaPvk2N3BrRx=YZ7EpiyRJZbWnNM=bQMfNA8=w@mail.gmail.com> <CACJqLyYFMAxoVUZCTvPMXFGrYEPmFqTd+pZmsL2V=V1L32CisQ@mail.gmail.com> <alpine.DEB.2.00.1405210821420.1689@cobra.newdream.net> <537CCB49.8060408@cloudapt.com>
 <alpine.DEB.2.00.1405210857130.16657@cobra.newdream.net> <77004F70-7FE7-4EBE-A34D-46A8DC290936@profihost.ag>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-340308043-1400697712=:16657"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40829 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751801AbaEUSlx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 May 2014 14:41:53 -0400
In-Reply-To: <77004F70-7FE7-4EBE-A34D-46A8DC290936@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: Mike Dawson <mike.dawson@cloudapt.com>, Haomai Wang <haomaiwang@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-340308043-1400697712=:16657
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, 21 May 2014, Stefan Priebe - Profihost AG wrote:
> Hi sage,
>=20
> what about cuttlefish customers?

We stopped backporting fixes to cuttlefish a while ago.  Please upgrade t=
o=20
dumpling!

That said, this patch should apply cleanly to cuttlefish.

sage


>=20
> Greets,
> Stefan
> Excuse my typo sent from my mobile phone.
>=20
> Am 21.05.2014 um 18:15 schrieb Sage Weil <sage@inktank.com>:
>=20
>       On Wed, 21 May 2014, Mike Dawson wrote:
>             Haomai,
>=20
>=20
>             Thanks for finding this!
>=20
>=20
>=20
>             Sage,
>=20
>=20
>             We have a client that runs an io intensive, closed-source s=
oftware
>             package
>=20
>             that seems to issue overzealous flushes which may benefit f=
rom this
>             patch (or
>=20
>             the other methods you mention). If you were to spin a wip b=
uild based
>             on
>=20
>             Dumpling, I'll be a willing tester.
>=20
>=20
>       Pushed wip-librbd-flush-dumpling, should be built shortly.
>=20
>       sage
>=20
>=20
>             Thanks,
>=20
>             Mike Dawson
>=20
>=20
>             On 5/21/2014 11:23 AM, Sage Weil wrote:
>=20
>                   On Wed, 21 May 2014, Haomai Wang wrote:
>=20
>                         I pushed the commit to fix this
>=20
>                         problem(https://github.com/ceph/ceph/pull/1848)=
.
>=20
>=20
>                         With test program(Each sync request is issued
>                         with ten write request),
>=20
>                         a significant improvement is noticed.
>=20
>=20
>                         aio_flush =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sum: 914750
>                         =C2=A0=C2=A0=C2=A0=C2=A0avg: 1239 =C2=A0=C2=A0c=
ount:
>=20
>                         738 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0max: 4714 =C2=
=A0=C2=A0min: 1011
>=20
>                         flush_set =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sum: 904200
>                         =C2=A0=C2=A0=C2=A0=C2=A0avg: 1225 =C2=A0=C2=A0c=
ount:
>=20
>                         738 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0max: 4698 =C2=
=A0=C2=A0min: 999
>=20
>                         flush =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sum: 641648
>                         =C2=A0=C2=A0=C2=A0=C2=A0avg: 173 =C2=A0=C2=A0=C2=
=A0count:
>=20
>                         3690 =C2=A0=C2=A0=C2=A0=C2=A0max: 1340 =C2=A0=C2=
=A0min: 128
>=20
>=20
>                         Compared to last mail, it reduce each aio_flush
>                         request to 1239 ns
>=20
>                         instead of 24145 ns.
>=20
>=20
>                   Good catch! =C2=A0That's a great improvement.
>=20
>=20
>                   The patch looks clearly correct. =C2=A0We can probabl=
y do even
>                   better by
>=20
>                   putting the Objects on a list when they get the first=
 dirty
>                   buffer so that
>=20
>                   we only cycle through the dirty ones. =C2=A0Or, have =
a global
>                   list of dirty
>=20
>                   buffers (instead of dirty objects -> dirty buffers).
>=20
>=20
>                   sage
>=20
>=20
>=20
>                         I hope it's the root cause for db on rbd
>                         performance.
>=20
>=20
>                         On Wed, May 21, 2014 at 6:15 PM, Haomai Wang
>                         <haomaiwang@gmail.com> wrote:
>=20
>                               Hi all,
>=20
>=20
>                               I remember there exists discuss
>                               about DB(mysql) performance on rbd.
>=20
>                               Recently I test mysql-bench with
>                               rbd and found awful performance. So
>                               I
>=20
>                               dive into it and find that main
>                               cause is "flush" request from
>                               guest.
>=20
>                               As we know, applications such as
>                               mysql, ceph has own journal for
>=20
>                               durable and journal usually send
>                               sync&direct io. If fs barrier is
>                               on,
>=20
>                               each sync io operation make kernel
>                               issue "sync"(barrier) request to
>=20
>                               block device. Here, qemu will call
>                               "rbd_aio_flush" to apply.
>=20
>=20
>                               Via systemtap, I found a amazing
>                               thing:
>=20
>                               aio_flush
>                               =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sum:
>                               4177085 =C2=A0=C2=A0=C2=A0avg: 24145 =C2=A0=
count:
>=20
>                               173 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0max: 28=
172 =C2=A0min: 22747
>=20
>                               flush_set
>                               =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sum:
>                               4172116 =C2=A0=C2=A0=C2=A0avg: 24116 =C2=A0=
count:
>=20
>                               173 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0max: 28=
034 =C2=A0min: 22733
>=20
>                               flush
>                               =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sum:
>                               3029910 =C2=A0=C2=A0=C2=A0avg: 4 =C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0count:
>=20
>                               670477 =C2=A0=C2=A0max: 1893 =C2=A0=C2=A0=
min: 3
>=20
>=20
>                               This statistic info is gathered in
>                               5s. Most of consuming time is on
>=20
>                               "ObjectCacher::flush". What's more,
>                               with time increasing, the flush
>=20
>                               count will be increasing.
>=20
>=20
>                               After view source, I find the root
>                               cause is "ObjectCacher::flush_set",
>=20
>                               it will iterator the "object_set"
>                               and look for dirty buffer. And
>=20
>                               "object_set" =C2=A0contains all objects
>                               ever opened. =C2=A0For example:
>=20
>=20
>                               2014-05-21 18:01:37.959013
>                               7f785c7c6700 =C2=A00 objectcacher
>                               flush_set
>=20
>                               total: 5919 flushed: 5
>=20
>                               2014-05-21 18:01:37.999698
>                               7f785c7c6700 =C2=A00 objectcacher
>                               flush_set
>=20
>                               total: 5919 flushed: 5
>=20
>                               2014-05-21 18:01:38.038405
>                               7f785c7c6700 =C2=A00 objectcacher
>                               flush_set
>=20
>                               total: 5920 flushed: 5
>=20
>                               2014-05-21 18:01:38.080118
>                               7f785c7c6700 =C2=A00 objectcacher
>                               flush_set
>=20
>                               total: 5920 flushed: 5
>=20
>                               2014-05-21 18:01:38.119792
>                               7f785c7c6700 =C2=A00 objectcacher
>                               flush_set
>=20
>                               total: 5921 flushed: 5
>=20
>                               2014-05-21 18:01:38.162004
>                               7f785c7c6700 =C2=A00 objectcacher
>                               flush_set
>=20
>                               total: 5922 flushed: 5
>=20
>                               2014-05-21 18:01:38.202755
>                               7f785c7c6700 =C2=A00 objectcacher
>                               flush_set
>=20
>                               total: 5923 flushed: 5
>=20
>                               2014-05-21 18:01:38.243880
>                               7f785c7c6700 =C2=A00 objectcacher
>                               flush_set
>=20
>                               total: 5923 flushed: 5
>=20
>                               2014-05-21 18:01:38.284399
>                               7f785c7c6700 =C2=A00 objectcacher
>                               flush_set
>=20
>                               total: 5923 flushed: 5
>=20
>=20
>                               These logs record the iteration
>                               info, the loop will check 5920
>                               objects
>=20
>                               but only 5 objects are dirty.
>=20
>=20
>                               So I think the solution is make
>                               "ObjectCacher::flush_set" only
>=20
>                               iterator the objects which is
>                               dirty.
>=20
>=20
>                               --
>=20
>                               Best Regards,
>=20
>=20
>                               Wheat
>=20
>=20
>=20
>=20
>                         --
>=20
>                         Best Regards,
>=20
>=20
>                         Wheat
>=20
>                         --
>=20
>                         To unsubscribe from this list: send the line
>                         "unsubscribe ceph-devel" in
>=20
>                         the body of a message to
>                         majordomo@vger.kernel.org
>=20
>                         More majordomo info at
>                         =C2=A0http://vger.kernel.org/majordomo-info.htm=
l
>=20
>=20
>=20
>                   --
>=20
>                   To unsubscribe from this list: send the line "unsubsc=
ribe
>                   ceph-devel" in
>=20
>                   the body of a message to majordomo@vger.kernel.org
>=20
>                   More majordomo info at
>                   =C2=A0http://vger.kernel.org/majordomo-info.html
>=20
>=20
>             --
>=20
>             To unsubscribe from this list: send the line "unsubscribe c=
eph-devel"
>             in
>=20
>             the body of a message to majordomo@vger.kernel.org
>=20
>             More majordomo info at =C2=A0http://vger.kernel.org/majordo=
mo-info.html
>=20
>=20
>=20
>       --
>       To unsubscribe from this list: send the line "unsubscribe ceph-de=
vel" in
>       the body of a message to majordomo@vger.kernel.org
>       More majordomo info at =C2=A0http://vger.kernel.org/majordomo-inf=
o.html
>=20
>=20
>=20
--557981400-340308043-1400697712=:16657--
