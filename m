From: Loic Dachary <loic@dachary.org>
Subject: Re: Ceph backfilling explained ( maybe )
Date: Sat, 25 May 2013 21:15:31 +0200
Message-ID: <51A10DD3.7000609@dachary.org>
References: <51A0A6B2.9060105@dachary.org> <20130525123315.GA13595@apia.perrit.net> <51A0CA44.5000609@dachary.org> <20130525144818.GC32615@apia.perrit.net> <51A0F6D9.8080905@dachary.org> <CA+4uBUY2TRTTQxPhsA9tdES0HdZph03a8XNLghSTUNRuXa1OKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE238E9E3DBE04EFE6028047B"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:57050 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757725Ab3EYTPk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 25 May 2013 15:15:40 -0400
In-Reply-To: <CA+4uBUY2TRTTQxPhsA9tdES0HdZph03a8XNLghSTUNRuXa1OKw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE238E9E3DBE04EFE6028047B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi !

On 05/25/2013 08:06 PM, Samuel Just wrote:
> Hi, thanks for taking the time to try to get all this documented!
>=20
> Placement groups are assigned to a set of OSDs by crush.
>=20
> (4.1, osdmap(e 1)) --CRUSH--> [3,1,2]
>=20
> where the primary is 3.  When 3 dies, the osdmap is updated to reflect =
this
> and we get a new mapping for pg 4.1:
>=20
> (4,1, osdmap(e 2)) --CRUSH--> [1,2,4]
>=20
> Here, 1 and 2 already have up-to-date copies of 4.1.  osd 4, however, n=
eeds
> to be brought up to date.  During peering, osd 1 will learn that osd 4
> falls into
> 1 of 2 cases.
>=20
> Case 1 is that osd 4 already had an old copy of pg 4.1 AND its pg log f=
or pg
> 4.1 happens to overlap osd 1's pg log for pg 4.1.  In that case, by run=
ning
> through the log of operations, we can determine exactly which objects n=
eed
> to be copied over.  We usually refer to this as just "recovery" (or log=
 based
> recovery).
>=20
> In case 2, either osd 4's pg log does not overlap that of osd 1.  In th=
is case,
> we cannot determine from the log which objects need to be copied over.
> To bring osd 4 up to date, we therefore need to backfill.
>=20
> Backfill involves the primary and the backfill peer (there is only ever=
 one in
> the acting set at a time, see PG::choose_acting) scanning over their pg=
 stores
> and copying the objects which are different or missing from the primary=
 to the
> backfill peer.  Because this may take a long time, we track the a last_=
backfill
> attribute for each local pg copy indicating how far the local copy has =
been
> backfilled.  In the case that the copy is complete, last_backfill is
> hobject_t::max().

Is it true that if two osd briefly disconnect while backfilling, they may=
 be in the case 1 above (i.e. log based recovery ) and then backfilling a=
gain when done, starting from last_backfill and up ?=20

> More exactly, a local pg copy is described by a few pieces of informati=
on:
> 1) the local pg log

pg_log_t https://github.com/ceph/ceph/blob/master/src/osd/osd_types.h#L13=
71
pg_log_entry_t https://github.com/ceph/ceph/blob/master/src/osd/osd_types=
=2Eh#L1277

> 2) the local last_backfill

pg_info_t::last_backfill https://github.com/ceph/ceph/blob/master/src/osd=
/osd_types.h#L1102

> 3) the local last_complete

pg_info_t::last_complete https://github.com/ceph/ceph/blob/master/src/osd=
/osd_types.h#L1089

> 4) the local missing set

pg_missing_t https://github.com/ceph/ceph/blob/master/src/osd/osd_types.h=
#L1468

> The local pg store reflects all updates up to version last_complete on =
all

I assume you mean 'local pg log' instead of 'local pg log'.=20

> hobject_ts hoid such that hoid < last_backfill AND hoid is not in the m=
issing
> set.  Comparing the pg logs is used to fill in the missing set for OSDs=
 which
> were only down for a brief period thus avoiding a costly backfill in ma=
ny cases.

The pg logs are trimmed ( https://github.com/ceph/ceph/blob/master/src/os=
d/PG.cc#L216 ), this is why the pg logs of two OSDs that have been discon=
nected for too long are unlikely to overlap ? And therefore require a bac=
kfill because the two pg logs cannot be compared ?

> This is a bit of a rough brain dump and may be somewhat misleading/wron=
g.

It is very helpful as it is, thanks :-)

> I'll get it cleaned up and put it into
> doc/dev/osd_internals/pg_recovery.rst next
> week.
>=20

That would be great.=20

> Also, rados objects currently have three pieces:
> 1) data - read, write, writefull, etc.
> 2) xattrs
> 3) omap
> The omap is much like the xattrs except that it can generally store a m=
uch
> larger number of keys and support efficient scans.  It's used at the mo=
ment
> for a few things including rgw bucket indices.  The omap entries are co=
pied
> over along with the rest of the object in recovery.  Behind the scenes,=
 all
> omap entries for all objects stored on an OSD are stored prefixed in a =
single
> big leveldb instance.
>=20
> omap operations probably shouldn't be supported on objects in an
> ErasureCodedPG :)

I thought omap / xattrs were mutually exclusive. I did not realize both c=
ould be used at the same time.

Cheers

> -Sam
>=20
> On Sat, May 25, 2013 at 10:37 AM, Loic Dachary <loic@dachary.org> wrote=
:
>>
>>
>> On 05/25/2013 04:48 PM, Leen Besselink wrote:
>>> On Sat, May 25, 2013 at 04:27:16PM +0200, Loic Dachary wrote:
>>>>
>>>>
>>>> On 05/25/2013 02:33 PM, Leen Besselink wrote:
>>>> Hi Leen,
>>>>
>>>>> - a Cehp object can store keys/values, not just data
>>>>
>>>> I did not know that. Could you explain or give me the URL ?
>>>>
>>>
>>> Well, I got that impression from some of the earlier talks and from t=
his blog post:
>>>
>>> http://ceph.com/community/my-first-impressions-of-ceph-as-a-summer-in=
tern/
>>>
>>> But I haven't read it in while.
>>>
>>> But at this time I only see something like:
>>>
>>> http://ceph.com/docs/master/rados/api/librados/?highlight=3Drados_get=
xattr#rados_getxattr
>>>
>>> Which looks like it is storing it in filesystem attributes.
>>>
>>> So maybe an object can be a piece of data or a key/value store.
>>
>> Thanks for explaining: I did not know about the works of Eleanor Cawth=
on. I knew about the objects xattributes but I thought you meant that the=
 data inside of the object could be structured as key/value pairs. My bad=
 :-)
>>
>> Cheers
>>
>> --
>> Lo=EFc Dachary, Artisan Logiciel Libre
>> All that is necessary for the triumph of evil is that good people do n=
othing.
>>

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enigE238E9E3DBE04EFE6028047B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlGhDdMACgkQ8dLMyEl6F22xBACdGY9q+FK6J/f8MHC4DVWczr/e
+5MAnjOVr3y8Wr4cYaRjf15tyM4ud6HB
=a22e
-----END PGP SIGNATURE-----

--------------enigE238E9E3DBE04EFE6028047B--
