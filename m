From: Loic Dachary <loic@dachary.org>
Subject: Re: partprobe or partx or ... ?
Date: Mon, 21 Sep 2015 12:40:10 +0200
Message-ID: <55FFDE8A.7090802@dachary.org>
References: <55FD7DF8.7060601@dachary.org>	<55FDC0C4.6050103@dachary.org> <CAOi1vP_Nz=c+sOWA44q6kvtiLCtZBTJZNaSNCPx5Qoyat=V+MQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="eFqcpxhiip3Ncrk0jwb6AmJLEEd73kkaO"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:58595 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753569AbbIUKkO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Sep 2015 06:40:14 -0400
In-Reply-To: <CAOi1vP_Nz=c+sOWA44q6kvtiLCtZBTJZNaSNCPx5Qoyat=V+MQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eFqcpxhiip3Ncrk0jwb6AmJLEEd73kkaO
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Ilya,

On 21/09/2015 12:23, Ilya Dryomov wrote:
> On Sat, Sep 19, 2015 at 11:08 PM, Loic Dachary <loic@dachary.org> wrote=
:
>>
>>
>> On 19/09/2015 17:23, Loic Dachary wrote:
>>> Hi Ilya,
>>>
>>> At present ceph-disk uses partprobe to ensure the kernel is aware of =
the latest partition changes after a new one is created, or after zapping=
 the partition table. Although it works reliably (in the sense that the k=
ernel is indeed aware of the desired partition layout), it goes as far as=
 to remove all partition devices of the current kernel table, only to re-=
add them with the new partition table. The delay it implies is not an iss=
ue because ceph-disk is rarely called. It however generate many udev even=
ts (dozens remove/change/add for a two partition disk) and almost always =
creates border cases that are difficult to figure out and debug. While it=
 is a good way to ensure that ceph-disk is idempotent and immune to race =
conditions, maybe it is needlessly hard.
>>>
>>> Do you know of a light weight alternative to partprobe ? In the past =
we've used partx but I remember it failed to address some border cases in=
 non-intuitive ways. Do you know of another, simpler, approach to this ?
>>>
>>> Thanks in advance for your help :-)
>>>
>>
>> For the record using /sys/block/sdX/device/rescan sounds good but does=
 not exist for devices created via devicemapper (used for dmcrypt and mul=
tipath).
>=20
> Hi Loic,
>=20
> Yeah, partprobe loops through the entire partition table, trying do
> delete/add every slot.  As an aside, the in-kernel way to do this
> (blockdev --rereadpt) is similar in that it also drops all partitions
> and re-adds them later, but it's faster and probably generates less
> change events.  The downside is it won't work on busy device.
>=20
> I don't think there is any alternative, except for using partx --add
> with --nr, that is targeting specific slots in the partition table.  If=

> all you are doing is adding partitions and zapping entire partition
> tables, that may work well enough.
>=20
> That said, given that the resulting delay (which can be in the seconds
> range, especially if your disk happens to have a busy partition) isn't
> a problem, what difference does it make?  What are you listening to
> those events for?

This is part of the ceph-disk prepare / activate workflow:

 ceph-disk prepare creates partitions, mounts them, populate them and exi=
ts
 ceph udev rules ( 95-ceph-osd.rules ) react to udev events when the part=
ition type is known and run ceph-disk activate in the background

When a machine boots or a disk is hot swapped, udev rules do the same and=
 activate: we only have one code path for all cases. The problem is to en=
sure all race conditions are addressed. What used to work in hammer has t=
o be revisited because the code path was changed in infernalis. udev acti=
ons no longer call ceph-disk activate, because it can take a long time an=
d that's not what udev is good at. Instead, udev actions run ceph-disk ac=
tivate in the background, using systemd/upstart when available (it falls =
back to the legacy syncrhonous behavior when they are not available).

I think I managed to address all race conditons with the patch series at =
https://github.com/ceph/ceph/pull/5999.

We should be good with partprobe :-)

>=20
> /sys/block/sdX/device/rescan is sd only, and AFAIK it doesn't generally=

> trigger a re-read of a partition table.

Thanks a lot for your insights !

Cheers

>=20
> Thanks,
>=20
>                 Ilya
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--eFqcpxhiip3Ncrk0jwb6AmJLEEd73kkaO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlX/3ooACgkQ8dLMyEl6F21ZSgCfZXv81ZbsHuya8z50piNt8OPt
DaMAnA1mvL361V8UbAs5mbfssntOoCvo
=4U3/
-----END PGP SIGNATURE-----

--eFqcpxhiip3Ncrk0jwb6AmJLEEd73kkaO--
