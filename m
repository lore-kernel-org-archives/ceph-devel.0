From: Guang Yang <yguang11@outlook.com>
Subject: Re: KeyFileStore ?
Date: Fri, 1 Aug 2014 23:08:21 +0800
Message-ID: <BLU436-SMTP1627AE51BD079D97C293309DFE70@phx.gbl>
References: <alpine.DEB.2.00.1407302156410.18917@cobra.newdream.net>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from blu004-omc4s19.hotmail.com ([65.55.111.158]:62037 "EHLO
	BLU004-OMC4S19.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750783AbaHAPIn convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 1 Aug 2014 11:08:43 -0400
In-Reply-To: <alpine.DEB.2.00.1407302156410.18917@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel@vger.kernel.org

I really like the idea, one scenario keeps bothering us is that there a=
re too many small files which make the file system indexing slow (so th=
at a single read request could take more than 10 disk IOs for path look=
up).

If we pursuit this proposal, is there a chance we can take one step fur=
ther, that instead of storing one physical file for each object, we can=
 allocate a big file (tens of GB) and each object only map to a chunk w=
ithin that big file. So that all those big file=92s description could b=
e cached to avoid disk I/O to open the file. At least we keep it flexib=
le that if someone would like to implement in such way, there is a chan=
ce to leverage the existing framework.

Thanks,
Guang

On Jul 31, 2014, at 1:25 PM, Sage Weil <sweil@redhat.com> wrote:

> After the latest set of bug fixes to the FileStore file naming code I=
 am=20
> newly inspired to replace it with something less complex.  Right now =
I'm=20
> mostly thinking about HDDs, although some of this may map well onto h=
ybrid=20
> SSD/HDD as well.  It may or may not make sense for pure flash.
>=20
> Anyway, here are the main flaws with the overall approach that FileSt=
ore=20
> uses:
>=20
> - It tries to maintain a direct mapping of object names to file names=
=2E =20
> This is problematic because of 255 character limits, rados namespaces=
, pg=20
> prefixes, and the pg directory hashing we do to allow efficient split=
, for=20
> starters.  It is also problematic because we often want to do things =
like=20
> rename but can't make it happen atomically in combination with the re=
st of=20
> our transaction.
>=20
> - The PG directory hashing (that we do to allow efficient split) can =
have=20
> a big impact on performance, particularly when injesting lots of data=
=2E =20
> (And when benchmarking.)  It's also complex.
>=20
> - We often overwrite or replace entire objects.  These are "easy"=20
> operations to do safely without doing complete data journaling, but t=
he=20
> current design is not conducive to doing anything clever (and it's co=
mplex=20
> enough that I wouldn't want to add any cleverness on top).
>=20
> - Objects may contain only key/value data, but we still have to creat=
e an=20
> inode for them and look that up first.  This only matters for some=20
> workloads (rgw indexes, cephfs directory objects).
>=20
> Instead, I think we should try a hybrid approach that more heavily=20
> leverages a key/value db in combination with the file system.  The kv=
 db=20
> might be leveldb, rocksdb, LMDB, BDB, or whatever else; for now we ju=
st=20
> assume it provides transactional key/value storage and efficient rang=
e=20
> operations.  Here's the basic idea:
>=20
> - The mapping from names to object lives in the kv db.  The object=20
> metadata is in a structure we can call an "onode" to avoid confusing =
it=20
> with the inodes in the backing file system.  The mapping is simple=20
> ghobject_t -> onode map; there is no PG collection.  The PG collectio=
n=20
> still exist but really only as ranges of those keys.  We will need to=
 be=20
> slightly clever with the coll_t to distinguish between "bare" PGs (th=
at=20
> live in this flat mapping) and the other collections (*_temp and=20
> metadata), but that should be easy.  This makes PG splitting "free" a=
s far=20
> as the objects go.
>=20
> - The onodes are relatively small.  They will contain the xattrs and=20
> basic metadata like object size.  They will also identify the file na=
me of=20
> the backing file in the file system (if size > 0).
>=20
> - The backing file can be a random, short file name.  We can just mak=
e a=20
> one or two level deep set of directories, and let the directories get=
=20
> reasonably big... whatever we decide the backing fs can handle=20
> efficiently.  We can also store a file handle in the onode and use th=
e=20
> open by handle API; this should let us go directly from onode (in our=
 kv=20
> db) to the on-disk inode without looking at the directory at all, and=
 fall=20
> back to using the actual file name only if that fails for some reason=
=20
> (say, someone mucked around with the backing files).  The backing fil=
e=20
> need not have any xattrs on it at all (except perhaps some simple id =
to=20
> verify it does it fact belong to the referring onode, just as a sanit=
y=20
> check).
>=20
> - The name -> onode mapping can live in a disjunct part of the kv=20
> namespace so that the other kv stuff associated with the file (like o=
map=20
> pairs or big xattrs or whatever) don't blow up those parts of the=20
> db and slow down lookup.
>=20
> - We can keep a simple LRU of recent onodes in memory and avoid the k=
v=20
> lookup for hot objects.
>=20
> - Previously complicated operations like rename are now trivial: we j=
ust=20
> update the kv db with a transaction.  The backing file never gets ren=
amed,=20
> ever, and the other object omap data is keyed by a unique (onode) id,=
 not=20
> the name.
>=20
> Initially, for simplicity, we can start with the existing data journa=
ling=20
> behavior.  However, I think there are opportunities to improve the=20
> situation there.  There is a pending wip-transactions branch in which=
 I=20
> started to rejigger the ObjectStore::Transaction interface a bit so t=
hat=20
> you identify objects by handle and then operation on them.  Although =
it=20
> doesn't change the encoding yet, once it does, we can make the=20
> implementation take advantage of that, by avoid duplicate name lookup=
s. =20
> It will also let us do things like clearly identify when an object is=
=20
> entirely new; in that case, we might forgo data journaling and instea=
d=20
> write the data to the (new) file, fsync, and then commit the journal =
entry=20
> with the transaction that uses it.  (On remount a simple cleanup proc=
ess=20
> can throw out new but unreferenced backing files.)  It would also mak=
e it=20
> easier to track all recently touched files and bulk fsync them instea=
d of=20
> doing a syncfs (if we decide that is faster).
>=20
> Anyway, at the end of the day, small writes or overwrites would still=
 be=20
> journaled, but large writes or large new objects would not, which wou=
ld (I=20
> think) be a pretty big improvement.  Overall, I think the design will=
 be=20
> much simpler to reason about, and there are several potential avenues=
 to=20
> be clever and make improvements.  I'm not sure we can say the same ab=
out=20
> the FileStore design, which suffers from the fact that it has evolved=
=20
> slowly over the last 9 years or so.
>=20
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
