From: Allen Samuels <Allen.Samuels@sandisk.com>
Subject: Re: bluestore blobs REVISITED
Date: Wed, 24 Aug 2016 22:13:26 +0000
Message-ID: <67930A6B-070C-4C81-92D8-351AE28D5890@sandisk.com>
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
 <alpine.DEB.2.11.1608241759180.25678@piezo.us.to>
 <35D6E177-5070-4853-8CF4-FBDA14B08CAD@sandisk.com>,<alpine.DEB.2.11.1608242113300.25681@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-cys01nam02on0056.outbound.protection.outlook.com ([104.47.37.56]:31397
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753578AbcHXWuQ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 24 Aug 2016 18:50:16 -0400
In-Reply-To: <alpine.DEB.2.11.1608242113300.25681@piezo.us.to>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "jdurgin@redhat.com" <jdurgin@redhat.com>, "dillaman@redhat.com" <dillaman@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Yikes. You mean that blob ids are escaping the environment of the lextent t=
able. That's scary. What is the key for this cache? We probably need to inv=
alidate it or something.=20

Sent from my iPhone. Please excuse all typos and autocorrects.

> On Aug 24, 2016, at 5:18 PM, Sage Weil <sweil@redhat.com> wrote:
>=20
> On Wed, 24 Aug 2016, Allen Samuels wrote:
>>> In that case, we should focus instead on sharing the ref_map *only* and=
=20
>>> always inline the forward pointers for the blob.  This is closer to wha=
t=20
>>> we were originally doing with the enode.  In fact, we could go back to =
the=20
>>> enode approach were it's just a big extent_ref_map and only used to def=
er=20
>>> deallocations until all refs are retired.  The blob is then more epheme=
ral=20
>>> (local to the onode, immutable copy if cloned), and we can more easily=
=20
>>> rejigger how we store it.
>>>=20
>>> We'd still have a "ref map" type structure for the blob, but it would o=
nly=20
>>> be used for counting the lextents that reference it, and we can=20
>>> dynamically build it when we load the extent map.  If we impose the=20
>>> restriction that whatever the map sharding approach we take we never sh=
are=20
>>> a blob across a shard, we the blobs are always local and "ephemeral"=20
>>> in the sense we've been talking about.  The only downside here, I think=
,=20
>>> is that the write path needs to be smart enough to not create any new b=
lob=20
>>> that spans whatever the current map sharding is (or, alternatively,=20
>>> trigger a resharding if it does so).
>>=20
>> Not just a resharding but also a possible decompress recompress cycle.
>=20
> Yeah.
>=20
> Oh, the other consequence of this is that we lose the unified blob-wise=20
> cache behavior we added a while back.  That means that if you write a=20
> bunch of data to a rbd data object, then clone it, then read of the clone=
,=20
> it'll re-read the data from disk.  Because it'll be a different blob in=20
> memory (since we'll be making a copy of the metadata etc).
>=20
> Josh, Jason, do you have a sense of whether that really matters?  The=20
> common case is probably someone who creates a snapshot and then backs it=
=20
> up, but it's going to be reading gobs of cold data off disk anyway so I'm=
=20
> guessing it doesn't matter that a bit of warm data that just preceded the=
=20
> snapshot gets re-read.
>=20
> sage
>=20
