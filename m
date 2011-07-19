From: Sage Weil <sage@newdream.net>
Subject: Re: workload balance
Date: Tue, 19 Jul 2011 07:39:15 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1107190735050.5656@cobra.newdream.net>
References: <BANLkTikHkttLd6vMeZxVm4FNeGJ+-E9uTg@mail.gmail.com>
 <4E08F0E5.4080501@dreamhost.com> <BANLkTi=rSvuawL_VqVYZqpif=GEj+iivmQ@mail.gmail.com>
 <4E0CBAA5.50804@dreamhost.com> <CAMjNe_fkt1Mw489F_=dxGCqoxZes1ASZu5hGBJtiCgOMNYoeNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-633003330-1311086355=:5656"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37856 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933Ab1GSOfl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Jul 2011 10:35:41 -0400
In-Reply-To: <CAMjNe_fkt1Mw489F_=dxGCqoxZes1ASZu5hGBJtiCgOMNYoeNg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: srimugunthan dhandapani <srimugunthan.dhandapani@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-633003330-1311086355=:5656
Content-Type: TEXT/PLAIN; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sun, 17 Jul 2011, srimugunthan dhandapani wrote:
> 2011/6/30 Josh Durgin <josh.durgin@dreamhost.com>
> >
> > On 06/27/2011 05:25 PM, huang jun wrote:
> > > thanks=A3=ACJosh
> > > By default=A3=ACwe set two replicas for each PG,so if we use ceph
> > > as back-end storage of a website, you know, some files will be freque=
ntly read,
> > > if then of thousands clients do this, some osd's workload will be ver=
y high.
> > > so in this circumstance, how to balance the whole  cluster's workload=
?
> >
> > If the files don't change often, they can be cached by the clients. If
> > there really is one object that is being updated and read frequently,
> > there's not much you can do currently. To reduce the load on the primar=
y
> > OSD, we could add a flag to the MDS to tell clients to read from
> > replicas based on the usage.
>=20
>=20
> If a particular file is updated heavily, if we can change the inode
> number of the heavily updated file, then the objects will be remapped
> to new locations and can result in balancing.
> Will that be a good solution to implement?

I'm not sure that would help.  If the inode changes (a big if), then the=20
existing data has to move too, and you probably don't win anything.

The challenge with many writers in general is keeping the writes atomic=20
and (logically) serialized.  That's simple enough if they all go through a=
=20
single node.  The second problem is that, even with some clever way to=20
distribute that work (some tree hierarchy aggregating writes in front of=20
the final object, say), the clients have to know when to do that (vs the=20
simple approach in the general case).

Do you really have thousands of clients writing to the same 4MB range of a=
=20
file?  (Remember the file striping parameters can be adjusted to change=20
that.)

sage
--557981400-633003330-1311086355=:5656--
