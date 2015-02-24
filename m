From: Varada Kari <Varada.Kari@sandisk.com>
Subject: RE: Adding a proprietary key value store to CEPH
Date: Tue, 24 Feb 2015 16:50:51 +0000
Message-ID: <C226B0AB34511445928D9882AA519F600A569A56@SACMBXIP03.sdcorp.global.sandisk.com>
References: <C226B0AB34511445928D9882AA519F600A56972E@SACMBXIP03.sdcorp.global.sandisk.com>
 <54EC8ACD.7020402@dachary.org>
 <755F6B91B3BE364F9BCA11EA3F9E0C6F282B9D24@SACMBXIP02.sdcorp.global.sandisk.com>
 <54ECA65C.1020109@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bl2on0080.outbound.protection.outlook.com ([65.55.169.80]:46971
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752544AbbBXRGw convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 Feb 2015 12:06:52 -0500
In-Reply-To: <54ECA65C.1020109@dachary.org>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, Somnath Roy <Somnath.Roy@sandisk.com>, Ceph Development <ceph-devel@vger.kernel.org>

Hi Loic,

Yes,  db is designed to optimize the workloads on flash backends and us=
es only standard interfaces and system calls to achieve that.=20

Varada

-----Original Message-----
=46rom: Loic Dachary [mailto:loic@dachary.org]=20
Sent: Tuesday, February 24, 2015 9:57 PM
To: Somnath Roy; Varada Kari; Ceph Development
Subject: Re: Adding a proprietary key value store to CEPH

Hi,

On 24/02/2015 17:13, Somnath Roy wrote:> Hi Loic,
> This is an effort to make ceph interface pluggable to any proprietary=
 k/v db available. The integrator has to implement a shim layer (dynami=
cally loadable) by implementing these interfaces. That shim layer can d=
o specific job for the k/v db of theirs.
> Now, regarding our k/v db, yes, it is written keeping in mind that ba=
ckend will be flash not HDD. This is the major difference between level=
db/rocksdb etc. Our db reduces the flash WA dramatically and the perfor=
mance also should be similar or better than rocksdb.=20
> Also, I think there should more of this proprietary dbs that people w=
ant to integrate with Ceph as I don't think leveldb/rocksdb will not be=
 able to serve all kind of workload.

Thanks for sharing these details :-) Would this db be specific to a lin=
e of product, for instance by making ioctl calls that only a specific d=
river for a specific hardware would understand ? Or is this a db that i=
s designed to optimize workloads for flash drives using only standard a=
nd documented API or system calls ?

> Thanks & Regards
> Somnath
>=20
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org=20
> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Loic Dachary
> Sent: Tuesday, February 24, 2015 6:30 AM
> To: Varada Kari; Ceph Development
> Subject: Re: Adding a proprietary key value store to CEPH
>=20
> Hi,
>=20
> I'm curious about the reasons why the key/value store you mention is =
not published as Free Software. Is it because it implements a proprieta=
ry interface to a specific hardware ? Because it has additional functio=
nalities comparied to rocksdb etc. ? Because it performs better under s=
ome workloads ?
>=20
> Cheers
>=20
> On 24/02/2015 14:20, Varada Kari wrote:
>> Hi Sage,
>>
>> We are trying to integrate a new proprietary key value store to CEPH=
=2E To integrate this KV-store, which is a closed source shared library=
, we propose a new class to CEPH called PropDBStore which does a dlopen=
 and imports the required symbols. This framework will help in integrat=
ing vendor specific extensions to CEPH.
>>
>> The gist of the implementation is as follows.
>>
>> 1. Implement a wrapper around the proprietary KVStore. Let us call i=
t as KVExtension. This is a shared library which implements all interfa=
ces required by CEPH KeyValueStore.
>> 2. A new class is derived from KeyValueDB called PropDBStore, which =
honors the semantics of KeyvalueStore and KeyValueDB. This class acts a=
s mediator between CEPH and KVExtension.  This class transforms bufferl=
ist etc... to const char pointers or strings for the extension to under=
stand.
>> 3. PropDBStore, loads (dlopen) the KVExtension during OSD initializa=
tion.  Path to the KVExtension can be mentioned in ceph.conf.
>> 4. Interfaces that needs to be implemented in KVExtension, which are=
 imported by the PropDBStore are added in a new header called PropDBWra=
pper.h.  This header contains the signatures for the necessary interfac=
es like init(), close(), submit_transaction(), get() and get_iterator()=
=2E Similarly for Iterator functionality, PropDBIterator.h, which speci=
fies the signatures of seek_to_first (), seek_to_last(), lower_bound() =
and upper_bound() etc...  PropDBStore includes these headers to import =
the symbols, using dlsym().
>> 5. Choosing the proprietary DB as Backend to the OSD is controlled/m=
anaged by config options of the ceph (/etc/ceph/ceph.conf) like rocksdb=
 or leveldb.
>> 6. Rest of the existing functionality is not disturbed by this chang=
e. Changing the osd backend option will change backend implementation. =
But this change is not dynamic. The type of the backend should be chose=
n at osd creation time and osd will continue use that backend till that=
 osd is reformatted again.
>> 7. The new KVStore we are trying to integrate works on a raw partiti=
on, so we divided the osd drive into two partitions. One partition is g=
iven to osd Meta data (super block, fsid etc...), and the other is give=
n to the new db to manage it. OSD partition is now not the entire disk,=
 but 2-4GB which needed for the metadata.
>>
>> Please share your thoughts around this.
>> Thanks,
>> Varada
>>
>>
>>
>> ________________________________
>>
>> PLEASE NOTE: The information contained in this electronic mail messa=
ge is intended only for the use of the designated recipient(s) named ab=
ove. If the reader of this message is not the intended recipient, you a=
re hereby notified that you have received this message in error and tha=
t any review, dissemination, distribution, or copying of this message i=
s strictly prohibited. If you have received this communication in error=
, please notify the sender by telephone or e-mail (as shown above) imme=
diately and destroy any and all copies of this message in your possessi=
on (whether hard copies or electronically stored copies).
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
"=20
>> in the body of a message to majordomo@vger.kernel.org More majordomo=
=20
>> info at  http://vger.kernel.org/majordomo-info.html
>>
>=20
> --
> Lo=EFc Dachary, Artisan Logiciel Libre
>=20

--
Lo=EFc Dachary, Artisan Logiciel Libre

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
