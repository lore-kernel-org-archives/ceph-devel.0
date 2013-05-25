From: Leen Besselink <leen@consolejunkie.net>
Subject: Re: Ceph backfilling explained ( maybe )
Date: Sat, 25 May 2013 16:48:18 +0200
Message-ID: <20130525144818.GC32615@apia.perrit.net>
References: <51A0A6B2.9060105@dachary.org>
 <20130525123315.GA13595@apia.perrit.net>
 <51A0CA44.5000609@dachary.org>
Reply-To: leen@consolejunkie.net
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mta2.perrit.net ([194.213.15.114]:47873 "EHLO mta2.perrit.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756485Ab3EYOsU (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 25 May 2013 10:48:20 -0400
Received: from apia.perrit.net (apia.colo.hnglo.perrit.net [194.0.170.50])
	by mail.perrit.nl (Postfix) with ESMTP id 9FF4D200474
	for <ceph-devel@vger.kernel.org>; Sat, 25 May 2013 16:48:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <51A0CA44.5000609@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

On Sat, May 25, 2013 at 04:27:16PM +0200, Loic Dachary wrote:
>=20
>=20
> On 05/25/2013 02:33 PM, Leen Besselink wrote:
> Hi Leen,
>=20
> > - a Cehp object can store keys/values, not just data
>=20
> I did not know that. Could you explain or give me the URL ?
>=20

Well, I got that impression from some of the earlier talks and from thi=
s blog post:

http://ceph.com/community/my-first-impressions-of-ceph-as-a-summer-inte=
rn/

But I haven't read it in while.

But at this time I only see something like:

http://ceph.com/docs/master/rados/api/librados/?highlight=3Drados_getxa=
ttr#rados_getxattr

Which looks like it is storing it in filesystem attributes.

So maybe an object can be a piece of data or a key/value store.

> > - when using RBD the RBD client will create a 'directory' object wh=
ich contains general information
> >   like the version/type of RBD-image and a list of names of the ima=
ge parts. Each part is the same
> >   size, I think it was 4MB ?
>=20
> That's also my understanding : 4MB is the default.
>=20
> > - when an OSD or client connects to an OSD they also communicate in=
formation about atleast the osdmap and monmap.
> > - when one OSD or monitor can't reach an other mon or OSD, they wil=
l use a gossip protocol to communicate that to connected clients, OSDs =
or mons.
> > - when a new OSD comes online the other OSD's talk to it to know wh=
at data they might need to exchange
> >   this is called peering.
> > - the RADOS-algorithm works similair to consistent hashing, so a cl=
ient can talk directly to the OSD where the data is or should be stored=
=2E
> > - backfilling is what a master OSD does when it is checking if the =
other OSD's that should have a copy actaully has a copy. It will send a=
 copy of missing objects.
>=20
> I guess that's the area where I'm still unsure how it goes. I should =
look into the state machine of PG.{h,cc} to figure out how backfill rel=
ated messages are exchanged.
>=20

Well, I assume the master of an object knows it is the master.

When it knows an OSD has left the cluster it knows it has to store a ne=
w copy.

When changes happen in the cluster, all placement groups/object locatio=
ns in the pool will have to be re-calculated.

I assumed this might mean an OSD which was master of an object before i=
sn't master anymore, the new master is now resposible for the object an=
d the number of copies.

> Thanks for taking the time to explain :-)
>=20

This was just from memory, that is why I left some things unanswered.

My idea was when I transfer my knowledge to you, you can use it to sear=
ch the source and documentation. :-)

> Cheers
>=20
> > How the RADOS-algoritm calculates based on the osdmap and pgmap wha=
t pg and master-osd an object belongs to I'm not a 100% sure.
> >=20
> > Does that help ?
> >=20
> >> Cheers
> >>
> >> Ceph stores objects in pools which are divided in placement groups=
=2E
> >>
> >>    +---------------------------- pool a ----+
> >>    |+----- placement group 1 -------------+ |
> >>    ||+-------+  +-------+                 | |
> >>    |||object |  |object |                 | |
> >>    ||+-------+  +-------+                 | |
> >>    |+-------------------------------------+ |
> >>    |+----- placement group 2 -------------+ |
> >>    ||+-------+  +-------+                 | |
> >>    |||object |  |object |   ...           | |
> >>    ||+-------+  +-------+                 | |
> >>    |+-------------------------------------+ |
> >>    |               ....                     |
> >>    |                                        |
> >>    +----------------------------------------+
> >>
> >>    +---------------------------- pool b ----+
> >>    |+----- placement group 1 -------------+ |
> >>    ||+-------+  +-------+                 | |
> >>    |||object |  |object |                 | |
> >>    ||+-------+  +-------+                 | |
> >>    |+-------------------------------------+ |
> >>    |+----- placement group 2 -------------+ |
> >>    ||+-------+  +-------+                 | |
> >>    |||object |  |object |   ...           | |
> >>    ||+-------+  +-------+                 | |
> >>    |+-------------------------------------+ |
> >>    |               ....                     |
> >>    |                                        |
> >>    +----------------------------------------+
> >>
> >>    ...
> >>
> >> The placement group is supported by OSDs to store the objects. The=
y are daemons running on machines where storage  For instance, a placem=
ent group supporting three replicates will have three OSDs at his dispo=
sal : one OSDs is the primary and the two other store copies of each ob=
ject.
> >>
> >>        +-------- placement group -------------+
> >>        |+----------------+ +----------------+ |
> >>        || object A       | | object B       | |
> >>        |+----------------+ +----------------+ |
> >>        +---+-------------+-----------+--------+
> >>            |             |           |
> >>            |             |           |
> >>          OSD 0         OSD 1       OSD 2
> >>         +------+      +------+    +------+
> >>         |+---+ |      |+---+ |    |+---+ |
> >>         || A | |      || A | |    || A | |
> >>         |+---+ |      |+---+ |    |+---+ |
> >>         |+---+ |      |+---+ |    |+---+ |
> >>         || B | |      || B | |    || B | |
> >>         |+---+ |      |+---+ |    |+---+ |
> >>         +------+      +------+    +------+
> >>
> >> The OSDs are not for the exclusive use of the placement group : mu=
ltiple placement groups can use the same OSDs to store their objects. H=
owever, the collocation of objects from various placement groups in the=
 same OSD is transparent and is not discussed here.
> >>
> >> The placement group does not run as a single daemon as suggested a=
bove. Instead it os distributed and resides within each OSD. Whenever a=
n OSD dies, the placement group for this OSD is gone and needs to be re=
constructed using another OSD.
> >>
> >>                OSD 0                                           OSD=
 1 ...
> >>         +----------------+---- placement group --------+  +------
> >>         |+--- object --+ |+--------------------------+ |  |
> >>         || name : B    | ||  pg_log_entry_t MODIFY   | |  |
> >>         || key : 2     | ||  pg_log_entry_t DELETE   | |  |
> >>         |+-------------+ |+--------------------------+ |  |
> >>         |+--- object --+ >------ last_backfill         |  | ....
> >>         || name : A    | |                             |  |
> >>         || key : 5     | |                             |  |
> >>         |+-------------+ |                             |  |
> >>         |                |                             |  |
> >>         |    ....        |                             |  |
> >>         +----------------+-----------------------------+  +-----
> >>
> >>
> >> When an object is deleted or modified in the placement group, it i=
s recorded in a log to be replayed if needed. In the simplest case, if =
an OSD gets disconnected, reconnects and needs to catch up with the oth=
er OSDs, copies of the log entries will be sent to it. However, the log=
s have a limited size and it may be more efficient, in some cases, to j=
ust copy the objects over instead of replaying the logs.
> >>
> >> Each object name is hashed into an integer that can be used to ord=
er them. For instance, the object B above has been hashed to key 2 and =
the object A above has been hashed to key 5. The last_backfill pointer =
of the placement group draws the limit separating the objects that have=
 already been copied from other OSDs and those in the process of being =
copied. The objects that are lower than last_backfill have been copied =
( that would be object B above ) and the objects that are greater than =
last_backfill are going to be copied.
> >>
> >> It may take time for an OSD to catch up and it is useful to allow =
replaying the logs while backfilling. log entries related to objects lo=
wer than last_backfill are applied. However, log entries related to obj=
ects greater than last_backfill are discarded because it is scheduled t=
o be copied at a later time anyway.
> >>
> >>
> >> --=20
> >> Lo=EFc Dachary, Artisan Logiciel Libre
> >> All that is necessary for the triumph of evil is that good people =
do nothing.
> >>
> >=20
> >=20
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
> --=20
> Lo=EFc Dachary, Artisan Logiciel Libre
> All that is necessary for the triumph of evil is that good people do =
nothing.
>=20


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
