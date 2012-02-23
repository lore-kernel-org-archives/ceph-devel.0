From: Sage Weil <sage@newdream.net>
Subject: Re: ceph does not work
Date: Thu, 23 Feb 2012 11:09:03 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1202231108160.31303@cobra.newdream.net>
References: <1329988516.4f4603a4d1995@mail.inbox.lv>
 <CAORUGqC_bDOzyo4nmwT6gUo_yOsyEz3nUFdZs5+m0WdHFMraYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-456066795-1330024143=:31303"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37023 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753529Ab2BWTJG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 23 Feb 2012 14:09:06 -0500
In-Reply-To: <CAORUGqC_bDOzyo4nmwT6gUo_yOsyEz3nUFdZs5+m0WdHFMraYw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: =?UTF-8?B?0JTQtdC90LjRgdC60LAt0YDQtdC00LjRgdC60LA=?= <slim@inbox.lv>, ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-456066795-1330024143=:31303
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 23 Feb 2012, Tommi Virtanen wrote:
> On Thu, Feb 23, 2012 at 01:15, =FF=FF=FF=FF=FF=FF=FF=FF=FF=FF=FF=FF=FF=FF=
-=FF=FF=FF=FF=FF=FF=FF=FF=FF=FF=FF=FF=FF=FF <slim@inbox.lv> wrote:
> > ehllo here,
> >
> > i have tried to setup ceph .41 in simple configuration:
> > 3 nodes, each running mon, mds & osd with replication level 3 for data =
& metadata pools.
> > Each node mounts ceph locally via ceph-fuse
> > cluster seems running well until one of the nodes goes down for simple =
reboot.
> > Then all mount points become inaccessible, data transfer hangs and clus=
ter stop working
> >
> > What is the purpose of ceph software while such simple case does not go=
 through ?
>=20
> You have a replication factor of 3, and 3 OSDs. If one of them is
> down, the replication factor of 3 cannot be satisfied anymore. You
> need either more nodes, or a smaller replication factor.
>=20
> Ceph is not an eventually consistent system; building a POSIX
> filesystem on top of one is pretty much impossible. With Ceph, all
> replicas are always kept up to date.

Just to clarify: what should have happend is that after a few seconds (20=
=20
by default?) the stopped ceph-osd is marked down and life continues with 2=
=20
replicas.  'ceph -s' or 'ceph health' will report some PGs in the=20
'degraded' state.

sage
--557981400-456066795-1330024143=:31303--
