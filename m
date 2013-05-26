From: Loic Dachary <loic@dachary.org>
Subject: Re: Ceph backfilling explained ( maybe )
Date: Sun, 26 May 2013 13:45:16 +0200
Message-ID: <51A1F5CC.2010309@dachary.org>
References: <51A0A6B2.9060105@dachary.org> <20130525123315.GA13595@apia.perrit.net> <51A0CA44.5000609@dachary.org> <20130525144818.GC32615@apia.perrit.net> <51A0F6D9.8080905@dachary.org> <CA+4uBUY2TRTTQxPhsA9tdES0HdZph03a8XNLghSTUNRuXa1OKw@mail.gmail.com> <51A10DD3.7000609@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB0963B44231ED2411B14D49D"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:36585 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752532Ab3EZLpW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 26 May 2013 07:45:22 -0400
Received: from [10.8.0.22] (unknown [10.8.0.22])
	by smtp.dmail.dachary.org (Postfix) with ESMTPS id EA66526395
	for <ceph-devel@vger.kernel.org>; Sun, 26 May 2013 13:45:16 +0200 (CEST)
In-Reply-To: <51A10DD3.7000609@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB0963B44231ED2411B14D49D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

Although I am yet to fully understand the logic of the placement group re=
covery ( I'm eager to read Sam's doc/dev/osd_internals/pg_recovery.rst :-=
), I wrote down my understanding of backfilling : http://dachary.org/?p=3D=
2009 .=20

Cheers

On 05/25/2013 09:15 PM, Loic Dachary wrote:
> Hi !
>=20
> On 05/25/2013 08:06 PM, Samuel Just wrote:
>> Hi, thanks for taking the time to try to get all this documented!
>>
>> Placement groups are assigned to a set of OSDs by crush.
>>
>> (4.1, osdmap(e 1)) --CRUSH--> [3,1,2]
>>
>> where the primary is 3.  When 3 dies, the osdmap is updated to reflect=
 this
>> and we get a new mapping for pg 4.1:
>>
>> (4,1, osdmap(e 2)) --CRUSH--> [1,2,4]
>>
>> Here, 1 and 2 already have up-to-date copies of 4.1.  osd 4, however, =
needs
>> to be brought up to date.  During peering, osd 1 will learn that osd 4=

>> falls into
>> 1 of 2 cases.
>>
>> Case 1 is that osd 4 already had an old copy of pg 4.1 AND its pg log =
for pg
>> 4.1 happens to overlap osd 1's pg log for pg 4.1.  In that case, by ru=
nning
>> through the log of operations, we can determine exactly which objects =
need
>> to be copied over.  We usually refer to this as just "recovery" (or lo=
g based
>> recovery).
>>
>> In case 2, either osd 4's pg log does not overlap that of osd 1.  In t=
his case,
>> we cannot determine from the log which objects need to be copied over.=

>> To bring osd 4 up to date, we therefore need to backfill.
>>
>> Backfill involves the primary and the backfill peer (there is only eve=
r one in
>> the acting set at a time, see PG::choose_acting) scanning over their p=
g stores
>> and copying the objects which are different or missing from the primar=
y to the
>> backfill peer.  Because this may take a long time, we track the a last=
_backfill
>> attribute for each local pg copy indicating how far the local copy has=
 been
>> backfilled.  In the case that the copy is complete, last_backfill is
>> hobject_t::max().
>=20
> Is it true that if two osd briefly disconnect while backfilling, they m=
ay be in the case 1 above (i.e. log based recovery ) and then backfilling=
 again when done, starting from last_backfill and up ?=20
>=20
>> More exactly, a local pg copy is described by a few pieces of informat=
ion:
>> 1) the local pg log
>=20
> pg_log_t https://github.com/ceph/ceph/blob/master/src/osd/osd_types.h#L=
1371
> pg_log_entry_t https://github.com/ceph/ceph/blob/master/src/osd/osd_typ=
es.h#L1277
>=20
>> 2) the local last_backfill
>=20
> pg_info_t::last_backfill https://github.com/ceph/ceph/blob/master/src/o=
sd/osd_types.h#L1102
>=20
>> 3) the local last_complete
>=20
> pg_info_t::last_complete https://github.com/ceph/ceph/blob/master/src/o=
sd/osd_types.h#L1089
>=20
>> 4) the local missing set
>=20
> pg_missing_t https://github.com/ceph/ceph/blob/master/src/osd/osd_types=
=2Eh#L1468
>=20
>> The local pg store reflects all updates up to version last_complete on=
 all
>=20
> I assume you mean 'local pg log' instead of 'local pg log'.=20
>=20
>> hobject_ts hoid such that hoid < last_backfill AND hoid is not in the =
missing
>> set.  Comparing the pg logs is used to fill in the missing set for OSD=
s which
>> were only down for a brief period thus avoiding a costly backfill in m=
any cases.
>=20
> The pg logs are trimmed ( https://github.com/ceph/ceph/blob/master/src/=
osd/PG.cc#L216 ), this is why the pg logs of two OSDs that have been disc=
onnected for too long are unlikely to overlap ? And therefore require a b=
ackfill because the two pg logs cannot be compared ?
>=20
>> This is a bit of a rough brain dump and may be somewhat misleading/wro=
ng.
>=20
> It is very helpful as it is, thanks :-)
>=20
>> I'll get it cleaned up and put it into
>> doc/dev/osd_internals/pg_recovery.rst next
>> week.
>>
>=20
> That would be great.=20
>=20
>> Also, rados objects currently have three pieces:
>> 1) data - read, write, writefull, etc.
>> 2) xattrs
>> 3) omap
>> The omap is much like the xattrs except that it can generally store a =
much
>> larger number of keys and support efficient scans.  It's used at the m=
oment
>> for a few things including rgw bucket indices.  The omap entries are c=
opied
>> over along with the rest of the object in recovery.  Behind the scenes=
, all
>> omap entries for all objects stored on an OSD are stored prefixed in a=
 single
>> big leveldb instance.
>>
>> omap operations probably shouldn't be supported on objects in an
>> ErasureCodedPG :)
>=20
> I thought omap / xattrs were mutually exclusive. I did not realize both=
 could be used at the same time.
>=20
> Cheers
>=20
>> -Sam
>>
>> On Sat, May 25, 2013 at 10:37 AM, Loic Dachary <loic@dachary.org> wrot=
e:
>>>
>>>
>>> On 05/25/2013 04:48 PM, Leen Besselink wrote:
>>>> On Sat, May 25, 2013 at 04:27:16PM +0200, Loic Dachary wrote:
>>>>>
>>>>>
>>>>> On 05/25/2013 02:33 PM, Leen Besselink wrote:
>>>>> Hi Leen,
>>>>>
>>>>>> - a Cehp object can store keys/values, not just data
>>>>>
>>>>> I did not know that. Could you explain or give me the URL ?
>>>>>
>>>>
>>>> Well, I got that impression from some of the earlier talks and from =
this blog post:
>>>>
>>>> http://ceph.com/community/my-first-impressions-of-ceph-as-a-summer-i=
ntern/
>>>>
>>>> But I haven't read it in while.
>>>>
>>>> But at this time I only see something like:
>>>>
>>>> http://ceph.com/docs/master/rados/api/librados/?highlight=3Drados_ge=
txattr#rados_getxattr
>>>>
>>>> Which looks like it is storing it in filesystem attributes.
>>>>
>>>> So maybe an object can be a piece of data or a key/value store.
>>>
>>> Thanks for explaining: I did not know about the works of Eleanor Cawt=
hon. I knew about the objects xattributes but I thought you meant that th=
e data inside of the object could be structured as key/value pairs. My ba=
d :-)
>>>
>>> Cheers
>>>
>>> --
>>> Lo=EFc Dachary, Artisan Logiciel Libre
>>> All that is necessary for the triumph of evil is that good people do =
nothing.
>>>
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enigB0963B44231ED2411B14D49D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlGh9cwACgkQ8dLMyEl6F203NgCdFV32Y7ansDiqqMS2raEE0WUu
dd0AoKllyNfAI1QYX893BFALpbjk7hR0
=1j4y
-----END PGP SIGNATURE-----

--------------enigB0963B44231ED2411B14D49D--
