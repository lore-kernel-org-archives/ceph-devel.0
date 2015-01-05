From: Loic Dachary <loic@dachary.org>
Subject: Re: ceph-deploy osd destroy feature
Date: Mon, 05 Jan 2015 18:32:10 +0100
Message-ID: <54AACA9A.4080205@dachary.org>
References: <CACkq2moPdXgDGCtr-jtd+rxEGT3H_SFnVGruvKqfXDuvU8eagg@mail.gmail.com> <54A91EDA.8080008@42on.com> <CACkq2mr9yxmiLd028hQmsC4TLqb3FBgww-6O_pML3ubyybFo5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="feQmBx90tRX3eI98oqPnkGirFnr2sltMb"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:33776 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753176AbbAERcN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Jan 2015 12:32:13 -0500
In-Reply-To: <CACkq2mr9yxmiLd028hQmsC4TLqb3FBgww-6O_pML3ubyybFo5g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Travis Rhoden <trhoden@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--feQmBx90tRX3eI98oqPnkGirFnr2sltMb
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Travis,

Just one comment inline, in addition to what Sage wrote.

On 05/01/2015 18:14, Travis Rhoden wrote:
> Hi Loic and Wido,
>=20
> Loic - I agree with you that it makes more sense to implement the core
> of the logic in ceph-disk where it can be re-used by other tools (like
> ceph-deploy) or by administrators directly.  There are a lot of
> conventions put in place by ceph-disk such that ceph-disk is the best
> place to undo them as part of clean-up.  I'll pursue this with other
> Ceph devs to see if I can get agreement on the best approach.
>=20
> At a high-level, ceph-disk has two commands that I think could have a
> corollary -- prepare, and activate.
>=20
> Prepare will format and mkfs a disk/dir as needed to make it usable by =
Ceph.
> Activate will put the resulting disk/dir into service by allocating an
> OSD ID, creating the cephx key, and marking the init system as needed,
> and finally starting the ceph-osd service.
>=20
> It seems like there could be two opposite commands that do the followin=
g:
>=20
> deactivate:
>  - set "ceph osd out"
>  - stop ceph-osd service if needed
>  - remove OSD from CRUSH map
>  - remove OSD cephx key
>  - deallocate OSD ID
>  - remove 'ready', 'active', and INIT-specific files (to Wido's point)
>  - umount device and remove mount point
>=20
> destroy:
>  - zap disk (removes partition table and disk content)
>=20
> A few questions I have from this, though.  Is this granular enough?
> If all the steps listed above are done in deactivate, is it useful?
> Or are there usecases we need to cover where some of those steps need
> to be done but not all?  Deactivating in this case would be
> permanently removing the disk from the cluster.  If you are just
> moving a disk from one host to another, Ceph already supports that
> with no additional steps other than stop service, move disk, start
> service.

It is useful for test purposes. For instance, the puppet-ceph integration=
 tests can use it to ensure the osd is removed properly with no knowledge=
 of the details.

> Is "destroy" even necessary?  It's really just zap at that point,
> which already exists.  It only seems necessary to me if we add extra
> functionality, like the ability to do a wipe of some kind first.  If
> it is just zap, you could call zap separate or with --zap as an option
> to deactivate.
>
>=20
> And all of this would need to be able to fail somewhat gracefully, as
> you would often be dealing with dead/failed disks that may not allow
> these commands to run successfully.  That's why I'm wondering if it
> would be best to break the steps currently in "deactivate" into two
> commands -- (1) deactivate: which would deal with commands specific to
> the disk (osd out, stop service, remove marker files, umount) and (2)
> remove: which would undefine the OSD within the cluster (remove from
> CRUSH, remove cephx key, deallocate OSD ID).
>=20
> I'm mostly talking out loud here.  Looking for more ideas, input.  :)
>=20
>  - Travis
>=20
>=20
> On Sun, Jan 4, 2015 at 6:07 AM, Wido den Hollander <wido@42on.com> wrot=
e:
>> On 01/02/2015 10:31 PM, Travis Rhoden wrote:
>>> Hi everyone,
>>>
>>> There has been a long-standing request [1] to implement an OSD
>>> "destroy" capability to ceph-deploy.  A community user has submitted =
a
>>> pull request implementing this feature [2].  While the code needs a
>>> bit of work (there are a few things to work out before it would be
>>> ready to merge), I want to verify that the approach is sound before
>>> diving into it.
>>>
>>> As it currently stands, the new feature would do allow for the follow=
ing:
>>>
>>> ceph-deploy osd destroy <host> --osd-id <id>
>>>
>>> From that command, ceph-deploy would reach out to the host, do "ceph
>>> osd out", stop the ceph-osd service for the OSD, then finish by doing=

>>> "ceph osd crush remove", "ceph auth del", and "ceph osd rm".  Finally=
,
>>> it would umount the OSD, typically in /var/lib/ceph/osd/...
>>>
>>
>> Prior to the unmount, shouldn't it also clean up the 'ready' file to
>> prevent the OSD from starting after a reboot?
>>
>> Although it's key has been removed from the cluster it shouldn't matte=
r
>> that much, but it seems a bit cleaner.
>>
>> It could even be more destructive, that if you pass --zap-disk to it, =
it
>> also runs wipefs or something to clean the whole disk.
>>
>>>
>>> Does this high-level approach seem sane?  Anything that is missing
>>> when trying to remove an OSD?
>>>
>>>
>>> There are a few specifics to the current PR that jump out to me as
>>> things to address.  The format of the command is a bit rough, as othe=
r
>>> "ceph-deploy osd" commands take a list of [host[:disk[:journal]]] arg=
s
>>> to specify a bunch of disks/osds to act on at one.  But this command
>>> only allows one at a time, by virtue of the --osd-id argument.  We
>>> could try to accept [host:disk] and look up the OSD ID from that, or
>>> potentially take [host:ID] as input.
>>>
>>> Additionally, what should be done with the OSD's journal during the
>>> destroy process?  Should it be left untouched?
>>>
>>> Should there be any additional barriers to performing such a
>>> destructive command?  User confirmation?
>>>
>>>
>>>  - Travis
>>>
>>> [1] http://tracker.ceph.com/issues/3480
>>> [2] https://github.com/ceph/ceph-deploy/pull/254
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>>
>> --
>> Wido den Hollander
>> 42on B.V.
>> Ceph trainer and consultant
>>
>> Phone: +31 (0)20 700 9902
>> Skype: contact42on
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--feQmBx90tRX3eI98oqPnkGirFnr2sltMb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlSqypoACgkQ8dLMyEl6F23UVQCfSM0Wd/05vT94FQ+5BCvAWeal
HL8AnA5qD43mE5kTh9Z3Z4fl/LcIav/d
=SPBu
-----END PGP SIGNATURE-----

--feQmBx90tRX3eI98oqPnkGirFnr2sltMb--
