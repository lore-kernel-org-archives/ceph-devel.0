From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: BlueStore Performance issue
Date: Thu, 10 Mar 2016 10:08:53 -0800
Message-ID: <CAJ4mKGY2XkRa_8hQsR03o+M8zO1-fZXfA5FTPRRV=043T+28Hg@mail.gmail.com>
References: <CY1PR0201MB189788B82C09E5D1DF7BDEE2E8B30@CY1PR0201MB1897.namprd02.prod.outlook.com>
	<alpine.DEB.2.11.1603090842140.14377@cpach.fuggernut.com>
	<CY1PR0201MB1897981F391262D2CFEF7D06E8B30@CY1PR0201MB1897.namprd02.prod.outlook.com>
	<alpine.DEB.2.11.1603091033200.14377@cpach.fuggernut.com>
	<CY1PR0201MB18972EAD3EAAC4CDC3BDC602E8B40@CY1PR0201MB1897.namprd02.prod.outlook.com>
	<alpine.DEB.2.11.1603100839170.14377@cpach.fuggernut.com>
	<CY1PR0201MB1897D0D0D818B598F0EA85A6E8B40@CY1PR0201MB1897.namprd02.prod.outlook.com>
	<alpine.DEB.2.11.1603101110071.14377@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f51.google.com ([209.85.213.51]:32921 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752455AbcCJSIy convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 Mar 2016 13:08:54 -0500
Received: by mail-vk0-f51.google.com with SMTP id k1so105626395vkb.0
        for <ceph-devel@vger.kernel.org>; Thu, 10 Mar 2016 10:08:53 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1603101110071.14377@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Allen Samuels <Allen.Samuels@sandisk.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Mar 10, 2016 at 8:12 AM, Sage Weil <sweil@redhat.com> wrote:
> On Thu, 10 Mar 2016, Allen Samuels wrote:
>> > > Another important benefit of this is that the WAL code need only=
 kick
>> > > in for operations that are less than 4K rather than the current =
64K.
>> > > This is a big reduction in write-amplification for these operati=
ons
>> > > which should translate directly into improved throughput, especi=
ally
>> > > for such benchmark critical areas as random 4K writes...
>> > >
>> > > While not terribly useful on hybrid or HDD systems, the bitmap b=
ased
>> > > code has MUCH shorter CPU paths than does the current code. On a=
n all
>> > > flash OSD system this will directly translate into more performa=
nce
>> > > (quantity unknown of course).
>> > >
>> > > While the memory consumption reduction is nice, for me the signi=
ficant
>> > > performance improvement implied by virtual elimination of WAL is=
 the
>> > > compelling factor.
>> >
>> > I wouldn't conflate the allcoation size and freelist representatio=
n; we get the
>> > same avoidance of the WAL path with the current code by changing
>> > min_alloc_size to 4k.  Making the freelist represntation more effi=
cient is
>> > important for small block sizes, but *any* memory-efficient strate=
gy is fine
>> > (and even the current one is probably fine for most workloads).  F=
or
>> > example, we could keep an extent-based representation and page in =
regions
>> > instead...
>>
>> Perhaps I inartfully made my point. I just wanted to say that if you=
 set
>> min_alloc_size to 4K you avoid the WAL stuff but you spend more memo=
ry,
>> in the worst case the memory consumption would be 16 * 320MB =3D> 5G=
B per
>> TB of storage. While I agree that the true worst-case pattern requir=
es a
>> pathological use-case, I am concerned that normal use-cases will sti=
ll
>> consume unreasonably large amounts of memory -- leading to unreliabl=
e
>> systems.
>>
>> I believe that we simply don't want to be using that much memory for
>> this part of the system. There are other tradeoffs (time, complexity=
,
>> latency, etc.) that could significantly reduce memory consumption. L=
et's
>> explore these.
>
> Agreed.  :)
>
>> > The other thing to keep in mind is that the freelist is representa=
ted
>> > twice: once in memory in indexed form in StupidAllocator, and once=
 in
>> > FreelistManager just to ensure it's persisted properly.  In the se=
cond case, I
>> > suspect we could leverage a custom rocksdb merge operator to avoid=
 that
>> > representation entirely so that adjacent extents are coalesced whe=
n the sst
>> > is generated (when writing to l0 or during compaction).  I'm guess=
ing that
>> > functionality isn't present is ZS though?
>>
>> Not at present. But since I control the developers, that is somethin=
g
>> that could be added. Clearly it's possible to address the global
>> serialization of KV commits if a different mechanism was available f=
or
>> representing the allocation lists in the KV store. Having some kind =
of
>> merging primitive allows that to be done. I was going to raise exact=
ly
>> this issue yesterday, but tabled it. Let's continue this conversatio=
n.
>
> I haven't really done my homework with the existing rocksdb merge
> operators to confirm that they would work in this way.  In particular=
, I
> think we want them to merge adjacent keys together (at least if we st=
ick
> with the naive offset=3Dlength kv representation), and I'm afraid the=
y might
> be intended to merge values with matching keys.

Yes, that's definitely my recollection of how those operators work.
It's a merge when sstables get put together =E2=80=94 anything operatin=
g on
adjacent ranges would run into all kinds of problems across sstable
boundaries!
-Greg


> In any case, though, my
> hope would be that we'd settle on a single strategy that would work a=
cross
> both ZS and rocksdb as it'd simplify our life a bit.
>
> sage
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
