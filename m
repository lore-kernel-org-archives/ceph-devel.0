From: Loic Dachary <loic@dachary.org>
Subject: Re: Adding a proprietary key value store to CEPH
Date: Tue, 24 Feb 2015 17:27:08 +0100
Message-ID: <54ECA65C.1020109@dachary.org>
References: <C226B0AB34511445928D9882AA519F600A56972E@SACMBXIP03.sdcorp.global.sandisk.com> <54EC8ACD.7020402@dachary.org> <755F6B91B3BE364F9BCA11EA3F9E0C6F282B9D24@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="9qfwcNoaDqKjDqGpAqcj1sbBjmkwgsL5N"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:48228 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752612AbbBXQ1K (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 Feb 2015 11:27:10 -0500
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F282B9D24@SACMBXIP02.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>, Varada Kari <Varada.Kari@sandisk.com>, Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9qfwcNoaDqKjDqGpAqcj1sbBjmkwgsL5N
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi,

On 24/02/2015 17:13, Somnath Roy wrote:> Hi Loic,
> This is an effort to make ceph interface pluggable to any proprietary k=
/v db available. The integrator has to implement a shim layer (dynamicall=
y loadable) by implementing these interfaces. That shim layer can do spec=
ific job for the k/v db of theirs.
> Now, regarding our k/v db, yes, it is written keeping in mind that back=
end will be flash not HDD. This is the major difference between leveldb/r=
ocksdb etc. Our db reduces the flash WA dramatically and the performance =
also should be similar or better than rocksdb.=20
> Also, I think there should more of this proprietary dbs that people wan=
t to integrate with Ceph as I don't think leveldb/rocksdb will not be abl=
e to serve all kind of workload.

Thanks for sharing these details :-) Would this db be specific to a line =
of product, for instance by making ioctl calls that only a specific drive=
r for a specific hardware would understand ? Or is this a db that is desi=
gned to optimize workloads for flash drives using only standard and docum=
ented API or system calls ?

> Thanks & Regards
> Somnath=20
>=20
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.ke=
rnel.org] On Behalf Of Loic Dachary
> Sent: Tuesday, February 24, 2015 6:30 AM
> To: Varada Kari; Ceph Development
> Subject: Re: Adding a proprietary key value store to CEPH
>=20
> Hi,
>=20
> I'm curious about the reasons why the key/value store you mention is no=
t published as Free Software. Is it because it implements a proprietary i=
nterface to a specific hardware ? Because it has additional functionaliti=
es comparied to rocksdb etc. ? Because it performs better under some work=
loads ?
>=20
> Cheers
>=20
> On 24/02/2015 14:20, Varada Kari wrote:
>> Hi Sage,
>>
>> We are trying to integrate a new proprietary key value store to CEPH. =
To integrate this KV-store, which is a closed source shared library, we p=
ropose a new class to CEPH called PropDBStore which does a dlopen and imp=
orts the required symbols. This framework will help in integrating vendor=
 specific extensions to CEPH.
>>
>> The gist of the implementation is as follows.
>>
>> 1. Implement a wrapper around the proprietary KVStore. Let us call it =
as KVExtension. This is a shared library which implements all interfaces =
required by CEPH KeyValueStore.
>> 2. A new class is derived from KeyValueDB called PropDBStore, which ho=
nors the semantics of KeyvalueStore and KeyValueDB. This class acts as me=
diator between CEPH and KVExtension.  This class transforms bufferlist et=
c... to const char pointers or strings for the extension to understand.
>> 3. PropDBStore, loads (dlopen) the KVExtension during OSD initializati=
on.  Path to the KVExtension can be mentioned in ceph.conf.
>> 4. Interfaces that needs to be implemented in KVExtension, which are i=
mported by the PropDBStore are added in a new header called PropDBWrapper=
=2Eh.  This header contains the signatures for the necessary interfaces l=
ike init(), close(), submit_transaction(), get() and get_iterator(). Simi=
larly for Iterator functionality, PropDBIterator.h, which specifies the s=
ignatures of seek_to_first (), seek_to_last(), lower_bound() and upper_bo=
und() etc...  PropDBStore includes these headers to import the symbols, u=
sing dlsym().
>> 5. Choosing the proprietary DB as Backend to the OSD is controlled/man=
aged by config options of the ceph (/etc/ceph/ceph.conf) like rocksdb or =
leveldb.
>> 6. Rest of the existing functionality is not disturbed by this change.=
 Changing the osd backend option will change backend implementation. But =
this change is not dynamic. The type of the backend should be chosen at o=
sd creation time and osd will continue use that backend till that osd is =
reformatted again.
>> 7. The new KVStore we are trying to integrate works on a raw partition=
, so we divided the osd drive into two partitions. One partition is given=
 to osd Meta data (super block, fsid etc...), and the other is given to t=
he new db to manage it. OSD partition is now not the entire disk, but 2-4=
GB which needed for the metadata.
>>
>> Please share your thoughts around this.
>> Thanks,
>> Varada
>>
>>
>>
>> ________________________________
>>
>> PLEASE NOTE: The information contained in this electronic mail message=
 is intended only for the use of the designated recipient(s) named above.=
 If the reader of this message is not the intended recipient, you are her=
eby notified that you have received this message in error and that any re=
view, dissemination, distribution, or copying of this message is strictly=
 prohibited. If you have received this communication in error, please not=
ify the sender by telephone or e-mail (as shown above) immediately and de=
stroy any and all copies of this message in your possession (whether hard=
 copies or electronically stored copies).
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =

>> in the body of a message to majordomo@vger.kernel.org More majordomo=20
>> info at  http://vger.kernel.org/majordomo-info.html
>>
>=20
> --
> Lo=EFc Dachary, Artisan Logiciel Libre
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--9qfwcNoaDqKjDqGpAqcj1sbBjmkwgsL5N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlTsplwACgkQ8dLMyEl6F22mUwCfVs8ebyQ/6Mh+fcO6mqTCWKi/
/2sAoKsndOLyM55NCoM01dmU8fgj/qPz
=SlAn
-----END PGP SIGNATURE-----

--9qfwcNoaDqKjDqGpAqcj1sbBjmkwgsL5N--
