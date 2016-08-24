From: Allen Samuels <Allen.Samuels@sandisk.com>
Subject: Re: bluestore blobs REVISITED
Date: Wed, 24 Aug 2016 23:41:30 +0000
Message-ID: <C219E248-DD41-431A-A895-60F3810AF9D7@sandisk.com>
References: <BLUPR0201MB15245F1EA4B70EF5761981AFE8170@BLUPR0201MB1524.namprd02.prod.outlook.com>
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
 <alpine.DEB.2.11.1608241759180.25678@piezo.us.to>
 <35D6E177-5070-4853-8CF4-FBDA14B08CAD@sandisk.com>,<alpine.DEB.2.11.1608242113300.25681@piezo.us.to>
 <67930A6B-070C-4C81-92D8-351AE28D5890@sandisk.com>,<alpine.DEB.2.11.1608242228270.25681@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-dm3nam03on0057.outbound.protection.outlook.com ([104.47.41.57]:29825
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1757476AbcHYFRv (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 25 Aug 2016 01:17:51 -0400
In-Reply-To: <alpine.DEB.2.11.1608242228270.25681@piezo.us.to>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "jdurgin@redhat.com" <jdurgin@redhat.com>, "dillaman@redhat.com" <dillaman@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Your suggesting a logical address cache key (oid offset) rather rhan a phys=
ical cache (lba). Which seems fine to me. Provided that deletes and renames=
 properly purge the cache.=20

Sent from my iPhone. Please excuse all typos and autocorrects.

> On Aug 24, 2016, at 6:29 PM, Sage Weil <sweil@redhat.com> wrote:
>=20
>> On Wed, 24 Aug 2016, Allen Samuels wrote:
>> Yikes. You mean that blob ids are escaping the environment of the=20
>> lextent table. That's scary. What is the key for this cache? We probably=
=20
>> need to invalidate it or something.
>=20
> I mean that there will no longer be blob ids (except within the encoding=
=20
> of a particular extent map shard).  Which means that when you write to A,=
=20
> clone A->B, and then read B, B's blob will no longer be the same as A's=20
> blob (as it is now in the bnode, or would have been with the -blobwise=20
> branch) and the cache won't be preserved.
>=20
> Which I *think* is okay...?
>=20
> sage
>=20
>=20
>>=20
>> Sent from my iPhone. Please excuse all typos and autocorrects.
>>=20
>>> On Aug 24, 2016, at 5:18 PM, Sage Weil <sweil@redhat.com> wrote:
>>>=20
>>> On Wed, 24 Aug 2016, Allen Samuels wrote:
>>>>> In that case, we should focus instead on sharing the ref_map *only* a=
nd=20
>>>>> always inline the forward pointers for the blob.  This is closer to w=
hat=20
>>>>> we were originally doing with the enode.  In fact, we could go back t=
o the=20
>>>>> enode approach were it's just a big extent_ref_map and only used to d=
efer=20
>>>>> deallocations until all refs are retired.  The blob is then more ephe=
meral=20
>>>>> (local to the onode, immutable copy if cloned), and we can more easil=
y=20
>>>>> rejigger how we store it.
>>>>>=20
>>>>> We'd still have a "ref map" type structure for the blob, but it would=
 only=20
>>>>> be used for counting the lextents that reference it, and we can=20
>>>>> dynamically build it when we load the extent map.  If we impose the=20
>>>>> restriction that whatever the map sharding approach we take we never =
share=20
>>>>> a blob across a shard, we the blobs are always local and "ephemeral"=
=20
>>>>> in the sense we've been talking about.  The only downside here, I thi=
nk,=20
>>>>> is that the write path needs to be smart enough to not create any new=
 blob=20
>>>>> that spans whatever the current map sharding is (or, alternatively,=20
>>>>> trigger a resharding if it does so).
>>>>=20
>>>> Not just a resharding but also a possible decompress recompress cycle.
>>>=20
>>> Yeah.
>>>=20
>>> Oh, the other consequence of this is that we lose the unified blob-wise=
=20
>>> cache behavior we added a while back.  That means that if you write a=20
>>> bunch of data to a rbd data object, then clone it, then read of the clo=
ne,=20
>>> it'll re-read the data from disk.  Because it'll be a different blob in=
=20
>>> memory (since we'll be making a copy of the metadata etc).
>>>=20
>>> Josh, Jason, do you have a sense of whether that really matters?  The=20
>>> common case is probably someone who creates a snapshot and then backs i=
t=20
>>> up, but it's going to be reading gobs of cold data off disk anyway so I=
'm=20
>>> guessing it doesn't matter that a bit of warm data that just preceded t=
he=20
>>> snapshot gets re-read.
>>>=20
>>> sage
>>=20
>>=20
