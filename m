From: Loic Dachary <loic@dachary.org>
Subject: Re: Removing disks / OSDs
Date: Mon, 21 Oct 2013 18:57:10 +0200
Message-ID: <52655CE6.9000203@dachary.org>
References: <52655309.8070500@dachary.org> <CAPYLRzjBmdewVvNVQd5JwnAAF2dv+q7Qk4qtzwQO7jVtpDGDRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="rrwShXcNifKWPPUaQ5g4sPmk6IQTjRu2h"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:41825 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751025Ab3JUQ5N (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Oct 2013 12:57:13 -0400
In-Reply-To: <CAPYLRzjBmdewVvNVQd5JwnAAF2dv+q7Qk4qtzwQO7jVtpDGDRg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rrwShXcNifKWPPUaQ5g4sPmk6IQTjRu2h
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 21/10/2013 18:49, Gregory Farnum wrote:
> I'm not quite sure what questions you're actually asking here...

I guess I was asking if my understanding was correct.

> In general, the OSD is not removed from the system without explicit
> admin intervention. When it is removed, all traces of it should be
> zapped (including its key), so it can't reconnect.

Ok. So reusing osd ids is not an issue. If you reconnect a disk after osd=
 rm the id it had, you get what you deserve and you can zap the disk so t=
hat it is formated again. Is it what you mean ?

> If it hasn't been removed, then indeed it will continue working
> properly even if moved to a different box.

Cool.

That makes it real simple from the point of view of tools like puppet :-)=


Cheers

> -Greg
> Software Engineer #42 @ http://inktank.com | http://ceph.com
>=20
>=20
> On Mon, Oct 21, 2013 at 9:15 AM, Loic Dachary <loic@dachary.org> wrote:=

>> Hi Ceph,
>>
>> In the context of the ceph puppet module ( https://wiki.openstack.org/=
wiki/Puppet-openstack/ceph-blueprint ) I tried to think about what should=
 be provided to deal with disks / OSDs when they are removed or moved aro=
und.
>>
>> Here is a possible scenario:
>>
>> * Machine A dies and contains OSD 42
>> * ceph osd rm 42 is done to get rid of the OSD
>> * ceph-prepare is called on a new disk and gets OSD id 42
>>
>> ceph/src/mon/OSDMonitor.cc
>>
>>     // allocate a new id
>>     for (i=3D0; i < osdmap.get_max_osd(); i++) {
>>       if (!osdmap.exists(i) &&
>>           pending_inc.new_up_client.count(i) =3D=3D 0 &&
>>           (pending_inc.new_state.count(i) =3D=3D 0 ||
>>            (pending_inc.new_state[i] & CEPH_OSD_EXISTS) =3D=3D 0))
>>         goto done;
>>     }
>>
>> * The disk of machine A is still good and is plugged into machine C
>> * the udev logic sees it has the ceph magic uuid and contains a well f=
ormed osd file system and runs the osd daemon on it. The osd daemon fails=
 and dies because its key does not match. It will try again and fail in t=
he same way when the machine reboots.
>>
>> If the osd id was not reused, the disk would find its way back in the =
cluster and be reused without manual intervention. Since ceph-disk uses t=
he osd uuid to create the disk, it does not matter that it has been remov=
ed : https://github.com/ceph/ceph/blob/master/src/ceph-disk#L458 . I'm no=
t sure to understand how the key that was previously registered is re-imp=
orted. If I understand correctly it is created with ceph-osd --mkkey http=
s://github.com/ceph/ceph/blob/master/src/ceph-disk#L1301 and stored in th=
e osd tree at the location specified by --keyring https://github.com/ceph=
/ceph/blob/master/src/ceph-disk#L1307 .
>>
>> At this point my understanding is that (as long as OSD ids are not reu=
sed), removing a disk or moving it from machine to machine, even over a l=
ong period of time does not require any action. The OSD id is an int whic=
h is probably large enough for any kind of cluster in the near future. Th=
e OSD ids that are not used and not removed could be cleaned from time to=
 time to garbage collect the space they use.
>>
>> Please let me know if I've missed something :-)
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


--rrwShXcNifKWPPUaQ5g4sPmk6IQTjRu2h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJlXOYACgkQ8dLMyEl6F20UqwCeO3UNQQo8VqYRQHZjb0PcKPsy
awkAnRbzHe1vJV74nWq8DfsLAWlFXict
=0NOE
-----END PGP SIGNATURE-----

--rrwShXcNifKWPPUaQ5g4sPmk6IQTjRu2h--
