From: Mark Nelson <mnelson@redhat.com>
Subject: Re: bluestore onode diet and encoding overhead
Date: Tue, 12 Jul 2016 17:04:22 -0500
Message-ID: <5770bbd1-8c37-0ff2-4273-80b7434d4368@redhat.com>
References: <9b80fe95-9da5-bffe-c869-a7ba51da70b3@redhat.com>
 <BLUPR0201MB1524775973993917A1A59078E8300@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <47766d61-03f4-b55b-6d08-c090747c54b6@redhat.com>
 <BLUPR0201MB1524ACA8B78AA0859619A8F8E8300@BLUPR0201MB1524.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49846 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752048AbcGLWE6 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 12 Jul 2016 18:04:58 -0400
In-Reply-To: <BLUPR0201MB1524ACA8B78AA0859619A8F8E8300@BLUPR0201MB1524.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Allen Samuels <Allen.Samuels@sandisk.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 07/12/2016 04:15 PM, Allen Samuels wrote:
> Great papers!

Both are backed by open source code on github, which was some of my=20
motivation for looking at them.  The SIMD encoding paper only deals wit=
h=20
32bit ints afaik, but Cap'n Protocol looks pretty robust/convenient out=
=20
of the box.

>
> Your profiling pretty much shows that the problem is really the buffe=
r::list stuff and not the encoding itself (at least not yet!)
>
> Yes, it's relatively each to fix the buffer encoding. You just have t=
o over-allocate (do a worst-case computation for the data), and then do=
 the encoding into the over-allocated chunk and then free up the unused=
 portion.
>
>
> Allen Samuels
> SanDisk |a Western Digital brand
> 2880 Junction Avenue, San Jose, CA 95134
> T: +1 408 801 7030| M: +1 408 780 6416
> allen.samuels@SanDisk.com
>
>
>> -----Original Message-----
>> From: Mark Nelson [mailto:mnelson@redhat.com]
>> Sent: Tuesday, July 12, 2016 8:38 AM
>> To: Allen Samuels <Allen.Samuels@sandisk.com>; ceph-devel <ceph-
>> devel@vger.kernel.org>
>> Subject: Re: bluestore onode diet and encoding overhead
>>
>>
>>
>> On 07/12/2016 10:20 AM, Allen Samuels wrote:
>>> Good analysis.
>>>
>>> My original comments about putting the oNode on a diet included the=
 idea
>> of a "custom" encode/decode path for certain high-usage cases. At th=
e time,
>> Sage resisted going down that path hoping that a more optimized gene=
ric
>> case would get the job done. Your analysis shows that while we've ac=
hieved
>> significant space reduction this has come at the expense of CPU time=
 -- which
>> dominates small object performance (I suspect that eventually we'd d=
iscover
>> that the variable length decode path would be responsible for a subs=
tantial
>> read performance degradation also -- which may or may not be part of=
 the
>> read performance drop-off that you're seeing). This isn't a surprisi=
ng result,
>> though it is unfortunate.
>>>
>>> I believe we need to revisit the idea of custom encode/decode paths=
 for
>> high-usage cases, only now the gains need to be focused on CPU utili=
zation
>> as well as space efficiency.
>>
>> I'm not against it, but it might be worth at least a quick attempt a=
t
>> preallocating the append_buffer and/or Piotr's idea to directly memc=
py
>> without doing the append at all.  It may be that helps quite a bit (=
though
>> perhaps it's not enough in the long run).
>>
>> A couple of other thoughts:
>>
>> I still think SIMD encode approaches are interesting if we can lay d=
ata out in
>> memory in a friendly way (This feels like it might be painful
>> though):
>>
>> http://arxiv.org/abs/1209.2137
>>
>> But on the other hand, Kenton Varda who was previously a primary aut=
hor
>> on google's protocol buffers ended up doing something a little diffe=
rent than
>> varint:
>>
>> https://capnproto.org/encoding.html
>>
>> Look specifically at the packing section.  It looks somewhat attract=
ive to me.
>>
>> Mark
>>
>>>
>>> I believe this activity can also address some of the memory consump=
tion
>> issues that we're seeing now. I believe that the current lextent/blo=
b/pextent
>> usage of standard STL maps is both space and time inefficient -- in =
a place
>> where it matters a lot. Sage has already discussed usage of somethin=
g like
>> flat_map from the boost library as a way to reduce the memory overhe=
ad,
>> etc. I believe this is the right direction.
>>>
>>> Where are we on getting boost into our build?
>>>
>>> Allen Samuels
>>> SanDisk |a Western Digital brand
>>> 2880 Junction Avenue, Milpitas, CA 95134
>>> T: +1 408 801 7030| M: +1 408 780 6416 allen.samuels@SanDisk.com
>>>
>>>
>>>> -----Original Message-----
>>>> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
>>>> owner@vger.kernel.org] On Behalf Of Mark Nelson
>>>> Sent: Tuesday, July 12, 2016 12:03 AM
>>>> To: ceph-devel <ceph-devel@vger.kernel.org>
>>>> Subject: bluestore onode diet and encoding overhead
>>>>
>>>> Hi All,
>>>>
>>>> With Igor's patch last week I was able to get some bluestore perfo=
rmance
>>>> runs in without segfaulting and started looking int the results.
>>>> Somewhere along the line we really screwed up read performance, bu=
t
>>>> that's another topic.  Right now I want to focus on random writes.
>>>> Before we put the onode on a diet we were seeing massive amounts o=
f
>> read
>>>> traffic in RocksDB during compaction that caused write stalls duri=
ng 4K
>>>> random writes.  Random write performance on fast hardware like NVM=
e
>>>> devices was often below filestore at anything other than very larg=
e IO
>> sizes.
>>>> This was largely due to the size of the onode compounded with Rock=
sDB's
>>>> tendency toward read and write amplification.
>>>>
>>>> The new test results look very promising.  We've dramatically impr=
oved
>>>> performance of random writes at most IO sizes, so that they are no=
w
>>>> typically quite a bit higher than both filestore and older bluesto=
re code.
>>>> Unfortunately for very small IO sizes performance hasn't improved =
much.
>>>> We are no longer seeing huge amounts of RocksDB read traffic and f=
ewer
>>>> write stalls.  We are however seeing huge memory usage (~9GB RSS p=
er
>>>> OSD) and very high CPU usage.  I think this confirms some of the m=
emory
>>>> issues somnath was continuing to see.  I don't think it's a leak e=
xactly
>> based
>>>> on how the OSDs were behaving, but we need to run through massif s=
till
>> to
>>>> be sure.
>>>>
>>>> I ended up spending some time tonight with perf and digging throug=
h the
>>>> encode code.  I wrote up some notes with graphs and code snippets =
and
>>>> decided to put them up on the web.  Basically some of the encoding
>> changes
>>>> we implemented last month to reduce the onode size also appear to
>> result in
>>>> more buffer::list appends and the associated overhead.
>>>> I've been trying to think through ways to improve the situation an=
d
>> thought
>>>> other people might have some ideas too.  Here's a link to the shor=
t
>> writeup:
>>>>
>>>>
>> https://drive.google.com/file/d/0B2gTBZrkrnpZeC04eklmM2I4Wkk/view?us
>>>> p=3Dsharing
>>>>
>>>> Thanks,
>>>> Mark
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el" in
>> the
>>>> body of a message to majordomo@vger.kernel.org More majordomo info
>> at
>>>> http://vger.kernel.org/majordomo-info.html
> N=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDr=EF=BF=BD=EF=BF=BDy=EF=
=BF=BD=EF=BF=BD=EF=BF=BDb=EF=BF=BDX=EF=BF=BD=EF=BF=BD=C7=A7v=EF=BF=BD^=EF=
=BF=BD)=DE=BA{.n=EF=BF=BD+=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD]z=EF=BF=
=BD=EF=BF=BD=EF=BF=BD{ay=EF=BF=BD=1D=CA=87=DA=99=EF=BF=BD,j=07=EF=BF=BD=
=EF=BF=BDf=EF=BF=BD=EF=BF=BD=EF=BF=BDh=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=
=BD=1E=EF=BF=BDw=EF=BF=BD=EF=BF=BD=EF=BF=BD=0C=EF=BF=BD=EF=BF=BD=EF=BF=BD=
j:+v=EF=BF=BD=EF=BF=BD=EF=BF=BDw=EF=BF=BDj=EF=BF=BDm=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=07=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDzZ+=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=DD=A2j"=EF=BF=BD=EF=BF=BD!tml=3D
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
