From: Samuel Just <sam.just@inktank.com>
Subject: Re: KeyFileStore ?
Date: Fri, 1 Aug 2014 14:34:37 -0700
Message-ID: <CA+4uBUaCgKkS2z4C6v-Wnguuy3ynjffCqQpe3UsRTxPm02AREA@mail.gmail.com>
References: <alpine.DEB.2.00.1407302156410.18917@cobra.newdream.net>
	<BLU436-SMTP1627AE51BD079D97C293309DFE70@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f46.google.com ([209.85.192.46]:35044 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754822AbaHAVei convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Aug 2014 17:34:38 -0400
Received: by mail-qg0-f46.google.com with SMTP id z60so6278076qgd.5
        for <ceph-devel@vger.kernel.org>; Fri, 01 Aug 2014 14:34:37 -0700 (PDT)
In-Reply-To: <BLU436-SMTP1627AE51BD079D97C293309DFE70@phx.gbl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Guang Yang <yguang11@outlook.com>
Cc: Sage Weil <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Sage's basic approach sounds about right to me.  I'm fairly skeptical
about the benefits of packing small objects together within larger
files, though.  It seems like for very small objects, we would be
better off stashing the contents opportunistically within the onode.
=46or somewhat larger objects, it seems like the complexity of
maintaining information about the larger pack objects would be
equivalent to the what the filesystem would do anyway.
-Sam

On Fri, Aug 1, 2014 at 8:08 AM, Guang Yang <yguang11@outlook.com> wrote=
:
> I really like the idea, one scenario keeps bothering us is that there=
 are too many small files which make the file system indexing slow (so =
that a single read request could take more than 10 disk IOs for path lo=
okup).
>
> If we pursuit this proposal, is there a chance we can take one step f=
urther, that instead of storing one physical file for each object, we c=
an allocate a big file (tens of GB) and each object only map to a chunk=
 within that big file. So that all those big file=E2=80=99s description=
 could be cached to avoid disk I/O to open the file. At least we keep i=
t flexible that if someone would like to implement in such way, there i=
s a chance to leverage the existing framework.
>
> Thanks,
> Guang
>
> On Jul 31, 2014, at 1:25 PM, Sage Weil <sweil@redhat.com> wrote:
>
>> After the latest set of bug fixes to the FileStore file naming code =
I am
>> newly inspired to replace it with something less complex.  Right now=
 I'm
>> mostly thinking about HDDs, although some of this may map well onto =
hybrid
>> SSD/HDD as well.  It may or may not make sense for pure flash.
>>
>> Anyway, here are the main flaws with the overall approach that FileS=
tore
>> uses:
>>
>> - It tries to maintain a direct mapping of object names to file name=
s.
>> This is problematic because of 255 character limits, rados namespace=
s, pg
>> prefixes, and the pg directory hashing we do to allow efficient spli=
t, for
>> starters.  It is also problematic because we often want to do things=
 like
>> rename but can't make it happen atomically in combination with the r=
est of
>> our transaction.
>>
>> - The PG directory hashing (that we do to allow efficient split) can=
 have
>> a big impact on performance, particularly when injesting lots of dat=
a.
>> (And when benchmarking.)  It's also complex.
>>
>> - We often overwrite or replace entire objects.  These are "easy"
>> operations to do safely without doing complete data journaling, but =
the
>> current design is not conducive to doing anything clever (and it's c=
omplex
>> enough that I wouldn't want to add any cleverness on top).
>>
>> - Objects may contain only key/value data, but we still have to crea=
te an
>> inode for them and look that up first.  This only matters for some
>> workloads (rgw indexes, cephfs directory objects).
>>
>> Instead, I think we should try a hybrid approach that more heavily
>> leverages a key/value db in combination with the file system.  The k=
v db
>> might be leveldb, rocksdb, LMDB, BDB, or whatever else; for now we j=
ust
>> assume it provides transactional key/value storage and efficient ran=
ge
>> operations.  Here's the basic idea:
>>
>> - The mapping from names to object lives in the kv db.  The object
>> metadata is in a structure we can call an "onode" to avoid confusing=
 it
>> with the inodes in the backing file system.  The mapping is simple
>> ghobject_t -> onode map; there is no PG collection.  The PG collecti=
on
>> still exist but really only as ranges of those keys.  We will need t=
o be
>> slightly clever with the coll_t to distinguish between "bare" PGs (t=
hat
>> live in this flat mapping) and the other collections (*_temp and
>> metadata), but that should be easy.  This makes PG splitting "free" =
as far
>> as the objects go.
>>
>> - The onodes are relatively small.  They will contain the xattrs and
>> basic metadata like object size.  They will also identify the file n=
ame of
>> the backing file in the file system (if size > 0).
>>
>> - The backing file can be a random, short file name.  We can just ma=
ke a
>> one or two level deep set of directories, and let the directories ge=
t
>> reasonably big... whatever we decide the backing fs can handle
>> efficiently.  We can also store a file handle in the onode and use t=
he
>> open by handle API; this should let us go directly from onode (in ou=
r kv
>> db) to the on-disk inode without looking at the directory at all, an=
d fall
>> back to using the actual file name only if that fails for some reaso=
n
>> (say, someone mucked around with the backing files).  The backing fi=
le
>> need not have any xattrs on it at all (except perhaps some simple id=
 to
>> verify it does it fact belong to the referring onode, just as a sani=
ty
>> check).
>>
>> - The name -> onode mapping can live in a disjunct part of the kv
>> namespace so that the other kv stuff associated with the file (like =
omap
>> pairs or big xattrs or whatever) don't blow up those parts of the
>> db and slow down lookup.
>>
>> - We can keep a simple LRU of recent onodes in memory and avoid the =
kv
>> lookup for hot objects.
>>
>> - Previously complicated operations like rename are now trivial: we =
just
>> update the kv db with a transaction.  The backing file never gets re=
named,
>> ever, and the other object omap data is keyed by a unique (onode) id=
, not
>> the name.
>>
>> Initially, for simplicity, we can start with the existing data journ=
aling
>> behavior.  However, I think there are opportunities to improve the
>> situation there.  There is a pending wip-transactions branch in whic=
h I
>> started to rejigger the ObjectStore::Transaction interface a bit so =
that
>> you identify objects by handle and then operation on them.  Although=
 it
>> doesn't change the encoding yet, once it does, we can make the
>> implementation take advantage of that, by avoid duplicate name looku=
ps.
>> It will also let us do things like clearly identify when an object i=
s
>> entirely new; in that case, we might forgo data journaling and inste=
ad
>> write the data to the (new) file, fsync, and then commit the journal=
 entry
>> with the transaction that uses it.  (On remount a simple cleanup pro=
cess
>> can throw out new but unreferenced backing files.)  It would also ma=
ke it
>> easier to track all recently touched files and bulk fsync them inste=
ad of
>> doing a syncfs (if we decide that is faster).
>>
>> Anyway, at the end of the day, small writes or overwrites would stil=
l be
>> journaled, but large writes or large new objects would not, which wo=
uld (I
>> think) be a pretty big improvement.  Overall, I think the design wil=
l be
>> much simpler to reason about, and there are several potential avenue=
s to
>> be clever and make improvements.  I'm not sure we can say the same a=
bout
>> the FileStore design, which suffers from the fact that it has evolve=
d
>> slowly over the last 9 years or so.
>>
>> sage
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
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
