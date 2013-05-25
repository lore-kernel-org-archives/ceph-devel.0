From: Leen Besselink <leen@consolejunkie.net>
Subject: Re: Ceph backfilling explained ( maybe )
Date: Sat, 25 May 2013 14:33:15 +0200
Message-ID: <20130525123315.GA13595@apia.perrit.net>
References: <51A0A6B2.9060105@dachary.org>
Reply-To: leen@consolejunkie.net
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mta2.perrit.net ([194.213.15.114]:58805 "EHLO mta2.perrit.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755861Ab3EYMdS (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 25 May 2013 08:33:18 -0400
Received: from apia.perrit.net (apia.colo.hnglo.perrit.net [194.0.170.50])
	by mail.perrit.nl (Postfix) with ESMTP id 6D418200432
	for <ceph-devel@vger.kernel.org>; Sat, 25 May 2013 14:33:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <51A0A6B2.9060105@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

On Sat, May 25, 2013 at 01:55:30PM +0200, Loic Dachary wrote:
> Hi,
>=20

Hi Loic,

> Here is a draft of my current understanding of backfilling. Disclaime=
r : it is possible that I completely misunderstood ;-)
>=20

Maybe I'm wrong, but I think there are some flaws in your explanation.

Disclaimer: I'm not a Ceph developer, but a fellow Ceph tester/user.

I would think almost any explanation of how Ceph works would use words =
like hash or algorithm.

Because the RADOS algorithm determines where data ends up.

It is used to calculate how to balance the data over the different plac=
ement groups, osds and machines.

I believe/assumed it works like this:
- an OSD belongs to one pool
- an OSD can serve many placement groups
- a placement group belongs to one pool
- the monitors know which OSD's exist in each pool and which are up
- this is sometimes called the topology, usually the osdmap and pgmap
- the monitors need to have quorum to be authoritive for their data bef=
ore making changes.
- the list of monitors is called the monmap.
- when storing/retrieving a client will have to do a RADOS-calculation
- to do this calculation it will first need to talk to one of the monit=
or which has quorum
  to get the osdmap and pgmap. They serve as input for the RADOS-algori=
thm
- one OSD is the master for one piece of data and serves as the contact=
-point for clients
- that master OSD for a piece of data also runs the RADOS-calculation t=
o talk to the other OSDs
  when replicating data changes
- a piece of data is called an object. Ceph is an Object Storage system=
/Object Store.
- the Ceph Object Store is not the same as a Swift or RADOS-GW object s=
tore.
- a Cehp object can store keys/values, not just data
- when using RBD the RBD client will create a 'directory' object which =
contains general information
  like the version/type of RBD-image and a list of names of the image p=
arts. Each part is the same
  size, I think it was 4MB ?
- when an OSD or client connects to an OSD they also communicate inform=
ation about atleast the osdmap and monmap.
- when one OSD or monitor can't reach an other mon or OSD, they will us=
e a gossip protocol to communicate that to connected clients, OSDs or m=
ons.
- when a new OSD comes online the other OSD's talk to it to know what d=
ata they might need to exchange
  this is called peering.
- the RADOS-algorithm works similair to consistent hashing, so a client=
 can talk directly to the OSD where the data is or should be stored.
- backfilling is what a master OSD does when it is checking if the othe=
r OSD's that should have a copy actaully has a copy. It will send a cop=
y of missing objects.

How the RADOS-algoritm calculates based on the osdmap and pgmap what pg=
 and master-osd an object belongs to I'm not a 100% sure.

Does that help ?

> Cheers
>=20
> Ceph stores objects in pools which are divided in placement groups.
>=20
>    +---------------------------- pool a ----+
>    |+----- placement group 1 -------------+ |
>    ||+-------+  +-------+                 | |
>    |||object |  |object |                 | |
>    ||+-------+  +-------+                 | |
>    |+-------------------------------------+ |
>    |+----- placement group 2 -------------+ |
>    ||+-------+  +-------+                 | |
>    |||object |  |object |   ...           | |
>    ||+-------+  +-------+                 | |
>    |+-------------------------------------+ |
>    |               ....                     |
>    |                                        |
>    +----------------------------------------+
>=20
>    +---------------------------- pool b ----+
>    |+----- placement group 1 -------------+ |
>    ||+-------+  +-------+                 | |
>    |||object |  |object |                 | |
>    ||+-------+  +-------+                 | |
>    |+-------------------------------------+ |
>    |+----- placement group 2 -------------+ |
>    ||+-------+  +-------+                 | |
>    |||object |  |object |   ...           | |
>    ||+-------+  +-------+                 | |
>    |+-------------------------------------+ |
>    |               ....                     |
>    |                                        |
>    +----------------------------------------+
>=20
>    ...
>=20
> The placement group is supported by OSDs to store the objects. They a=
re daemons running on machines where storage  For instance, a placement=
 group supporting three replicates will have three OSDs at his disposal=
 : one OSDs is the primary and the two other store copies of each objec=
t.
>=20
>        +-------- placement group -------------+
>        |+----------------+ +----------------+ |
>        || object A       | | object B       | |
>        |+----------------+ +----------------+ |
>        +---+-------------+-----------+--------+
>            |             |           |
>            |             |           |
>          OSD 0         OSD 1       OSD 2
>         +------+      +------+    +------+
>         |+---+ |      |+---+ |    |+---+ |
>         || A | |      || A | |    || A | |
>         |+---+ |      |+---+ |    |+---+ |
>         |+---+ |      |+---+ |    |+---+ |
>         || B | |      || B | |    || B | |
>         |+---+ |      |+---+ |    |+---+ |
>         +------+      +------+    +------+
>=20
> The OSDs are not for the exclusive use of the placement group : multi=
ple placement groups can use the same OSDs to store their objects. Howe=
ver, the collocation of objects from various placement groups in the sa=
me OSD is transparent and is not discussed here.
>=20
> The placement group does not run as a single daemon as suggested abov=
e. Instead it os distributed and resides within each OSD. Whenever an O=
SD dies, the placement group for this OSD is gone and needs to be recon=
structed using another OSD.
>=20
>                OSD 0                                           OSD 1 =
=2E..
>         +----------------+---- placement group --------+  +------
>         |+--- object --+ |+--------------------------+ |  |
>         || name : B    | ||  pg_log_entry_t MODIFY   | |  |
>         || key : 2     | ||  pg_log_entry_t DELETE   | |  |
>         |+-------------+ |+--------------------------+ |  |
>         |+--- object --+ >------ last_backfill         |  | ....
>         || name : A    | |                             |  |
>         || key : 5     | |                             |  |
>         |+-------------+ |                             |  |
>         |                |                             |  |
>         |    ....        |                             |  |
>         +----------------+-----------------------------+  +-----
>=20
>=20
> When an object is deleted or modified in the placement group, it is r=
ecorded in a log to be replayed if needed. In the simplest case, if an =
OSD gets disconnected, reconnects and needs to catch up with the other =
OSDs, copies of the log entries will be sent to it. However, the logs h=
ave a limited size and it may be more efficient, in some cases, to just=
 copy the objects over instead of replaying the logs.
>=20
> Each object name is hashed into an integer that can be used to order =
them. For instance, the object B above has been hashed to key 2 and the=
 object A above has been hashed to key 5. The last_backfill pointer of =
the placement group draws the limit separating the objects that have al=
ready been copied from other OSDs and those in the process of being cop=
ied. The objects that are lower than last_backfill have been copied ( t=
hat would be object B above ) and the objects that are greater than las=
t_backfill are going to be copied.
>=20
> It may take time for an OSD to catch up and it is useful to allow rep=
laying the logs while backfilling. log entries related to objects lower=
 than last_backfill are applied. However, log entries related to object=
s greater than last_backfill are discarded because it is scheduled to b=
e copied at a later time anyway.
>=20
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
