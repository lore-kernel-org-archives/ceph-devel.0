From: Loic Dachary <loic@dachary.org>
Subject: Re: Ceph backfilling explained ( maybe )
Date: Sat, 25 May 2013 16:27:16 +0200
Message-ID: <51A0CA44.5000609@dachary.org>
References: <51A0A6B2.9060105@dachary.org> <20130525123315.GA13595@apia.perrit.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig17A744B95DA31987AE7B7C60"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:36836 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756178Ab3EYO1X (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 25 May 2013 10:27:23 -0400
In-Reply-To: <20130525123315.GA13595@apia.perrit.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: leen@consolejunkie.net
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig17A744B95DA31987AE7B7C60
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 05/25/2013 02:33 PM, Leen Besselink wrote:
Hi Leen,

> - a Cehp object can store keys/values, not just data

I did not know that. Could you explain or give me the URL ?

> - when using RBD the RBD client will create a 'directory' object which =
contains general information
>   like the version/type of RBD-image and a list of names of the image p=
arts. Each part is the same
>   size, I think it was 4MB ?

That's also my understanding : 4MB is the default.

> - when an OSD or client connects to an OSD they also communicate inform=
ation about atleast the osdmap and monmap.
> - when one OSD or monitor can't reach an other mon or OSD, they will us=
e a gossip protocol to communicate that to connected clients, OSDs or mon=
s.
> - when a new OSD comes online the other OSD's talk to it to know what d=
ata they might need to exchange
>   this is called peering.
> - the RADOS-algorithm works similair to consistent hashing, so a client=
 can talk directly to the OSD where the data is or should be stored.
> - backfilling is what a master OSD does when it is checking if the othe=
r OSD's that should have a copy actaully has a copy. It will send a copy =
of missing objects.

I guess that's the area where I'm still unsure how it goes. I should look=
 into the state machine of PG.{h,cc} to figure out how backfill related m=
essages are exchanged.

Thanks for taking the time to explain :-)

Cheers

> How the RADOS-algoritm calculates based on the osdmap and pgmap what pg=
 and master-osd an object belongs to I'm not a 100% sure.
>=20
> Does that help ?
>=20
>> Cheers
>>
>> Ceph stores objects in pools which are divided in placement groups.
>>
>>    +---------------------------- pool a ----+
>>    |+----- placement group 1 -------------+ |
>>    ||+-------+  +-------+                 | |
>>    |||object |  |object |                 | |
>>    ||+-------+  +-------+                 | |
>>    |+-------------------------------------+ |
>>    |+----- placement group 2 -------------+ |
>>    ||+-------+  +-------+                 | |
>>    |||object |  |object |   ...           | |
>>    ||+-------+  +-------+                 | |
>>    |+-------------------------------------+ |
>>    |               ....                     |
>>    |                                        |
>>    +----------------------------------------+
>>
>>    +---------------------------- pool b ----+
>>    |+----- placement group 1 -------------+ |
>>    ||+-------+  +-------+                 | |
>>    |||object |  |object |                 | |
>>    ||+-------+  +-------+                 | |
>>    |+-------------------------------------+ |
>>    |+----- placement group 2 -------------+ |
>>    ||+-------+  +-------+                 | |
>>    |||object |  |object |   ...           | |
>>    ||+-------+  +-------+                 | |
>>    |+-------------------------------------+ |
>>    |               ....                     |
>>    |                                        |
>>    +----------------------------------------+
>>
>>    ...
>>
>> The placement group is supported by OSDs to store the objects. They ar=
e daemons running on machines where storage  For instance, a placement gr=
oup supporting three replicates will have three OSDs at his disposal : on=
e OSDs is the primary and the two other store copies of each object.
>>
>>        +-------- placement group -------------+
>>        |+----------------+ +----------------+ |
>>        || object A       | | object B       | |
>>        |+----------------+ +----------------+ |
>>        +---+-------------+-----------+--------+
>>            |             |           |
>>            |             |           |
>>          OSD 0         OSD 1       OSD 2
>>         +------+      +------+    +------+
>>         |+---+ |      |+---+ |    |+---+ |
>>         || A | |      || A | |    || A | |
>>         |+---+ |      |+---+ |    |+---+ |
>>         |+---+ |      |+---+ |    |+---+ |
>>         || B | |      || B | |    || B | |
>>         |+---+ |      |+---+ |    |+---+ |
>>         +------+      +------+    +------+
>>
>> The OSDs are not for the exclusive use of the placement group : multip=
le placement groups can use the same OSDs to store their objects. However=
, the collocation of objects from various placement groups in the same OS=
D is transparent and is not discussed here.
>>
>> The placement group does not run as a single daemon as suggested above=
=2E Instead it os distributed and resides within each OSD. Whenever an OS=
D dies, the placement group for this OSD is gone and needs to be reconstr=
ucted using another OSD.
>>
>>                OSD 0                                           OSD 1 .=
=2E.
>>         +----------------+---- placement group --------+  +------
>>         |+--- object --+ |+--------------------------+ |  |
>>         || name : B    | ||  pg_log_entry_t MODIFY   | |  |
>>         || key : 2     | ||  pg_log_entry_t DELETE   | |  |
>>         |+-------------+ |+--------------------------+ |  |
>>         |+--- object --+ >------ last_backfill         |  | ....
>>         || name : A    | |                             |  |
>>         || key : 5     | |                             |  |
>>         |+-------------+ |                             |  |
>>         |                |                             |  |
>>         |    ....        |                             |  |
>>         +----------------+-----------------------------+  +-----
>>
>>
>> When an object is deleted or modified in the placement group, it is re=
corded in a log to be replayed if needed. In the simplest case, if an OSD=
 gets disconnected, reconnects and needs to catch up with the other OSDs,=
 copies of the log entries will be sent to it. However, the logs have a l=
imited size and it may be more efficient, in some cases, to just copy the=
 objects over instead of replaying the logs.
>>
>> Each object name is hashed into an integer that can be used to order t=
hem. For instance, the object B above has been hashed to key 2 and the ob=
ject A above has been hashed to key 5. The last_backfill pointer of the p=
lacement group draws the limit separating the objects that have already b=
een copied from other OSDs and those in the process of being copied. The =
objects that are lower than last_backfill have been copied ( that would b=
e object B above ) and the objects that are greater than last_backfill ar=
e going to be copied.
>>
>> It may take time for an OSD to catch up and it is useful to allow repl=
aying the logs while backfilling. log entries related to objects lower th=
an last_backfill are applied. However, log entries related to objects gre=
ater than last_backfill are discarded because it is scheduled to be copie=
d at a later time anyway.
>>
>>
>> --=20
>> Lo=EFc Dachary, Artisan Logiciel Libre
>> All that is necessary for the triumph of evil is that good people do n=
othing.
>>
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enig17A744B95DA31987AE7B7C60
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlGgykQACgkQ8dLMyEl6F23qWACeOQoIhE7m/fgs4xtlW6owS9lh
XgMAn18Az6IuG86D8X1uT8Cibh3FIgbd
=ebV1
-----END PGP SIGNATURE-----

--------------enig17A744B95DA31987AE7B7C60--
