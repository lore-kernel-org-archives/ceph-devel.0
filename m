From: Guang Yang <yguang11@outlook.com>
Subject: Re: KeyFileStore ?
Date: Mon, 4 Aug 2014 22:27:11 +0800
Message-ID: <BLU436-SMTP224F2D544E4A94CDFE78C9FDFE20@phx.gbl>
References: <alpine.DEB.2.00.1407302156410.18917@cobra.newdream.net> <BLU436-SMTP1627AE51BD079D97C293309DFE70@phx.gbl> <CA+4uBUaCgKkS2z4C6v-Wnguuy3ynjffCqQpe3UsRTxPm02AREA@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from blu004-omc4s5.hotmail.com ([65.55.111.144]:63339 "EHLO
	BLU004-OMC4S5.hotmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752117AbaHDO1P convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Aug 2014 10:27:15 -0400
In-Reply-To: <CA+4uBUaCgKkS2z4C6v-Wnguuy3ynjffCqQpe3UsRTxPm02AREA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@inktank.com>
Cc: Sage Weil <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

=D4=DA 2014=C4=EA8=D4=C22=C8=D5=A3=AC=C9=CF=CE=E75:34=A3=ACSamuel Just =
<sam.just@inktank.com> =D0=B4=B5=C0=A3=BA

> Sage's basic approach sounds about right to me.  I'm fairly skeptical
> about the benefits of packing small objects together within larger
> files, though.  It seems like for very small objects, we would be
> better off stashing the contents opportunistically within the onode.
I really like this idea, for radosgw + EC use case, there are lots of s=
mall physical files generated (multiple Kbs), and when the OSD disk is =
filled to a certain ratio, each read to one chunk could incur several d=
isk I/Os (path lookup and data), and putting the data as part of onode =
could boost the read performance and as the same time, decrease the num=
ber of physical files.
> For somewhat larger objects, it seems like the complexity of
> maintaining information about the larger pack objects would be
> equivalent to the what the filesystem would do anyway.
> -Sam
>=20
> On Fri, Aug 1, 2014 at 8:08 AM, Guang Yang <yguang11@outlook.com> wro=
te:
>> I really like the idea, one scenario keeps bothering us is that ther=
e are too many small files which make the file system indexing slow (so=
 that a single read request could take more than 10 disk IOs for path l=
ookup).
>>=20
>> If we pursuit this proposal, is there a chance we can take one step =
further, that instead of storing one physical file for each object, we =
can allocate a big file (tens of GB) and each object only map to a chun=
k within that big file. So that all those big file=A1=AFs description c=
ould be cached to avoid disk I/O to open the file. At least we keep it =
flexible that if someone would like to implement in such way, there is =
a chance to leverage the existing framework.
>>=20
>> Thanks,
>> Guang
>>=20
>> On Jul 31, 2014, at 1:25 PM, Sage Weil <sweil@redhat.com> wrote:
>>=20
>>> After the latest set of bug fixes to the FileStore file naming code=
 I am
>>> newly inspired to replace it with something less complex.  Right no=
w I'm
>>> mostly thinking about HDDs, although some of this may map well onto=
 hybrid
>>> SSD/HDD as well.  It may or may not make sense for pure flash.
>>>=20
>>> Anyway, here are the main flaws with the overall approach that File=
Store
>>> uses:
>>>=20
>>> - It tries to maintain a direct mapping of object names to file nam=
es.
>>> This is problematic because of 255 character limits, rados namespac=
es, pg
>>> prefixes, and the pg directory hashing we do to allow efficient spl=
it, for
>>> starters.  It is also problematic because we often want to do thing=
s like
>>> rename but can't make it happen atomically in combination with the =
rest of
>>> our transaction.
>>>=20
>>> - The PG directory hashing (that we do to allow efficient split) ca=
n have
>>> a big impact on performance, particularly when injesting lots of da=
ta.
>>> (And when benchmarking.)  It's also complex.
>>>=20
>>> - We often overwrite or replace entire objects.  These are "easy"
>>> operations to do safely without doing complete data journaling, but=
 the
>>> current design is not conducive to doing anything clever (and it's =
complex
>>> enough that I wouldn't want to add any cleverness on top).
>>>=20
>>> - Objects may contain only key/value data, but we still have to cre=
ate an
>>> inode for them and look that up first.  This only matters for some
>>> workloads (rgw indexes, cephfs directory objects).
>>>=20
>>> Instead, I think we should try a hybrid approach that more heavily
>>> leverages a key/value db in combination with the file system.  The =
kv db
>>> might be leveldb, rocksdb, LMDB, BDB, or whatever else; for now we =
just
>>> assume it provides transactional key/value storage and efficient ra=
nge
>>> operations.  Here's the basic idea:
>>>=20
>>> - The mapping from names to object lives in the kv db.  The object
>>> metadata is in a structure we can call an "onode" to avoid confusin=
g it
>>> with the inodes in the backing file system.  The mapping is simple
>>> ghobject_t -> onode map; there is no PG collection.  The PG collect=
ion
>>> still exist but really only as ranges of those keys.  We will need =
to be
>>> slightly clever with the coll_t to distinguish between "bare" PGs (=
that
>>> live in this flat mapping) and the other collections (*_temp and
>>> metadata), but that should be easy.  This makes PG splitting "free"=
 as far
>>> as the objects go.
>>>=20
>>> - The onodes are relatively small.  They will contain the xattrs an=
d
>>> basic metadata like object size.  They will also identify the file =
name of
>>> the backing file in the file system (if size > 0).
>>>=20
>>> - The backing file can be a random, short file name.  We can just m=
ake a
>>> one or two level deep set of directories, and let the directories g=
et
>>> reasonably big... whatever we decide the backing fs can handle
>>> efficiently.  We can also store a file handle in the onode and use =
the
>>> open by handle API; this should let us go directly from onode (in o=
ur kv
>>> db) to the on-disk inode without looking at the directory at all, a=
nd fall
>>> back to using the actual file name only if that fails for some reas=
on
>>> (say, someone mucked around with the backing files).  The backing f=
ile
>>> need not have any xattrs on it at all (except perhaps some simple i=
d to
>>> verify it does it fact belong to the referring onode, just as a san=
ity
>>> check).
>>>=20
>>> - The name -> onode mapping can live in a disjunct part of the kv
>>> namespace so that the other kv stuff associated with the file (like=
 omap
>>> pairs or big xattrs or whatever) don't blow up those parts of the
>>> db and slow down lookup.
>>>=20
>>> - We can keep a simple LRU of recent onodes in memory and avoid the=
 kv
>>> lookup for hot objects.
>>>=20
>>> - Previously complicated operations like rename are now trivial: we=
 just
>>> update the kv db with a transaction.  The backing file never gets r=
enamed,
>>> ever, and the other object omap data is keyed by a unique (onode) i=
d, not
>>> the name.
>>>=20
>>> Initially, for simplicity, we can start with the existing data jour=
naling
>>> behavior.  However, I think there are opportunities to improve the
>>> situation there.  There is a pending wip-transactions branch in whi=
ch I
>>> started to rejigger the ObjectStore::Transaction interface a bit so=
 that
>>> you identify objects by handle and then operation on them.  Althoug=
h it
>>> doesn't change the encoding yet, once it does, we can make the
>>> implementation take advantage of that, by avoid duplicate name look=
ups.
>>> It will also let us do things like clearly identify when an object =
is
>>> entirely new; in that case, we might forgo data journaling and inst=
ead
>>> write the data to the (new) file, fsync, and then commit the journa=
l entry
>>> with the transaction that uses it.  (On remount a simple cleanup pr=
ocess
>>> can throw out new but unreferenced backing files.)  It would also m=
ake it
>>> easier to track all recently touched files and bulk fsync them inst=
ead of
>>> doing a syncfs (if we decide that is faster).
>>>=20
>>> Anyway, at the end of the day, small writes or overwrites would sti=
ll be
>>> journaled, but large writes or large new objects would not, which w=
ould (I
>>> think) be a pretty big improvement.  Overall, I think the design wi=
ll be
>>> much simpler to reason about, and there are several potential avenu=
es to
>>> be clever and make improvements.  I'm not sure we can say the same =
about
>>> the FileStore design, which suffers from the fact that it has evolv=
ed
>>> slowly over the last 9 years or so.
>>>=20
>>> sage
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>=20
>>=20
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
