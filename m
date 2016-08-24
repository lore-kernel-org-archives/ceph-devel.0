From: Allen Samuels <Allen.Samuels@sandisk.com>
Subject: Re: bluestore blobs REVISITED
Date: Wed, 24 Aug 2016 20:59:03 +0000
Message-ID: <93C9C50F-C513-41DA-BAEE-BAD1B05BFC63@sandisk.com>
References: <BLUPR0201MB15245F1EA4B70EF5761981AFE8170@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1608211601350.14754@piezo.us.to>
 <2F51EC8C-D280-4DFF-8FF6-4AC97071A7D5@sandisk.com>
 <BLUPR0201MB15245054714F66FC2AB92935E8E80@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1608222158190.25681@piezo.us.to>
 <BLUPR0201MB152454CA00246E35A1AE08C0E8E80@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1608222249560.25681@piezo.us.to>
 <BLUPR0201MB1524C52747AF115A4C178D0FE8E80@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1608231548080.25678@piezo.us.to>
 <BLUPR0201MB152475F2D6907CAD2E594FC6E8EB0@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1608231918460.25678@piezo.us.to>
 <BLUPR0201MB1524808F8F4763BB50517C12E8EA0@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1608241759180.25678@piezo.us.to>,<2cb7e3b7-1e34-c13d-f3ba-8107385dacb7@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-sn1nam02on0050.outbound.protection.outlook.com ([104.47.36.50]:52859
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932865AbcHXU7V (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 24 Aug 2016 16:59:21 -0400
In-Reply-To: <2cb7e3b7-1e34-c13d-f3ba-8107385dacb7@redhat.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>
Cc: Sage Weil <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Yea I totally botched the math on the random write estimation. It's a proba=
bilistic exponential. Doesn't matter.=20

Sent from my iPhone. Please excuse all typos and autocorrects.

> On Aug 24, 2016, at 4:47 PM, Mark Nelson <mnelson@redhat.com> wrote:
>=20
>=20
>=20
>> On 08/24/2016 01:15 PM, Sage Weil wrote:
>> On Wed, 24 Aug 2016, Allen Samuels wrote:
>>>>>> From: Sage Weil [mailto:sweil@redhat.com]
>>>>>> Sent: Tuesday, August 23, 2016 12:03 PM
>>>>>> To: Allen Samuels <Allen.Samuels@sandisk.com>
>>>>>> Cc: ceph-devel@vger.kernel.org
>>>>>> Subject: RE: bluestore blobs REVISITED
>>>>>>=20
>>>>>> I just got the onode, including the full lextent map, down to ~1500 =
bytes.
>>>>>> The lextent map encoding optimizations went something like this:
>>>>>>=20
>>>>>> - 1 blobid bit to indicate that this lextent starts where the last o=
ne ended.
>>>>>> (6500->5500)
>>>>>>=20
>>>>>> - 1 blobid bit to indicate offset is 0; 1 blobid bit to indicate
>>>>>> length is same as previous lextent.  (5500->3500)
>>>>>>=20
>>>>>> - make blobid signed (1 bit) and delta encode relative to previous b=
lob.
>>>>>> (3500->1500).  In practice we'd get something between 1500 and 3500
>>>>>> because blobids won't have as much temporal locality as my test
>>>> workload.
>>>>>> OTOH, this is really important because blobids will also get big
>>>>>> over time (we don't (yet?) have a way to reuse blobids and/or keep
>>>>>> them unique to a hash key, so they grow as the osd ages).
>>>>>=20
>>>>> This seems fishy to me, my mental model for the blob_id suggests that
>>>>> it must be at least 9 bits (for a random write workload) in size (1K
>>>>> entries randomly written lead to an average distance of 512, which
>>>>> means
>>>>> 10 bits to encode -- plus the other optimizations bits). Meaning that
>>>>> you're going to have two bytes for each lextent, meaning at least 204=
8
>>>>> bytes of lextent plus the remainder of the oNode. So, probably more
>>>>> like
>>>>> 2500 bytes.
>>>>>=20
>>>>> Am I missing something?
>>>>=20
>>>> Yeah, it'll be ~2 bytes in general, not 1, so closer to 2500 bytes.  I=
 this is still
>>>> enough to get us under 4K of metadata if we make pg_stat_t encoding
>>>> space-efficient (and possibly even without out).
>>=20
>> Repeating this test with random IO gives onodes that are more like 6-7k,=
 I
>> think just because there are too many significant bits in the blob id.
>>=20
>> So, I think we can scratch options #1 and #2 off the list.
>=20
> hrmf. I was still holding out hope #2 would be good enough.  Oh well.  I =
still remain very concerned about CPU usage, but we'll see where we are at =
once the dust settles.
>=20
> Mark
>=20
>>=20
>>>>>> 3) join lextents and blobs (Allen's proposal) and dynamically bin
>>>>>> based on the encoded size.
>>>>>>=20
>>>>>> 4) #3, but let shard_size=3D0 in onode (or whatever) put it inline
>>>>>> with onode, so that simple objects avoid any additional kv op.
>>>>>=20
>>>>> Yes, I'm still of the mind that this is the best approach. I'm not
>>>>> sure it's really that hard because most of the "special" cases can be
>>>>> dealt with in a common brute-force way (because they don't happen too
>>>> often).
>>>>=20
>>>> Yep.  I think my next task is to code this one up.  Before I start, th=
ough, I want
>>>> to make sure I'm doing the most reasonable thing.  Please
>>>> review:
>>>>=20
>>>> Right now the blobwise branch has (unshared and) shared blobs in their=
 own
>>>> key.  Shared blobs only update when they are occluded and their ref_ma=
p
>>>> changes.  If it weren't for that, we could go back to cramming them to=
gether
>>>> in a single bnode key, but I'm I think we'll do better with them as se=
parate
>>>> blob keys.  This helps small reads (we don't load all blobs), hurts la=
rge reads
>>>> (we read them all from separate keys instead of all at once), and of c=
ourse
>>>> helps writes because we only update a single small blob record.
>>>>=20
>>>> The onode will get a extent_map_shard_size, which is measured in bytes
>>>> and tells us how the map is chunked into keys.  If it's 0, the whole m=
ap will
>>>> stay inline in the onode.  Otherwise, [0..extent_map_shard_size) is in=
 the
>>>> first key, [extent_map_shard_size, extent_map_shard_size*2) is in the
>>>> second, etc.
>>>=20
>>> I've been thinking about this. I definitely like the '0' case where the=
 lextent and potentially the local blob are inline with the oNode. That'll =
certainly accelerate lots of Object and CephFS stuff. All options should im=
plement this.
>>>=20
>>> I've been thinking about the lextent sharding/binning/paging problem. M=
entally, I see two different ways to do it:
>>>=20
>>> (1) offset-based fixed binning -- I think this is what you described, i=
.e., the lextent table is recast into fixed offset ranges.
>>> (2) Dynamic binning. In this case, the ranges of lextent that are store=
d as a set of ranges (interval-set) each entry in the interval set represen=
ts a KV key and contains some arbitrary number of lextent entries within (b=
oundaries are a dynamic decision)
>>>=20
>>> The downside of (1) is that you're going to have logical extents that c=
ross the fixed bins (and sometimes MULTIPLE fixed bins). Handling this is j=
ust plain ugly in the code -- all sorts of special cases crop up for things=
 like local-blobs that used to be unshared, now are sorta-shared (between t=
he two 'split' lextent entries). Then there are the cases where single lext=
ents cross 2, 3, 10 shards.... UGLY UGLY UGLY.
>>>=20
>>> A secondary problem (quite possibly a non-problem) is that the sizes of=
 the chunks of encoded lextent don't necessarily divide up particularly eve=
nly. Hot spots in objects will cause this problem.
>>>=20
>>> Method (2) sounds more complicated, but I actually think it's dramatica=
lly LESS complicated to implement -- because we're going to brute force our=
 way around a lot of problem. First off, none of the ugly issues of splitti=
ng an lextent crop up -- by definition -- since we're chunking the map on w=
hole lextent boundaries. I think from an implementation perspective you can=
 break this down into some relatively simple logic.
>>>=20
>>> Basically from an implementation perspective, at the start of the opera=
tion (read or write), you compare the incoming offset with the interval-set=
 in the oNode and page in the portions of the lextent table that are requir=
ed (required=3D> for uncompressed is just the range in the incoming operati=
on, for compressed I think you need to have the lextent before and after th=
e incoming operation range to make the "depth limiting" code work correctly=
).
>>> For a read, you're always done at this point in time.
>>> For a write, you'll have the problem of updating the lextent table with=
 whatever changes have been made. There are basically two sub-cases for the=
 update:
>>> (a) updated lextent chunk (or chunks!) are sufficiently similar that yo=
u want to maintain the current "chunking" values (more on this below). This=
 is the easy case, just reserialize the chunk (or chunks) of the lextent th=
at are changed (again, because of over-fetching in the compression case the=
 changed range might not =3D=3D the fetched range)
>>> (b) You decide that re-chunking is required.  There are lots of cases o=
f splits and joins of chunks -- more ugly code. However because the worst-c=
ase size of the lextent isn't really THAT large (and the frequency of re-ch=
unking should be relatively low).  My recommendation is that we ONLY implem=
ent the complete re-chunking case. In other words, if you look at the chunk=
ing and you don't like it -- rather than spending time figuring out a bunch=
 of splits and joins (sorta reminds me of FIleStore directory splits) just =
read in the remainder of the lextent into memory and re-chunk the entire da=
rn thing. As long as the frequency of this is low it should be cheap enough=
 (a max-size lextent table isn't THAT big). Keeping the frequency of chunki=
ng low should be doable by a policy with some hysteresis, i.e., something l=
ike if a chunk is > 'N' bytes do a splitting-rechunk, but only if it's smal=
ler than N/2 bytes do a joining-rechunk.... Something like that...
>>>=20
>>> Nothing in the odisk structures prevents future code from implementing =
a more sophisticated split/join chunking scheme. In fact, I recommend that =
the oNode interval_set of the lextent chunks be decorated with the serializ=
ed sizes of each chunk so as to make that future algorithm much easier to i=
mplement (since it'll know the sizes of all of the serialized chunks). In o=
ther words, when it comes time to update the oNode/lextent, do the lextent =
chunks FIRST and use the generated sizes of the serialized lextents to put =
into the chunking table in the oNode. Have the sizes of all of the chunks a=
vailable (without having to consult the KV store) will make the policy deci=
sion about when to re-chunk fairly easy to do and allow the future optimize=
r to make more intelligent decisions about balancing the chunk-boundaries -=
- the extra data is pretty small and likely worth it (IMO).
>>>=20
>>> I strongly believe that (2) is the way to go.
>>=20
>> Yep, agreed!
>>=20
>>>> In memory, we can pull this out of the onode_t struct and manage it in
>>>> Onode where we can keep track of which parts of loaded, dirty, etc.
>>>>=20
>>>> For each map chunk, we can do the inline blob trick.  Unfortunately we=
 can
>>>> only do this for 'unshared' blobs where shared is now shared across
>>>> extent_map shards and not across objects.  We can conservatively estim=
ate
>>>> this by just looking at the blob size w/o looking at other lextents, a=
t least.
>>>=20
>>> Some thoughts here. In the PMR and Flash world, isn't it the case that =
blobs are essentially immutable once they are global?
>>>=20
>>> (In the SMR world, I know they'll be modified in order to "relocate" a =
chunk -- possibly invalidating the immutable assumption).
>>>=20
>>> Why NOT pull the blob up into the lextent -- as a copy? If it's immutab=
le, what's the harm? Yes, the stored metadata now expands by the reference =
count of a cloned blob, but if you can eliminate an extra KV fetch, I'm of =
the opinion that this seems like a desireable time/space tradeoff.... Just =
a thought :)
>>>=20
>>> BTW, here's potentially a really important thing that I just realized..=
.. For a global blob, you want to make the blob_id something like #HashID.#=
LBA, that way when you're trying to do the SMR backpointer thing, you can m=
inimize the number of bNodes you search for to find this LBA address (somet=
hing like that :)) -- naturally this fails for blobs with multiple pextents=
 -- But we can outlaw this case in the SMR world (space is basically ALWAYS=
 sequential in the SMR world :)).
>>=20
>> Hrm.  This is frustrating.  Being able to do *blob* backpointers and onl=
y
>> update blobs for SMR compaction is really appealing, but that means a fl=
ag
>> that prevents blob inline-copying on SMR.  This makes me nervous because
>> there will be yet another permutation in the mix: fully inline blob,
>> external with inline copy (use external one if updating ref_map), and
>> fully external.
>>=20
>> And if we do the inline copy, there isn't actually any purpose to most o=
f
>> the external copy except the ref_map.
>>=20
>> OTOH, with currently workloads at least we expect that cloned/shared blo=
bs
>> will be pretty rare, so perhaps we should ignore this and keep object ha=
sh
>> (not blob) backpointers for SMR.
>>=20
>> In that case, we should focus instead on sharing the ref_map *only* and
>> always inline the forward pointers for the blob.  This is closer to what
>> we were originally doing with the enode.  In fact, we could go back to t=
he
>> enode approach were it's just a big extent_ref_map and only used to defe=
r
>> deallocations until all refs are retired.  The blob is then more ephemer=
al
>> (local to the onode, immutable copy if cloned), and we can more easily
>> rejigger how we store it.
>>=20
>> We'd still have a "ref map" type structure for the blob, but it would on=
ly
>> be used for counting the lextents that reference it, and we can
>> dynamically build it when we load the extent map.  If we impose the
>> restriction that whatever the map sharding approach we take we never sha=
re
>> a blob across a shard, we the blobs are always local and "ephemeral"
>> in the sense we've been talking about.  The only downside here, I think,
>> is that the write path needs to be smart enough to not create any new bl=
ob
>> that spans whatever the current map sharding is (or, alternatively,
>> trigger a resharding if it does so).
>>=20
>>=20
>> Anyway, the main practical item that has me grumbling about this
>> is that having extent_map in the onode_t means we have lots of helpers
>> nad associated unit tests in test_bluestore_types.cc and making the
>> extent map into a more dynamic structure (with pointers instead of ids
>> etc) pulls it up a level above _types.{cc,h} and makes unit tests harder
>> to write.  OTOH, the more complex structure probably needs its own tests
>> to ensure we do the paging properly anyway, so here goes...
>>=20
>> sage
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>=20
