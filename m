From: Samuel Just <sjust@redhat.com>
Subject: Re: Notes from a discussion a design to allow EC overwrites
Date: Mon, 14 Dec 2015 13:19:43 -0800
Message-ID: <CAN=+7FVPHpiC262yPQ++6RoBu8UPsWCRhVWRXVzUeV6_JfHgaw@mail.gmail.com>
References: <CAN=+7FUAd-Cc0=1yCekY1QjQ2DJR7WYLLv2OhR_0H5qo5DNgkQ@mail.gmail.com>
	<alpine.DEB.2.00.1511130524120.7964@cobra.newdream.net>
	<CAN=+7FV5zcZWRun3pxkL-z6uNp1-KPCYu=Ug6jOHfXoYjA1dbA@mail.gmail.com>
	<CY1PR0201MB18974D8FD3E5D6714411AF91E8110@CY1PR0201MB1897.namprd02.prod.outlook.com>
	<CAEv+sP5DZ6HrT5mp8PtJeMi2x7VOQh10zQhq8JGCUcN_k0p3hw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f173.google.com ([209.85.223.173]:35147 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932385AbbLNVTo convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Dec 2015 16:19:44 -0500
Received: by iofq126 with SMTP id q126so48968183iof.2
        for <ceph-devel@vger.kernel.org>; Mon, 14 Dec 2015 13:19:44 -0800 (PST)
In-Reply-To: <CAEv+sP5DZ6HrT5mp8PtJeMi2x7VOQh10zQhq8JGCUcN_k0p3hw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tianshan Qu <qutianshan@gmail.com>
Cc: Allen Samuels <Allen.Samuels@sandisk.com>, Sage Weil <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "Durgin, Josh" <jdurgin@redhat.com>, "Farnum, Gregory" <gfarnum@redhat.com>

I created a set of tickets for what I think needs to happen:
http://tracker.ceph.com/issues/14031.  There's a doc linked from that
ticket with more details on the design.
-Sam

On Fri, Nov 13, 2015 at 10:26 AM, Tianshan Qu <qutianshan@gmail.com> wr=
ote:
> Hi:
>
> sorry for half send.
>
> I'm working on this recently. I think we should distinguish the scene
> of sequence write and small write.
>
> The first, overwrite is enough. The second small write's typical
> optimal is a log based write, which do not need ec's reconstruct and
> avoid parity chunk's extra read.
>
> Fast14 paper (Parity Logging with Reserved Space Towards Ef=EF=AC=81c=
ient
> Updates and Recovery in Erasure-coded Clustered Storage)  propose a
> way to further improve the performance, which use pre allocate reserv=
e
> space after parity chunk to avoid fragmentation.
>
> I think the challenge to implement this in ceph is how to manager the
> reserve space, since we may have no direct support.
>
> also, the kv is another good choice for the log.
>
> For the ec interface, I think we need extra function to apply parity =
change.
>
>
>
> 2015-11-14 0:16 GMT+08:00 Allen Samuels <Allen.Samuels@sandisk.com>:
>> This scheme fundamentally relies on the temporary objects "gracefull=
y" transitioning into being portions of full-up long-term durable objec=
ts.
>>
>> This means that if the allocation size for a temporary object signif=
icantly mismatches the size of the mutation (partial stripe write) you'=
re creating a problem that's proportional to the mismatch size.
>>
>> So either, NewStore is able to efficiently allocate small chunks
>> OR
>> You have some kind of background cleanup process that reclaims that =
space (i.e., a "straightener")
>>
>> The right choices depend on having a shared notion of the operationa=
l profile that you're trying to optimize for.
>>
>> The fundamental question becomes, are you going to optimize for smal=
l-block random writes?
>>
>> In my experience this is a key use-case in virtually every customer'=
s evaluation scenario. I believe we MUST make this case reasonably effi=
cient.
>>
>> It seems to me that the lowest-complexity "fix" for the problem is t=
o teach NewStore to have two different allocation sizes (big and small =
:)).
>> Naturally the allocator becomes more complex. Worst case, you're now=
 left with the garbage collection problem. Which I suspect could be pun=
ted to a subsequent release (i.e., I'm out of large blocks, but there's=
 plenty of fragmented available space -- This can happen, but's a prett=
y pathological case which becomes rare-er and rare-er as you scale-out)
>>
>> Allen Samuels
>> Software Architect, Emerging Storage Solutions
>>
>> 2880 Junction Avenue, Milpitas, CA 95134
>> T: +1 408 801 7030| M: +1 408 780 6416
>> allen.samuels@SanDisk.com
>>
>>
>> -----Original Message-----
>> From: Samuel Just [mailto:sjust@redhat.com]
>> Sent: Friday, November 13, 2015 7:39 AM
>> To: Sage Weil <sweil@redhat.com>
>> Cc: ceph-devel@vger.kernel.org; Allen Samuels <Allen.Samuels@sandisk=
=2Ecom>; Durgin, Josh <jdurgin@redhat.com>; Farnum, Gregory <gfarnum@re=
dhat.com>
>> Subject: Re: Notes from a discussion a design to allow EC overwrites
>>
>> Lazily persisting the intermediate entries would certainly also work=
, but there's an argument that it needlessly adds to the write transact=
ion.
>>
>> Actually, we probably want to avoid having small writes be full stri=
pe writes -- with a 8+3 code the difference between modifying a single =
stripelet and modifying the full stripe is 4 writes vs 11 writes.
>>
>> It means that during peering, any log we can find (particularly the =
shortest one) from the most recent active interval isn't an upper bound=
 on writes committed to the client (the (actingset.size() - M - 1)th on=
e is?) -- we'd have to think carefully about the implications of that.
>> -Sam
>>
>> On Fri, Nov 13, 2015 at 5:35 AM, Sage Weil <sweil@redhat.com> wrote:
>>> On Thu, 12 Nov 2015, Samuel Just wrote:
>>>> I was present for a discussion about allowing EC overwrites and
>>>> thought it would be good to summarize it for the list:
>>>>
>>>> Commit Protocol:
>>>> 1) client sends write to primary
>>>> 2) primary reads in partial stripes needed for partial stripe
>>>> overwrites from replicas
>>>> 3) primary sends prepares to participating replicas and queues its
>>>> own prepare locally
>>>> 4) once all prepares are complete, primary sends a commit to the
>>>> client
>>>> 5) primary sends applies to all participating replicas
>>>>
>>>> When we get the prepare, we write out a temp object with the data =
to
>>>> be written.  On apply, we use an objectstore primitive to atomical=
ly
>>>> move those extents into the actual object.  The log entry contains
>>>> the name/id for the temp object so it can be applied on apply or r=
emoved on rollback.
>>>
>>> Currently we assume that temp objects are/can be cleared out on res=
tart.
>>> This will need to change.  And we'll need to be careful that they g=
et
>>> cleaned out when peering completes (and the rollforward/rollback
>>> decision is made.
>>>
>>> If the stripes are small, then the objectstore primitive may not
>>> actually be that efficient.  I'd suggest also hinting that the temp
>>> object will be swapped later, so that the backend can, if it's smal=
l,
>>> store it in a cheap temporary location in the expectation that it w=
ill get rewritten later.
>>> (In particular, the newstore allocation chunk is currently targetti=
ng
>>> 512kb, and this will only be efficient with narrow stripes, so it'l=
l
>>> just get double-written.  We'll want to keep the temp value in the =
kv
>>> store [log, hopefully] and not bother to allocate disk and rewrite
>>> it.)
>>>
>>>> Each log entry contains a list of the shard ids modified.  During
>>>> peering, we use the same protocol for choosing the authoritative l=
og
>>>> for the existing EC pool, except that we first take the longest
>>>> candidate log and use it to extend shorter logs until they hit an =
entry they should have witnessed, but didn't.
>>>>
>>>> Implicit in the above scheme is the fact that if an object is
>>>> written, but a particular shard isn't changed, the osd with that
>>>> shard will have a copy of the object with the correct data, but an
>>>> out of date object_into (notably, the version will be old).  To av=
oid
>>>> this messing up the missing set during the log scan on OSD start,
>>>> we'll skip log entries we wouldn't have participated in (we may no=
t
>>>> even choose to store them, see below).  This does generally pose a
>>>> challenge for maintaining prior_version.  It seems like it shouldn=
't
>>>> be much of a problem since rollbacks can only happen on prepared l=
og
>>>> entries which haven't been applied, so log merging can never resul=
t in a divergent entry causing a missing object.  I think we can get by=
 without it then?
>>>>
>>>> We can go further with the above and actually never persist a log
>>>> entry on a shard which it did not participate in.  As long as peer=
ing
>>>> works correctly, the union of the logs we got must have all entrie=
s.
>>>> The primary will need to keep a complete copy in memory to manage =
dup op detection and recovery, however.
>>>
>>> That sounds more complex to me.  Maybe instead we could lazily pers=
ist
>>> the entries (on the next pg write) so that it is always a contiguou=
s sequence?
>>>
>>>> 2) above can also be done much more efficiently.  Some codes will
>>>> allow the parity chunks to be reconstructed more efficiently, so s=
ome
>>>> thought will have to go into restructuring the plugin interface to
>>>> allow more efficient
>>>
>>> Hopefully the stripe size is chosen such that most writes will end =
up
>>> being full stripe writes (we should figure out if the EC performanc=
e
>>> degrades significantly in that case?).
>>>
>>> An alternative would be to do something like
>>>
>>> 1) client sends write to primary
>>> 2) primary sends prepare to the first M+1 shards, who write it in a
>>> temporary object/location
>>> 3) primary acks write once they ack
>>> 4) asynchronously, primary recalculates the affected stripes and se=
nds
>>> an overwrite.
>>>
>>>  - step 4 doesn't need to be 2-phase, since we have the original da=
ta
>>> persisted already on >M shards
>>>  - the client-observed latency is bounded by only M+1 OSDs (not
>>> acting.size())
>>>
>>> I suspect you discussed this option, though, and have other concern=
s
>>> around its complexity?
>>>
>>> sage
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
