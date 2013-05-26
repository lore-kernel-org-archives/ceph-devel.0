From: Leen Besselink <leen@consolejunkie.net>
Subject: Re: Ceph backfilling explained ( maybe )
Date: Sun, 26 May 2013 07:22:56 +0200
Message-ID: <20130526052255.GA19970@apia.perrit.net>
References: <51A0A6B2.9060105@dachary.org>
 <20130525123315.GA13595@apia.perrit.net>
 <51A0CA44.5000609@dachary.org>
 <20130525144818.GC32615@apia.perrit.net>
 <51A0F6D9.8080905@dachary.org>
 <CA+4uBUY2TRTTQxPhsA9tdES0HdZph03a8XNLghSTUNRuXa1OKw@mail.gmail.com>
Reply-To: leen@consolejunkie.net
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mta2.perrit.net ([194.213.15.114]:55974 "EHLO mta2.perrit.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752434Ab3EZFW6 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 26 May 2013 01:22:58 -0400
Received: from apia.perrit.net (apia.colo.hnglo.perrit.net [194.0.170.50])
	by mail.perrit.nl (Postfix) with ESMTP id BBE86200341
	for <ceph-devel@vger.kernel.org>; Sun, 26 May 2013 07:22:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CA+4uBUY2TRTTQxPhsA9tdES0HdZph03a8XNLghSTUNRuXa1OKw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

On Sat, May 25, 2013 at 11:06:08AM -0700, Samuel Just wrote:
> Hi, thanks for taking the time to try to get all this documented!
>=20
> Placement groups are assigned to a set of OSDs by crush.
>=20

Darn, silly me.

I made a stupid mistake, I meant it is CRUSH-algoritm and RADOS is the =
protocol.

> (4.1, osdmap(e 1)) --CRUSH--> [3,1,2]
>=20
> where the primary is 3.  When 3 dies, the osdmap is updated to reflec=
t this
> and we get a new mapping for pg 4.1:
>=20
> (4,1, osdmap(e 2)) --CRUSH--> [1,2,4]
>=20
> Here, 1 and 2 already have up-to-date copies of 4.1.  osd 4, however,=
 needs
> to be brought up to date.  During peering, osd 1 will learn that osd =
4
> falls into
> 1 of 2 cases.
>=20
> Case 1 is that osd 4 already had an old copy of pg 4.1 AND its pg log=
 for pg
> 4.1 happens to overlap osd 1's pg log for pg 4.1.  In that case, by r=
unning
> through the log of operations, we can determine exactly which objects=
 need
> to be copied over.  We usually refer to this as just "recovery" (or l=
og based
> recovery).
>=20
> In case 2, either osd 4's pg log does not overlap that of osd 1.  In =
this case,
> we cannot determine from the log which objects need to be copied over=
=2E
> To bring osd 4 up to date, we therefore need to backfill.
>=20
> Backfill involves the primary and the backfill peer (there is only ev=
er one in
> the acting set at a time, see PG::choose_acting) scanning over their =
pg stores
> and copying the objects which are different or missing from the prima=
ry to the
> backfill peer.  Because this may take a long time, we track the a las=
t_backfill
> attribute for each local pg copy indicating how far the local copy ha=
s been
> backfilled.  In the case that the copy is complete, last_backfill is
> hobject_t::max().
>=20
> More exactly, a local pg copy is described by a few pieces of informa=
tion:
> 1) the local pg log
> 2) the local last_backfill
> 3) the local last_complete
> 4) the local missing set
> The local pg store reflects all updates up to version last_complete o=
n all
> hobject_ts hoid such that hoid < last_backfill AND hoid is not in the=
 missing
> set.  Comparing the pg logs is used to fill in the missing set for OS=
Ds which
> were only down for a brief period thus avoiding a costly backfill in =
many cases.
>=20
> This is a bit of a rough brain dump and may be somewhat misleading/wr=
ong.
> I'll get it cleaned up and put it into
> doc/dev/osd_internals/pg_recovery.rst next
> week.
>=20
> Also, rados objects currently have three pieces:
> 1) data - read, write, writefull, etc.
> 2) xattrs
> 3) omap
> The omap is much like the xattrs except that it can generally store a=
 much
> larger number of keys and support efficient scans.  It's used at the =
moment
> for a few things including rgw bucket indices.  The omap entries are =
copied
> over along with the rest of the object in recovery.  Behind the scene=
s, all
> omap entries for all objects stored on an OSD are stored prefixed in =
a single
> big leveldb instance.
>=20
> omap operations probably shouldn't be supported on objects in an
> ErasureCodedPG :)
> -Sam
>=20
> On Sat, May 25, 2013 at 10:37 AM, Loic Dachary <loic@dachary.org> wro=
te:
> >
> >
> > On 05/25/2013 04:48 PM, Leen Besselink wrote:
> >> On Sat, May 25, 2013 at 04:27:16PM +0200, Loic Dachary wrote:
> >>>
> >>>
> >>> On 05/25/2013 02:33 PM, Leen Besselink wrote:
> >>> Hi Leen,
> >>>
> >>>> - a Cehp object can store keys/values, not just data
> >>>
> >>> I did not know that. Could you explain or give me the URL ?
> >>>
> >>
> >> Well, I got that impression from some of the earlier talks and fro=
m this blog post:
> >>
> >> http://ceph.com/community/my-first-impressions-of-ceph-as-a-summer=
-intern/
> >>
> >> But I haven't read it in while.
> >>
> >> But at this time I only see something like:
> >>
> >> http://ceph.com/docs/master/rados/api/librados/?highlight=3Drados_=
getxattr#rados_getxattr
> >>
> >> Which looks like it is storing it in filesystem attributes.
> >>
> >> So maybe an object can be a piece of data or a key/value store.
> >
> > Thanks for explaining: I did not know about the works of Eleanor Ca=
wthon. I knew about the objects xattributes but I thought you meant tha=
t the data inside of the object could be structured as key/value pairs.=
 My bad :-)
> >
> > Cheers
> >
> > --
> > Lo=EFc Dachary, Artisan Logiciel Libre
> > All that is necessary for the triumph of evil is that good people d=
o nothing.
> >
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
