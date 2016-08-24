From: Allen Samuels <Allen.Samuels@sandisk.com>
Subject: Re: bluestore blobs REVISITED
Date: Wed, 24 Aug 2016 18:50:26 +0000
Message-ID: <0ED14ED6-106E-485E-B275-06FDAE81FFB6@sandisk.com>
References: <BLUPR0201MB15245F1EA4B70EF5761981AFE8170@BLUPR0201MB1524.namprd02.prod.outlook.com>,<alpine.DEB.2.11.1608211601350.14754@piezo.us.to>
 <2F51EC8C-D280-4DFF-8FF6-4AC97071A7D5@sandisk.com>
 <BLUPR0201MB15245054714F66FC2AB92935E8E80@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1608222158190.25681@piezo.us.to>
 <BLUPR0201MB152454CA00246E35A1AE08C0E8E80@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1608222249560.25681@piezo.us.to>
 <BLUPR0201MB1524C52747AF115A4C178D0FE8E80@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1608231548080.25678@piezo.us.to>
 <BLUPR0201MB152475F2D6907CAD2E594FC6E8EB0@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1608231918460.25678@piezo.us.to>
 <BLUPR0201MB1524808F8F4763BB50517C12E8EA0@BLUPR0201MB1524.namprd02.prod.outlook.com>,<alpine.DEB.2.11.1608241759180.25678@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-by2nam01on0089.outbound.protection.outlook.com ([104.47.34.89]:18049
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754275AbcHXT2C (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 24 Aug 2016 15:28:02 -0400
In-Reply-To: <alpine.DEB.2.11.1608241759180.25678@piezo.us.to>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

A few quick thoughts on this lousy keyboard.=20

Wrt smr a flag that treats all blobs as global is easy and uncomplicated. T=
he performance loss won't be significant if you're metadata is on flash. If=
 it's all hdd you don't care about performance at all.=20

Sent from my iPhone. Please excuse all typos and autocorrects.

> On Aug 24, 2016, at 2:16 PM, Sage Weil <sweil@redhat.com> wrote:
>=20
> On Wed, 24 Aug 2016, Allen Samuels wrote:
>>>>> From: Sage Weil [mailto:sweil@redhat.com]
>>>>> Sent: Tuesday, August 23, 2016 12:03 PM
>>>>> To: Allen Samuels <Allen.Samuels@sandisk.com>
>>>>> Cc: ceph-devel@vger.kernel.org
>>>>> Subject: RE: bluestore blobs REVISITED
>>>>>=20
>>>>> I just got the onode, including the full lextent map, down to ~1500 b=
ytes.
>>>>> The lextent map encoding optimizations went something like this:
>>>>>=20
>>>>> - 1 blobid bit to indicate that this lextent starts where the last on=
e ended.
>>>>> (6500->5500)
>>>>>=20
>>>>> - 1 blobid bit to indicate offset is 0; 1 blobid bit to indicate
>>>>> length is same as previous lextent.  (5500->3500)
>>>>>=20
>>>>> - make blobid signed (1 bit) and delta encode relative to previous bl=
ob.
>>>>> (3500->1500).  In practice we'd get something between 1500 and 3500
>>>>> because blobids won't have as much temporal locality as my test
>>> workload.
>>>>> OTOH, this is really important because blobids will also get big
>>>>> over time (we don't (yet?) have a way to reuse blobids and/or keep
>>>>> them unique to a hash key, so they grow as the osd ages).
>>>>=20
>>>> This seems fishy to me, my mental model for the blob_id suggests that
>>>> it must be at least 9 bits (for a random write workload) in size (1K
>>>> entries randomly written lead to an average distance of 512, which
>>>> means
>>>> 10 bits to encode -- plus the other optimizations bits). Meaning that
>>>> you're going to have two bytes for each lextent, meaning at least 2048
>>>> bytes of lextent plus the remainder of the oNode. So, probably more
>>>> like
>>>> 2500 bytes.
>>>>=20
>>>> Am I missing something?
>>>=20
>>> Yeah, it'll be ~2 bytes in general, not 1, so closer to 2500 bytes.  I =
this is still
>>> enough to get us under 4K of metadata if we make pg_stat_t encoding
>>> space-efficient (and possibly even without out).
>=20
> Repeating this test with random IO gives onodes that are more like 6-7k, =
I=20
> think just because there are too many significant bits in the blob id.
>=20
> So, I think we can scratch options #1 and #2 off the list.
>=20
>>>>> 3) join lextents and blobs (Allen's proposal) and dynamically bin
>>>>> based on the encoded size.
>>>>>=20
>>>>> 4) #3, but let shard_size=3D0 in onode (or whatever) put it inline
>>>>> with onode, so that simple objects avoid any additional kv op.
>>>>=20
>>>> Yes, I'm still of the mind that this is the best approach. I'm not
>>>> sure it's really that hard because most of the "special" cases can be
>>>> dealt with in a common brute-force way (because they don't happen too
>>> often).
>>>=20
>>> Yep.  I think my next task is to code this one up.  Before I start, tho=
ugh, I want
>>> to make sure I'm doing the most reasonable thing.  Please
>>> review:
>>>=20
>>> Right now the blobwise branch has (unshared and) shared blobs in their =
own
>>> key.  Shared blobs only update when they are occluded and their ref_map
>>> changes.  If it weren't for that, we could go back to cramming them tog=
ether
>>> in a single bnode key, but I'm I think we'll do better with them as sep=
arate
>>> blob keys.  This helps small reads (we don't load all blobs), hurts lar=
ge reads
>>> (we read them all from separate keys instead of all at once), and of co=
urse
>>> helps writes because we only update a single small blob record.
>>>=20
>>> The onode will get a extent_map_shard_size, which is measured in bytes
>>> and tells us how the map is chunked into keys.  If it's 0, the whole ma=
p will
>>> stay inline in the onode.  Otherwise, [0..extent_map_shard_size) is in =
the
>>> first key, [extent_map_shard_size, extent_map_shard_size*2) is in the
>>> second, etc.
>>=20
>> I've been thinking about this. I definitely like the '0' case where the =
lextent and potentially the local blob are inline with the oNode. That'll c=
ertainly accelerate lots of Object and CephFS stuff. All options should imp=
lement this.
>>=20
>> I've been thinking about the lextent sharding/binning/paging problem. Me=
ntally, I see two different ways to do it:
>>=20
>> (1) offset-based fixed binning -- I think this is what you described, i.=
e., the lextent table is recast into fixed offset ranges.
>> (2) Dynamic binning. In this case, the ranges of lextent that are stored=
 as a set of ranges (interval-set) each entry in the interval set represent=
s a KV key and contains some arbitrary number of lextent entries within (bo=
undaries are a dynamic decision)
>>=20
>> The downside of (1) is that you're going to have logical extents that cr=
oss the fixed bins (and sometimes MULTIPLE fixed bins). Handling this is ju=
st plain ugly in the code -- all sorts of special cases crop up for things =
like local-blobs that used to be unshared, now are sorta-shared (between th=
e two 'split' lextent entries). Then there are the cases where single lexte=
nts cross 2, 3, 10 shards.... UGLY UGLY UGLY.=20
>>=20
>> A secondary problem (quite possibly a non-problem) is that the sizes of =
the chunks of encoded lextent don't necessarily divide up particularly even=
ly. Hot spots in objects will cause this problem.
>>=20
>> Method (2) sounds more complicated, but I actually think it's dramatical=
ly LESS complicated to implement -- because we're going to brute force our =
way around a lot of problem. First off, none of the ugly issues of splittin=
g an lextent crop up -- by definition -- since we're chunking the map on wh=
ole lextent boundaries. I think from an implementation perspective you can =
break this down into some relatively simple logic.
>>=20
>> Basically from an implementation perspective, at the start of the operat=
ion (read or write), you compare the incoming offset with the interval-set =
in the oNode and page in the portions of the lextent table that are require=
d (required=3D> for uncompressed is just the range in the incoming operatio=
n, for compressed I think you need to have the lextent before and after the=
 incoming operation range to make the "depth limiting" code work correctly)=
.
>> For a read, you're always done at this point in time.
>> For a write, you'll have the problem of updating the lextent table with =
whatever changes have been made. There are basically two sub-cases for the =
update:=20
>> (a) updated lextent chunk (or chunks!) are sufficiently similar that you=
 want to maintain the current "chunking" values (more on this below). This =
is the easy case, just reserialize the chunk (or chunks) of the lextent tha=
t are changed (again, because of over-fetching in the compression case the =
changed range might not =3D=3D the fetched range)=20
>> (b) You decide that re-chunking is required.  There are lots of cases of=
 splits and joins of chunks -- more ugly code. However because the worst-ca=
se size of the lextent isn't really THAT large (and the frequency of re-chu=
nking should be relatively low).  My recommendation is that we ONLY impleme=
nt the complete re-chunking case. In other words, if you look at the chunki=
ng and you don't like it -- rather than spending time figuring out a bunch =
of splits and joins (sorta reminds me of FIleStore directory splits) just r=
ead in the remainder of the lextent into memory and re-chunk the entire dar=
n thing. As long as the frequency of this is low it should be cheap enough =
(a max-size lextent table isn't THAT big). Keeping the frequency of chunkin=
g low should be doable by a policy with some hysteresis, i.e., something li=
ke if a chunk is > 'N' bytes do a splitting-rechunk, but only if it's small=
er than N/2 bytes do a joining-rechunk.... Something like that...=20
>>=20
>> Nothing in the odisk structures prevents future code from implementing a=
 more sophisticated split/join chunking scheme. In fact, I recommend that t=
he oNode interval_set of the lextent chunks be decorated with the serialize=
d sizes of each chunk so as to make that future algorithm much easier to im=
plement (since it'll know the sizes of all of the serialized chunks). In ot=
her words, when it comes time to update the oNode/lextent, do the lextent c=
hunks FIRST and use the generated sizes of the serialized lextents to put i=
nto the chunking table in the oNode. Have the sizes of all of the chunks av=
ailable (without having to consult the KV store) will make the policy decis=
ion about when to re-chunk fairly easy to do and allow the future optimizer=
 to make more intelligent decisions about balancing the chunk-boundaries --=
 the extra data is pretty small and likely worth it (IMO).
>>=20
>> I strongly believe that (2) is the way to go.
>=20
> Yep, agreed!
>=20
>>> In memory, we can pull this out of the onode_t struct and manage it in
>>> Onode where we can keep track of which parts of loaded, dirty, etc.
>>>=20
>>> For each map chunk, we can do the inline blob trick.  Unfortunately we =
can
>>> only do this for 'unshared' blobs where shared is now shared across
>>> extent_map shards and not across objects.  We can conservatively estima=
te
>>> this by just looking at the blob size w/o looking at other lextents, at=
 least.
>>=20
>> Some thoughts here. In the PMR and Flash world, isn't it the case that b=
lobs are essentially immutable once they are global?
>>=20
>> (In the SMR world, I know they'll be modified in order to "relocate" a c=
hunk -- possibly invalidating the immutable assumption).
>>=20
>> Why NOT pull the blob up into the lextent -- as a copy? If it's immutabl=
e, what's the harm? Yes, the stored metadata now expands by the reference c=
ount of a cloned blob, but if you can eliminate an extra KV fetch, I'm of t=
he opinion that this seems like a desireable time/space tradeoff.... Just a=
 thought :)
>>=20
>> BTW, here's potentially a really important thing that I just realized...=
. For a global blob, you want to make the blob_id something like #HashID.#L=
BA, that way when you're trying to do the SMR backpointer thing, you can mi=
nimize the number of bNodes you search for to find this LBA address (someth=
ing like that :)) -- naturally this fails for blobs with multiple pextents =
-- But we can outlaw this case in the SMR world (space is basically ALWAYS =
sequential in the SMR world :)).
>=20
> Hrm.  This is frustrating.  Being able to do *blob* backpointers and only=
=20
> update blobs for SMR compaction is really appealing, but that means a fla=
g=20
> that prevents blob inline-copying on SMR.  This makes me nervous because=
=20
> there will be yet another permutation in the mix: fully inline blob,=20
> external with inline copy (use external one if updating ref_map), and=20
> fully external.
>=20
> And if we do the inline copy, there isn't actually any purpose to most of=
=20
> the external copy except the ref_map.
>=20
> OTOH, with currently workloads at least we expect that cloned/shared blob=
s=20
> will be pretty rare, so perhaps we should ignore this and keep object has=
h=20
> (not blob) backpointers for SMR.
>=20
> In that case, we should focus instead on sharing the ref_map *only* and=20
> always inline the forward pointers for the blob.  This is closer to what=
=20
> we were originally doing with the enode.  In fact, we could go back to th=
e=20
> enode approach were it's just a big extent_ref_map and only used to defer=
=20
> deallocations until all refs are retired.  The blob is then more ephemera=
l=20
> (local to the onode, immutable copy if cloned), and we can more easily=20
> rejigger how we store it.
>=20
> We'd still have a "ref map" type structure for the blob, but it would onl=
y=20
> be used for counting the lextents that reference it, and we can=20
> dynamically build it when we load the extent map.  If we impose the=20
> restriction that whatever the map sharding approach we take we never shar=
e=20
> a blob across a shard, we the blobs are always local and "ephemeral"=20
> in the sense we've been talking about.  The only downside here, I think,=
=20
> is that the write path needs to be smart enough to not create any new blo=
b=20
> that spans whatever the current map sharding is (or, alternatively,=20
> trigger a resharding if it does so).
>=20
>=20
> Anyway, the main practical item that has me grumbling about this=20
> is that having extent_map in the onode_t means we have lots of helpers=20
> nad associated unit tests in test_bluestore_types.cc and making the=20
> extent map into a more dynamic structure (with pointers instead of ids=20
> etc) pulls it up a level above _types.{cc,h} and makes unit tests harder=
=20
> to write.  OTOH, the more complex structure probably needs its own tests=
=20
> to ensure we do the paging properly anyway, so here goes...
>=20
> sage
