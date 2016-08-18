From: Allen Samuels <Allen.Samuels@sandisk.com>
Subject: RE: bluestore blobs
Date: Thu, 18 Aug 2016 00:05:34 +0000
Message-ID: <BLUPR0201MB1524D88B4FD92E208DF840B0E8150@BLUPR0201MB1524.namprd02.prod.outlook.com>
References: <alpine.DEB.2.11.1608171407220.17762@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-sn1nam02on0071.outbound.protection.outlook.com ([104.47.36.71]:4968
	"EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752865AbcHRAFh (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 17 Aug 2016 20:05:37 -0400
In-Reply-To: <alpine.DEB.2.11.1608171407220.17762@piezo.us.to>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>




Allen Samuels
SanDisk |a Western Digital brand
2880 Junction Avenue, San Jose, CA 95134
T: +1 408 801 7030| M: +1 408 780 6416
allen.samuels@SanDisk.com


> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> owner@vger.kernel.org] On Behalf Of Sage Weil
> Sent: Wednesday, August 17, 2016 7:26 AM
> To: ceph-devel@vger.kernel.org
> Subject: bluestore blobs
>=20
> I think we need to look at other changes in addition to the encoding
> performance improvements.  Even if they end up being good enough, these
> changes are somewhat orthogonal and at least one of them should give us
> something that is even faster.
>=20
> 1. I mentioned this before, but we should keep the encoding
> bluestore_blob_t around when we load the blob map.  If it's not changed,
> don't reencode it.  There are no blockers for implementing this currently=
.
> It may be difficult to ensure the blobs are properly marked dirty... I'll=
 see if
> we can use proper accessors for the blob to enforce this at compile time.=
  We
> should do that anyway.

If it's not changed, then why are we re-writing it? I'm having a hard time =
thinking of a case worth optimizing where I want to re-write the oNode but =
the blob_map is unchanged. Am I missing something obvious?

>=20
> 2. This turns the blob Put into rocksdb into two memcpy stages: one to
> assemble the bufferlist (lots of bufferptrs to each untouched blob) into =
a
> single rocksdb::Slice, and another memcpy somewhere inside rocksdb to
> copy this into the write buffer.  We could extend the rocksdb interface t=
o
> take an iovec so that the first memcpy isn't needed (and rocksdb will ins=
tead
> iterate over our buffers and copy them directly into its write buffer).  =
This is
> probably a pretty small piece of the overall time... should verify with a
> profiler before investing too much effort here.

I doubt it's the memcpy that's really the expensive part. I'll bet it's tha=
t we're transcoding from an internal to an external representation on an el=
ement by element basis.
If the iovec scheme is going to help, it presumes that the internal data st=
ructure essentially matches the external data structure so that only an iov=
ec copy is required. I'm wondering how compatible this is with the current =
concepts of lextext/blob/pextent.

>=20
> 3. Even if we do the above, we're still setting a big (~4k or more?) key =
into
> rocksdb every time we touch an object, even when a tiny amount of
> metadata is getting changed.  This is a consequence of embedding all of t=
he
> blobs into the onode (or bnode).  That seemed like a good idea early on
> when they were tiny (i.e., just an extent), but now I'm not so sure.  I s=
ee a
> couple of different options:
>=20
> a) Store each blob as ($onode_key+$blobid).  When we load the onode, load
> the blobs too.  They will hopefully be sequential in rocksdb (or definite=
ly
> sequential in zs).  Probably go back to using an iterator.
>=20
> b) Go all in on the "bnode" like concept.  Assign blob ids so that they a=
re
> unique for any given hash value.  Then store the blobs as
> $shard.$poolid.$hash.$blobid (i.e., where the bnode is now).  Then when
> clone happens there is no onode->bnode migration magic happening--we've
> already committed to storing blobs in separate keys.  When we load the
> onode, keep the conditional bnode loading we already have.. but when the
> bnode is loaded load up all the blobs for the hash key.  (Okay, we could =
fault
> in blobs individually, but that code will be more complicated.)
>=20
> In both these cases, a write will dirty the onode (which is back to being=
 pretty
> small.. just xattrs and the lextent map) and 1-3 blobs (also now small ke=
ys).
> Updates will generate much lower metadata write traffic, which'll reduce
> media wear and compaction overhead.  The cost is that operations (e.g.,
> reads) that have to fault in an onode are now fetching several nearby key=
s
> instead of a single key.
>=20
>=20
> #1 and #2 are completely orthogonal to any encoding efficiency
> improvements we make.  And #1 is simple... I plan to implement this short=
ly.
>=20
> #3 is balancing (re)encoding efficiency against the cost of separate keys=
, and
> that tradeoff will change as encoding efficiency changes, so it'll be dif=
ficult to
> properly evaluate without knowing where we'll land with the (re)encode
> times.  I think it's a design decision made early on that is worth revisi=
ting,
> though!

It's not just the encoding efficiency, it's the cost of KV accesses. For ex=
ample, we could move the lextent map into the KV world similarly to the way=
 that you're suggesting the blob_maps be moved. You could do it for the xat=
trs also. Now you've almost completely eliminated any serialization/deseria=
lization costs for the LARGE oNodes that we have today but have replaced th=
at with several KV lookups (one small Onode, probably an xAttr, an lextent =
and a blob_map).

I'm guessing that the "right" point is in between. I doubt that separating =
the oNode from the xattrs pays off (especially since the current code prett=
y much assumes that they are all cheap to get at).

I'm wondering if it pays off to make each lextent entry a separate key/valu=
e vs encoding the entire extent table (several KB) as a single value.
Same for the blobmap (though I suspect they have roughly the same behavior =
w.r.t. this particular parameter)

We need to temper this experiment with the notion that we change the lexten=
t/blob_map encoding to something that doesn't require transcoding -- if pos=
sible.

>=20
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in =
the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
