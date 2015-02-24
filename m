From: Loic Dachary <loic@dachary.org>
Subject: Re: Adding a proprietary key value store to CEPH
Date: Tue, 24 Feb 2015 21:01:32 +0100
Message-ID: <54ECD89C.2050901@dachary.org>
References: <C226B0AB34511445928D9882AA519F600A56972E@SACMBXIP03.sdcorp.global.sandisk.com> <54EC8ACD.7020402@dachary.org> <755F6B91B3BE364F9BCA11EA3F9E0C6F282B9D24@SACMBXIP02.sdcorp.global.sandisk.com> <54ECA65C.1020109@dachary.org> <C226B0AB34511445928D9882AA519F600A569A56@SACMBXIP03.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="KQeqkXEIttCqq012e20pxiPx4OPx9ARQI"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:48335 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751444AbbBXUBe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 Feb 2015 15:01:34 -0500
In-Reply-To: <C226B0AB34511445928D9882AA519F600A569A56@SACMBXIP03.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Varada Kari <Varada.Kari@sandisk.com>, Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KQeqkXEIttCqq012e20pxiPx4OPx9ARQI
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 24/02/2015 17:50, Varada Kari wrote:
> Hi Loic,
>=20
> Yes,  db is designed to optimize the workloads on flash backends and us=
es only standard interfaces and system calls to achieve that.=20

I find the Cinder (https://wiki.openstack.org/wiki/Cinder) approach to pr=
oprietary drivers support a good source of inspiration. They had to find =
the right balance between the needs of the vendors and having a reference=
 implementation that is both Free Software and matching the needs of all =
users. For instance https://wiki.openstack.org/wiki/Cinder/how-to-contrib=
ute-a-driver states:

* You must implement all of the methods that exist as core features http:=
//docs.openstack.org/developer/cinder/devref/drivers.html
* Third party tests are required https://wiki.openstack.org/wiki/Cinder/t=
ested-3rdParty-drivers

I suspect people more involved in OpenStack than I am can share interesti=
ng stories ;-)

My 2cts.

> Varada
>=20
> -----Original Message-----
> From: Loic Dachary [mailto:loic@dachary.org]=20
> Sent: Tuesday, February 24, 2015 9:57 PM
> To: Somnath Roy; Varada Kari; Ceph Development
> Subject: Re: Adding a proprietary key value store to CEPH
>=20
> Hi,
>=20
> On 24/02/2015 17:13, Somnath Roy wrote:> Hi Loic,
>> This is an effort to make ceph interface pluggable to any proprietary =
k/v db available. The integrator has to implement a shim layer (dynamical=
ly loadable) by implementing these interfaces. That shim layer can do spe=
cific job for the k/v db of theirs.
>> Now, regarding our k/v db, yes, it is written keeping in mind that bac=
kend will be flash not HDD. This is the major difference between leveldb/=
rocksdb etc. Our db reduces the flash WA dramatically and the performance=
 also should be similar or better than rocksdb.=20
>> Also, I think there should more of this proprietary dbs that people wa=
nt to integrate with Ceph as I don't think leveldb/rocksdb will not be ab=
le to serve all kind of workload.
>=20
> Thanks for sharing these details :-) Would this db be specific to a lin=
e of product, for instance by making ioctl calls that only a specific dri=
ver for a specific hardware would understand ? Or is this a db that is de=
signed to optimize workloads for flash drives using only standard and doc=
umented API or system calls ?
>=20
>> Thanks & Regards
>> Somnath
>>
>> -----Original Message-----
>> From: ceph-devel-owner@vger.kernel.org=20
>> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Loic Dachary
>> Sent: Tuesday, February 24, 2015 6:30 AM
>> To: Varada Kari; Ceph Development
>> Subject: Re: Adding a proprietary key value store to CEPH
>>
>> Hi,
>>
>> I'm curious about the reasons why the key/value store you mention is n=
ot published as Free Software. Is it because it implements a proprietary =
interface to a specific hardware ? Because it has additional functionalit=
ies comparied to rocksdb etc. ? Because it performs better under some wor=
kloads ?
>>
>> Cheers
>>
>> On 24/02/2015 14:20, Varada Kari wrote:
>>> Hi Sage,
>>>
>>> We are trying to integrate a new proprietary key value store to CEPH.=
 To integrate this KV-store, which is a closed source shared library, we =
propose a new class to CEPH called PropDBStore which does a dlopen and im=
ports the required symbols. This framework will help in integrating vendo=
r specific extensions to CEPH.
>>>
>>> The gist of the implementation is as follows.
>>>
>>> 1. Implement a wrapper around the proprietary KVStore. Let us call it=
 as KVExtension. This is a shared library which implements all interfaces=
 required by CEPH KeyValueStore.
>>> 2. A new class is derived from KeyValueDB called PropDBStore, which h=
onors the semantics of KeyvalueStore and KeyValueDB. This class acts as m=
ediator between CEPH and KVExtension.  This class transforms bufferlist e=
tc... to const char pointers or strings for the extension to understand.
>>> 3. PropDBStore, loads (dlopen) the KVExtension during OSD initializat=
ion.  Path to the KVExtension can be mentioned in ceph.conf.
>>> 4. Interfaces that needs to be implemented in KVExtension, which are =
imported by the PropDBStore are added in a new header called PropDBWrappe=
r.h.  This header contains the signatures for the necessary interfaces li=
ke init(), close(), submit_transaction(), get() and get_iterator(). Simil=
arly for Iterator functionality, PropDBIterator.h, which specifies the si=
gnatures of seek_to_first (), seek_to_last(), lower_bound() and upper_bou=
nd() etc...  PropDBStore includes these headers to import the symbols, us=
ing dlsym().
>>> 5. Choosing the proprietary DB as Backend to the OSD is controlled/ma=
naged by config options of the ceph (/etc/ceph/ceph.conf) like rocksdb or=
 leveldb.
>>> 6. Rest of the existing functionality is not disturbed by this change=
=2E Changing the osd backend option will change backend implementation. B=
ut this change is not dynamic. The type of the backend should be chosen a=
t osd creation time and osd will continue use that backend till that osd =
is reformatted again.
>>> 7. The new KVStore we are trying to integrate works on a raw partitio=
n, so we divided the osd drive into two partitions. One partition is give=
n to osd Meta data (super block, fsid etc...), and the other is given to =
the new db to manage it. OSD partition is now not the entire disk, but 2-=
4GB which needed for the metadata.
>>>
>>> Please share your thoughts around this.
>>> Thanks,
>>> Varada
>>>
>>>
>>>
>>> ________________________________
>>>
>>> PLEASE NOTE: The information contained in this electronic mail messag=
e is intended only for the use of the designated recipient(s) named above=
=2E If the reader of this message is not the intended recipient, you are =
hereby notified that you have received this message in error and that any=
 review, dissemination, distribution, or copying of this message is stric=
tly prohibited. If you have received this communication in error, please =
notify the sender by telephone or e-mail (as shown above) immediately and=
 destroy any and all copies of this message in your possession (whether h=
ard copies or electronically stored copies).
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
=20
>>> in the body of a message to majordomo@vger.kernel.org More majordomo =

>>> info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>> --
>> Lo=EFc Dachary, Artisan Logiciel Libre
>>
>=20
> --
> Lo=EFc Dachary, Artisan Logiciel Libre
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--KQeqkXEIttCqq012e20pxiPx4OPx9ARQI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlTs2JwACgkQ8dLMyEl6F22hEQCfds4r7ukY5+MxMbQNHqJeoCTx
bdYAoMa6zVRIQ4zinKmMUauKdN2BbMRR
=bUkj
-----END PGP SIGNATURE-----

--KQeqkXEIttCqq012e20pxiPx4OPx9ARQI--
