From: Javen Wu <javen.wu@xtaotech.com>
Subject: Re: Is BlueFS an alternative of BlueStore?
Date: Thu, 7 Jan 2016 23:54:24 +0800
Message-ID: <BAB3EB02-C468-43F7-ABA5-E06D370DC66B@xtaotech.com>
References: <568DE333.7070206@xtaotech.com> <alpine.DEB.2.11.1601070813000.26051@cpach.fuggernut.com> <568E781B.4030803@xtaotech.com> <568E78D8.8080401@xtaotech.com> <alpine.DEB.2.11.1601071003140.26051@cpach.fuggernut.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mr213139.mail.yeah.net ([223.252.213.139]:33161 "EHLO
	mr213139.mail.yeah.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752062AbcAGPyb convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Jan 2016 10:54:31 -0500
In-Reply-To: <alpine.DEB.2.11.1601071003140.26051@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "peng.hse" <peng.hse@xtaotech.com>, ceph-devel@vger.kernel.org

Appreciate your explanation. I get you mean.
I will think about it and get you back after do more investigation.

Javen
>=20
> This is the key piece that will determine whether rocksdb (or somethi=
ng=20
> similar) is required.  POSIX doesn't give you sorted enumeration of=20
> files.  In order to provide that with FileStore, we used a horrible=20
> hashing scheme that dynamically broke directories into=20
> smaller subdirectories once they got big, and organized things by a h=
ash=20
> prefix (enumeration is in hash order).  That meant a mess of director=
ies=20
> with bounded size (so that there were a bounded number of entries to =
read=20
> and then sort in memory before returning a sorted result), which was=20
> inefficient, and it meant that as the number of objects grew you'd ha=
ve=20
> this periodic rehash work that had to be done that further slowed thi=
ngs=20
> down.  This, combined with the inability to group an arbitrary=20
> number of file operations (writes, unlinks, renames, setxattrs, etc.)=
 into=20
> an atomic transaction was FileStore's downfall.  I think the zfs libs=
 give=20
> you the transactions you need, but you *also* need to get sorted=20
> enumeration (with a sort order you define) or else you'll have all th=
e=20
> ugliness of the FileStore indexes.
>=20


>> 4. create a new metaslab class to store CEPH journal.
>> 5. align CEPH journal and ZFS transcation.
>>=20
>> Actually we've talked about the possibility of building RocksDB::Env=
 on top
>> of the zfs libraries. It must align ZIL(ZFS intent log) and RocksDB =
WAL.
>> Otherwise, there is still same problem as XFS and RocksDB.
>>=20
>> ZFS is tree style log structure-like file system, once a leaf block =
updates,
>> the modification would be propagated from the leaf to the root of tr=
ee.
>> To batch writes and reduce times of disk write, ZFS persist modifica=
tion to
>> disk
>> in 5 seconds transaction. Only when Fsync/sync write arrives in the =
middle of
>> the 5 seconds, ZFS would persist the journal to ZIL.
>> I remembered RocksDB would do a sync after log record adding, so it =
means if
>> we can not align ZIL and WAL, the log write would be write to ZIL fi=
rstly and
>> then apply ZIL to log file, finally Rockdb update sst file. It's alm=
ost the
>> same problem as XFS if my understanding is correct.
>=20
> If you implement rocksdb::Env, you'll see the rocksdb WAL writes and =
the=20
> fsync calls come down.  You can store those however you'd like... as=20
> "files" or perhaps directly in the ZIL.
>=20
> The way we do this in BlueFS is that for an initial warm-up period, w=
e=20
> append to a WAL log file, and have to do both the log write *and* a=20
> journal write to update the file size.  Once we've written out enough=
=20
> logs, though, we start recycling the same logs (and disk blocks) and =
just=20
> overwrite the previously allocated space.  The rocksdb log replay is =
now=20
> smart enough to determine when it's reached the end of the new conten=
t and=20
> is now seeing (old) garbage and stop.
>=20
> Whether it makes sense to do something similar in zfs-land I'm not su=
re. =20
> Presumably the ZIL itself is doing something similar (sequence nubmer=
s and=20
> crcs on log entries in a circular buffer) but the rocksdb log=20
> lifecycle probably doesn't match the ZIL...
>=20
> sage
>=20
>> In my mind, aligning ZIL and WAL need more modifications in RocksDB.
>>=20
>> Thanks
>> Javen
>>=20
>>=20
>> On 2016=E5=B9=B401=E6=9C=8807=E6=97=A5 22:37, peng.hse wrote:
>>> Hi Sage,
>>>=20
>>> thanks for your quick response. Javen and I  once the zfs developer=
,are
>>> currently focusing on how to
>>> leverage some of the zfs ideas to improve the ceph backend performa=
nce in
>>> userspace.
>>>=20
>>>=20
>>> Based on your encouraging reply, we come up with 2 schemes to conti=
nue our
>>> future work
>>>=20
>>> 1. the scheme one: using the entire new FS to replace rocksdb+bluef=
s, the FS
>>> itself handles the mapping of
>>>    oid->fs-object(kind of zfs dnode) and the according attrs used b=
y ceph.
>>>   Despite the implemention challenges you mentioned about the in-or=
der
>>> enumeration of objects during backfill, scrub, etc (the
>>>    same situation we also confronted in zfs, the ZAP features help =
us a
>>> lot).
>>>    From performance or architecture point of view, it looks more cl=
ear and
>>> clean, would you suggest us to give a try ?
>>>=20
>>> 2. the scheme two: As your last suspect, we just temporarily implem=
ented the
>>> simple version of the FS
>>>     which leverage libzpool ideas to plug into rocksdb underneath a=
s your
>>> bluefs did
>>>=20
>>> precious your insightful reply.
>>>=20
>>> Thanks
>>>=20
>>>=20
>>>=20
>>> On 2016=E5=B9=B401=E6=9C=8807=E6=97=A5 21:19, Sage Weil wrote:
>>>> On Thu, 7 Jan 2016, Javen Wu wrote:
>>>>> Hi Sage,
>>>>>=20
>>>>> Sorry to bother you. I am not sure if it is appropriate to send e=
mail to
>>>>> you
>>>>> directly, but I cannot find any useful information to address my
>>>>> confusion
>>>>> from Internet. Hope you can help me.
>>>>>=20
>>>>> Occasionally, I heard that you are going to start BlueFS to elimi=
nate
>>>>> the
>>>>> redudancy between XFS journal and RocksDB WAL. I am a little conf=
used.
>>>>> Is the Bluefs only to host RocksDB for BlueStore or it's an
>>>>> alternative of BlueStore?
>>>>>=20
>>>>> I am a new comer to CEPH, I am not sure my understanding is corre=
ct
>>>>> about
>>>>> BlueStore. BlueStore in my mind is as below.
>>>>>=20
>>>>>              BlueStore
>>>>>              =3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>>    RocksDB
>>>>> +-----------+          +-----------+
>>>>> |   onode   |          |           |
>>>>> |    WAL    |          |           |
>>>>> |   omap    |          |           |
>>>>> +-----------+          |   bdev    |
>>>>> |           |          |           |
>>>>> |   XFS     |          |           |
>>>>> |           |          |           |
>>>>> +-----------+          +-----------+
>>>> This is the picture before BlueFS enters the picture.
>>>>=20
>>>>> I am curious if BlueFS is able to host RocksDB, actually it's alr=
eady a
>>>>> "filesystem" which have to maintain blockmap kind of metadata by =
its own
>>>>> WITHOUT the help of RocksDB.
>>>> Right.  BlueFS is a really simple "file system" that is *just* com=
plicated
>>>> enough to implement the rocksdb::Env interface, which is what rock=
sdb
>>>> needs to store its log and sst files.  The after picture looks lik=
e
>>>>=20
>>>>  +--------------------+
>>>>  |     bluestore      |
>>>>  +----------+         |
>>>>  | rocksdb  |         |
>>>>  +----------+         |
>>>>  |  bluefs  |         |
>>>>  +----------+---------+
>>>>  |    block device    |
>>>>  +--------------------+
>>>>=20
>>>>> The reason we care the intention and the design target of BlueFS =
is that
>>>>> I had
>>>>> discussion with my partner Peng.Hse about an idea to introduce a =
new
>>>>> ObjectStore using ZFS library. I know CEPH supports ZFS as FileSt=
ore
>>>>> backend
>>>>> already, but we had a different immature idea to use libzpool to
>>>>> implement a
>>>>> new
>>>>> ObjectStore for CEPH totally in userspace without SPL and ZOL ker=
nel
>>>>> module.
>>>>> So that we can align CEPH transaction and zfs transaction in orde=
r to
>>>>> avoid
>>>>> double write for CEPH journal.
>>>>> ZFS core part libzpool (DMU, metaslab etc) offers a dnode object =
store
>>>>> and
>>>>> it's platform kernel/user independent. Another benefit for the id=
ea is
>>>>> we
>>>>> can extend our metadata without bothering any DBStore.
>>>>>=20
>>>>> Frankly, we are not sure if our idea is realistic so far, but whe=
n I
>>>>> heard of
>>>>> BlueFS, I think we need to know the BlueFS design goal.
>>>> I think it makes a lot of sense, but there are a few challenges.  =
One
>>>> reason we use rocksdb (or a similar kv store) is that we need in-o=
rder
>>>> enumeration of objects in order to do collection listing (needed f=
or
>>>> backfill, scrub, and omap).  You'll need something similar on top =
of zfs.
>>>>=20
>>>> I suspect the simplest path would be to also implement the rocksdb=
::Env
>>>> interface on top of the zfs libraries.  See BlueRocksEnv.{cc,h} to=
 see the
>>>> interface that has to be implemented...
>>>>=20
>>>> sage
>>>>=20
>>>=20
>>>=20
>>=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
