From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: RE: Adding a proprietary key value store to CEPH
Date: Tue, 24 Feb 2015 16:13:14 +0000
Message-ID: <755F6B91B3BE364F9BCA11EA3F9E0C6F282B9D24@SACMBXIP02.sdcorp.global.sandisk.com>
References: <C226B0AB34511445928D9882AA519F600A56972E@SACMBXIP03.sdcorp.global.sandisk.com>
 <54EC8ACD.7020402@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bl2on0075.outbound.protection.outlook.com ([65.55.169.75]:27232
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752612AbbBXQNV convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 Feb 2015 11:13:21 -0500
In-Reply-To: <54EC8ACD.7020402@dachary.org>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, Varada Kari <Varada.Kari@sandisk.com>, Ceph Development <ceph-devel@vger.kernel.org>

Hi Loic,
This is an effort to make ceph interface pluggable to any proprietary k=
/v db available. The integrator has to implement a shim layer (dynamica=
lly loadable) by implementing these interfaces. That shim layer can do =
specific job for the k/v db of theirs.
Now, regarding our k/v db, yes, it is written keeping in mind that back=
end will be flash not HDD. This is the major difference between leveldb=
/rocksdb etc. Our db reduces the flash WA dramatically and the performa=
nce also should be similar or better than rocksdb.=20
Also, I think there should more of this proprietary dbs that people wan=
t to integrate with Ceph as I don't think leveldb/rocksdb will not be a=
ble to serve all kind of workload.

Thanks & Regards
Somnath=20

-----Original Message-----
=46rom: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.=
kernel.org] On Behalf Of Loic Dachary
Sent: Tuesday, February 24, 2015 6:30 AM
To: Varada Kari; Ceph Development
Subject: Re: Adding a proprietary key value store to CEPH

Hi,

I'm curious about the reasons why the key/value store you mention is no=
t published as Free Software. Is it because it implements a proprietary=
 interface to a specific hardware ? Because it has additional functiona=
lities comparied to rocksdb etc. ? Because it performs better under som=
e workloads ?

Cheers

On 24/02/2015 14:20, Varada Kari wrote:
> Hi Sage,
>=20
> We are trying to integrate a new proprietary key value store to CEPH.=
 To integrate this KV-store, which is a closed source shared library, w=
e propose a new class to CEPH called PropDBStore which does a dlopen an=
d imports the required symbols. This framework will help in integrating=
 vendor specific extensions to CEPH.
>=20
> The gist of the implementation is as follows.
>=20
> 1. Implement a wrapper around the proprietary KVStore. Let us call it=
 as KVExtension. This is a shared library which implements all interfac=
es required by CEPH KeyValueStore.
> 2. A new class is derived from KeyValueDB called PropDBStore, which h=
onors the semantics of KeyvalueStore and KeyValueDB. This class acts as=
 mediator between CEPH and KVExtension.  This class transforms bufferli=
st etc... to const char pointers or strings for the extension to unders=
tand.
> 3. PropDBStore, loads (dlopen) the KVExtension during OSD initializat=
ion.  Path to the KVExtension can be mentioned in ceph.conf.
> 4. Interfaces that needs to be implemented in KVExtension, which are =
imported by the PropDBStore are added in a new header called PropDBWrap=
per.h.  This header contains the signatures for the necessary interface=
s like init(), close(), submit_transaction(), get() and get_iterator().=
 Similarly for Iterator functionality, PropDBIterator.h, which specifie=
s the signatures of seek_to_first (), seek_to_last(), lower_bound() and=
 upper_bound() etc...  PropDBStore includes these headers to import the=
 symbols, using dlsym().
> 5. Choosing the proprietary DB as Backend to the OSD is controlled/ma=
naged by config options of the ceph (/etc/ceph/ceph.conf) like rocksdb =
or leveldb.
> 6. Rest of the existing functionality is not disturbed by this change=
=2E Changing the osd backend option will change backend implementation.=
 But this change is not dynamic. The type of the backend should be chos=
en at osd creation time and osd will continue use that backend till tha=
t osd is reformatted again.
> 7. The new KVStore we are trying to integrate works on a raw partitio=
n, so we divided the osd drive into two partitions. One partition is gi=
ven to osd Meta data (super block, fsid etc...), and the other is given=
 to the new db to manage it. OSD partition is now not the entire disk, =
but 2-4GB which needed for the metadata.
>=20
> Please share your thoughts around this.
> Thanks,
> Varada
>=20
>=20
>=20
> ________________________________
>=20
> PLEASE NOTE: The information contained in this electronic mail messag=
e is intended only for the use of the designated recipient(s) named abo=
ve. If the reader of this message is not the intended recipient, you ar=
e hereby notified that you have received this message in error and that=
 any review, dissemination, distribution, or copying of this message is=
 strictly prohibited. If you have received this communication in error,=
 please notify the sender by telephone or e-mail (as shown above) immed=
iately and destroy any and all copies of this message in your possessio=
n (whether hard copies or electronically stored copies).
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
=20
> in the body of a message to majordomo@vger.kernel.org More majordomo=20
> info at  http://vger.kernel.org/majordomo-info.html
>=20

--
Lo=EFc Dachary, Artisan Logiciel Libre

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
