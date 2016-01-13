From: Javen Wu <javen.wu@xtaotech.com>
Subject: Re: Is BlueFS an alternative of BlueStore?
Date: Wed, 13 Jan 2016 22:31:33 +0800
Message-ID: <56965FC5.9070009@xtaotech.com>
References: <568DE333.7070206@xtaotech.com>
 <alpine.DEB.2.11.1601070813000.26051@cpach.fuggernut.com>
 <568E781B.4030803@xtaotech.com> <568E78D8.8080401@xtaotech.com>
 <alpine.DEB.2.11.1601071003140.26051@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mr213139.mail.yeah.net ([223.252.213.139]:55664 "EHLO
	mr213139.mail.yeah.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756008AbcAMObv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Jan 2016 09:31:51 -0500
In-Reply-To: <alpine.DEB.2.11.1601071003140.26051@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "peng.hse" <peng.hse@xtaotech.com>, ceph-devel@vger.kernel.org

Hi Sage,

Peng and I investigated the code about PG backfill and scrub per your=20
guidance.
Below is further investigation result.

Please forgive me about the long email :-(

ZFS library + ObjectStore
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D

I think I know very well about what you mentioned "collection sorted
enumeration". The so called "sorted enumeration" actually implies two
meanings:

1. a sort of all objects in the collection.
2. given a object, it can tell whether the object in a range easily.

Obviously, the most efficient way is NOT to sort the objects of collect=
ion
after we retrieve the list of objects from backend. So it would be bett=
er
that the entries are stored on the backend according the expected order=
=2E
That's why RocksDB is key piece of BlueStore.

We tried so hard to map the ZFS ZAP to CEPH collection. Here is what we
thought the scheme:

ZAP is ZFS Attribute Processor which is actually a object type to descr=
ibe
Key-Value set. ZFS used it a lot to describe metadata, Directory is one=
=20
of them.
And the most important thing is entries in ZAP does have a "ORDER". The=
 ZAP
hashes the "key" to a 64-bit integer, plus a 32-bit CD (collision
differentiator) to index and store the KV entries. The CD is managed by=
 ZAP
iteself to solve hash collision and is persisted in the ZAP entry=20
descriptor.
(There is more detailed explanation about ZAP at the end of the mail)

In theory, we are able to use ZAP to achieve the goal of "sorted=20
enumeration".
=46irstly, we can retrieve a sorted list of KVs(objects) from ZAP.
Secondly, according key name (object name), hash can be calculated, and=
=20
we can
retrieve CD from on-disk ZAP entry associated to the object.bring hash=20
and CD
together, the order is able to be determined.

However, we didn't find a elegant way to implement the idea for CEPH. I=
f we
leverage ZFS libraries to implement a new ObjectStore, the change canno=
t
be well confined in the ObjectStore layer since hboject, gobject and
comparision logic will be redefined based on ZFS "ZAP entry hash + CD",
which is beyond the scope of ObjectStore alone. The comparision logics
is spread in ReplicatedPG etc.

In addition, we have another question about BlueStore which is relevant=
=20
to our
idea. Does BlueStore consider "batch writes"?
Similar to BlueStore, ZFS is also no "modify in place". ZFS's transacti=
on
considers not only metadata/data consistency, but also "batch writes". =
The
write batch reduces disk write times significantly. So ZFS transaction
persist data to disk in 5 seconds period. I saw FileStore persist data
immediately even in filesystem semantics without sync() requirement.
If we align ZFS transaction and CEPH ObjectStore transaction, it means
we either delay persist data to backend until 5-second transaction comm=
it
or persist data to ZIL immediately before update real backend. The last
choice is still double write. Will it be a problem if we delay persist
data and reply to client until the data is persisted?

We are looking forward to your advice, is it worthy that we continue th=
e
proposal (leveraging ZFS library to implement a new ObjectStore)?

ZFS Library + RocksDB
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
We also evaluated the possibility of using ZFS libraries to host
RocksDB. I think it is very hard to do that. The reasons are:

1. ZIL reclaims the block after log trim and allocates block when new
log record is added, so that means there is no BlueFS-like "warm up
phase."

2. RocksDB does sync write for WAL. Then RocksDB sync flush memtable
to backend file before trim WAL. ZFS does not like sync operation since
it tries to batch writes and commit data in 5 seconds. ZFS trim ZIL onc=
e
transaction is commited. So the life cycle of ZIL does not match RocksD=
B
WAL. If we are going to change that, there would be a huge change in
RocksDB which cannot be confined in RocksDB::Env.

Overall, there is NO impossible in Engineer's world, but whether the
effort is worthful should be considered carefully ;-)


ZAP description:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

ZAP hashes the attribute name (key) to a 64 bit integer.
CD is collision differentiator when hash collision and CD
is managed by ZAP and is persisted on the backend.

So 64bit hash + CD uniquely identify a attribute in the ZAP object.
ZAP insert/index the KVs in the order of (hash + CD).

n + m + k =3D 64 bits
n bits decide the point table bucket,
m bits decide which zap leaf block
k bits decide the entry in the leaf bucket
CD is collision differentiator

+---------------------+
|ZAP object descriptor|
+---------------------+
          |
          |  n bit of prefix of 64-bit hash index into bucket of ptbl
          V
pointer table
  ___________
| zap leaf  |
|___________|           zap leaf           zap leaf
| zap leaf  |        ____________        ____________
|___________|        |   next   |        |   next   |
| zap leaf  |------->|__________|------> |__________|
|___________|        | hash tbl |        | hash tbl |
|    ...    |        |__________|        |__________|
                           |                   |
                           | entry hash tbl    | entry hash tbl
                      _____V_____          ____V_____
                      |__________|        |__________|
                      |__________|        |__________|
                      |__________|        |__________|
                      |__________|        |__________|
            ----------|__________| |__________|
            |
            |
            |
            |
         ___V______        __________ __________
        |entry next|----> |entry next|----> |entry next|
        |__________|      |__________|      |__________|
        |__ hash___|      |___hash___|      |___hash___|
        |    CD    |      |    CD    |      |    CD    |
        |__________|      |__________|      |__________|


Thanks
Javen & Peng


> On Thu, 7 Jan 2016, Javen Wu wrote:
>> Thanks Sage for your reply.
>>
>> I am not sure I understand the challenges you mentioned about backfi=
ll/scrub.
>> I will investigate from the code and let you know if we can conquer =
the
>> challenge by easy means.
>> Our rough idea for ZFSStore are:
>> 1. encapsulate dnode object as onode and add onode attributes.
>> 2. uses ZAP object as collection. (ZFS directory uses ZAP object)
>> 3. enumerating entries in ZAP object is list objects in collection.
> This is the key piece that will determine whether rocksdb (or somethi=
ng
> similar) is required.  POSIX doesn't give you sorted enumeration of
> files.  In order to provide that with FileStore, we used a horrible
> hashing scheme that dynamically broke directories into
> smaller subdirectories once they got big, and organized things by a h=
ash
> prefix (enumeration is in hash order).  That meant a mess of director=
ies
> with bounded size (so that there were a bounded number of entries to =
read
> and then sort in memory before returning a sorted result), which was
> inefficient, and it meant that as the number of objects grew you'd ha=
ve
> this periodic rehash work that had to be done that further slowed thi=
ngs
> down.  This, combined with the inability to group an arbitrary
> number of file operations (writes, unlinks, renames, setxattrs, etc.)=
 into
> an atomic transaction was FileStore's downfall.  I think the zfs libs=
 give
> you the transactions you need, but you *also* need to get sorted
> enumeration (with a sort order you define) or else you'll have all th=
e
> ugliness of the FileStore indexes.
>
>> 4. create a new metaslab class to store CEPH journal.
>> 5. align CEPH journal and ZFS transcation.
>>
>> Actually we've talked about the possibility of building RocksDB::Env=
 on top
>> of the zfs libraries. It must align ZIL(ZFS intent log) and RocksDB =
WAL.
>> Otherwise, there is still same problem as XFS and RocksDB.
>>
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
> If you implement rocksdb::Env, you'll see the rocksdb WAL writes and =
the
> fsync calls come down.  You can store those however you'd like... as
> "files" or perhaps directly in the ZIL.
>
> The way we do this in BlueFS is that for an initial warm-up period, w=
e
> append to a WAL log file, and have to do both the log write *and* a
> journal write to update the file size.  Once we've written out enough
> logs, though, we start recycling the same logs (and disk blocks) and =
just
> overwrite the previously allocated space.  The rocksdb log replay is =
now
> smart enough to determine when it's reached the end of the new conten=
t and
> is now seeing (old) garbage and stop.
>
> Whether it makes sense to do something similar in zfs-land I'm not su=
re.
> Presumably the ZIL itself is doing something similar (sequence nubmer=
s and
> crcs on log entries in a circular buffer) but the rocksdb log
> lifecycle probably doesn't match the ZIL...
>
> sage
>
>> In my mind, aligning ZIL and WAL need more modifications in RocksDB.
>>
>> Thanks
>> Javen
>>
>>
>> On 2016=E5=B9=B401=E6=9C=8807=E6=97=A5 22:37, peng.hse wrote:
>>> Hi Sage,
>>>
>>> thanks for your quick response. Javen and I  once the zfs developer=
,are
>>> currently focusing on how to
>>> leverage some of the zfs ideas to improve the ceph backend performa=
nce in
>>> userspace.
>>>
>>>
>>> Based on your encouraging reply, we come up with 2 schemes to conti=
nue our
>>> future work
>>>
>>> 1. the scheme one: using the entire new FS to replace rocksdb+bluef=
s, the FS
>>> itself handles the mapping of
>>>      oid->fs-object(kind of zfs dnode) and the according attrs used=
 by ceph.
>>>     Despite the implemention challenges you mentioned about the in-=
order
>>> enumeration of objects during backfill, scrub, etc (the
>>>      same situation we also confronted in zfs, the ZAP features hel=
p us a
>>> lot).
>>>      From performance or architecture point of view, it looks more =
clear and
>>> clean, would you suggest us to give a try ?
>>>
>>> 2. the scheme two: As your last suspect, we just temporarily implem=
ented the
>>> simple version of the FS
>>>       which leverage libzpool ideas to plug into rocksdb underneath=
 as your
>>> bluefs did
>>>
>>> precious your insightful reply.
>>>
>>> Thanks
>>>
>>>
>>>
>>> On 2016=E5=B9=B401=E6=9C=8807=E6=97=A5 21:19, Sage Weil wrote:
>>>> On Thu, 7 Jan 2016, Javen Wu wrote:
>>>>> Hi Sage,
>>>>>
>>>>> Sorry to bother you. I am not sure if it is appropriate to send e=
mail to
>>>>> you
>>>>> directly, but I cannot find any useful information to address my
>>>>> confusion
>>>>> from Internet. Hope you can help me.
>>>>>
>>>>> Occasionally, I heard that you are going to start BlueFS to elimi=
nate
>>>>> the
>>>>> redudancy between XFS journal and RocksDB WAL. I am a little conf=
used.
>>>>> Is the Bluefs only to host RocksDB for BlueStore or it's an
>>>>> alternative of BlueStore?
>>>>>
>>>>> I am a new comer to CEPH, I am not sure my understanding is corre=
ct
>>>>> about
>>>>> BlueStore. BlueStore in my mind is as below.
>>>>>
>>>>>                BlueStore
>>>>>                =3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>>      RocksDB
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
>>>>
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
>>>>
>>>>    +--------------------+
>>>>    |     bluestore      |
>>>>    +----------+         |
>>>>    | rocksdb  |         |
>>>>    +----------+         |
>>>>    |  bluefs  |         |
>>>>    +----------+---------+
>>>>    |    block device    |
>>>>    +--------------------+
>>>>
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
>>>>>
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
>>>>
>>>> I suspect the simplest path would be to also implement the rocksdb=
::Env
>>>> interface on top of the zfs libraries.  See BlueRocksEnv.{cc,h} to=
 see the
>>>> interface that has to be implemented...
>>>>
>>>> sage
>>>>
>>>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
