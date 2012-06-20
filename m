From: Gregory Farnum <greg@inktank.com>
Subject: Re: Building a small Ceph development environment
Date: Tue, 19 Jun 2012 19:02:20 -0700
Message-ID: <80FADFE748DF46C388C088B1B3EBAE77@inktank.com>
References: <CAJLzzs+9X3dWUMLavOnp1ijvOJLDprM3YsGDLo=DUEEkb9yp4w@mail.gmail.com>
 <CAPYLRzh0XbsvGFOJCzpGjvtn_e_CVXcXcT5u_nbGut9VMfmSgg@mail.gmail.com>
 <CAJLzzsLt93+-kaPZCy1TGFCTEvE9S4w7Qsee6qaiyWwx7188Ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:61558 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753256Ab2FTCB4 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Jun 2012 22:01:56 -0400
Received: by pbbrp8 with SMTP id rp8so10427466pbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 19 Jun 2012 19:01:56 -0700 (PDT)
In-Reply-To: <CAJLzzsLt93+-kaPZCy1TGFCTEvE9S4w7Qsee6qaiyWwx7188Ng@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Terrance Hutchinson <terrance.hutchinson@gmail.com>
Cc: "=?utf-8?Q?ceph-devel=40vger.kernel.org?=" <ceph-devel@vger.kernel.org>

Everything works out, but because RHEL6 lacks syncfs support your perfo=
rmance will be less predictable. If you have more than one OSD on a box=
 without syncfs() support you'll certainly want to run btrfs if you can=
=2E =20
(Ceph daemons are very concerned with their data integrity =E2=80=94 fo=
r the obvious reasons =E2=80=94 and so they spend a lot of time making =
sure stuff goes on disk in the right order. Newer kernels and userspace=
 environments provide more tools for doing this without doing a full sy=
nc() system call.)


On Tuesday, June 19, 2012 at 3:54 PM, Terrance Hutchinson wrote:

> Hi Greg,
> =20
> How's ceph under RHEL 6/Oracle Linux 6? I'm more of an RPM guy.
> =20
> -Terrance
> =20
> On Tuesday, June 19, 2012, Gregory Farnum wrote:
> > You don't need to virtualize anything =E2=80=94 I'd recommend runni=
ng Ubuntu
> > 12.04 on it (you don't need to, but a lot of things will be more
> > performant), building from source, and then setting up the daemons =
so
> > everybody gets a separate disk.
> > Check out http://ceph.com/docs/master/source/ and the other docs an=
d
> > let us know if you have any questions. :)
> > =20
> > On Tue, Jun 19, 2012 at 10:47 AM, Terrance Hutchinson
> > <terrance.hutchinson@gmail.com (javascript:;)> wrote:
> > > Hi all,
> > > =20
> > > I have an HP ProLiant ML350 G5 server that is currently sitting i=
dle
> > > at the moment. Would it be possible to virtualize a Ceph cluster =
so I
> > > can mess around and begin contributing back to the community?
> > > =20
> > > Specs:
> > > =20
> > > ML350 G5
> > > 2 x Quad Core Xeon E5430
> > > 16GB RAM
> > > 7x 146GB SAS disks
> > > 1x 120 GB Intel 520 SSD
> > > HP P800 Smart Array Controller (can purchase an LSI 208E SAS HBA =
which
> > > will make the disks a JBOD)
> > > =20
> > > My goal is to create a small Ceph setup to do testing and bug fix=
es
> > > for the project which is why I posted this to the development lis=
t.
> > > =20
> > > Thanks in advance,
> > > Terrance
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe ceph-de=
vel" in
> > > the body of a message to majordomo@vger.kernel.org (javascript:;)
> > > More majordomo info at http://vger.kernel.org/majordomo-info.html
> > =20
> =20



--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
