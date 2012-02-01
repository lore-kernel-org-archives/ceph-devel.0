From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: efficient removal of old objects
Date: Wed, 1 Feb 2012 12:01:32 -0800
Message-ID: <CAC-hyiFQZ1+8dR9QvsJP505Gksov8ccMqT_ig3MLCPNZvKgL_g@mail.gmail.com>
References: <Pine.LNX.4.64.1201311549170.21770@cobra.newdream.net>
	<CAC-hyiG512de2h+R98g1POOy0Lw18A15TPwE=ge-OgjofdR8Wg@mail.gmail.com>
	<CAF3hT9DXMz6Ga-=FHz35KGMaj+bS8pA2bZky3mvo7xbEejxppQ@mail.gmail.com>
	<CAC-hyiFR6AXFTdb1majNg85sVfQ8NDyP6K+o1YBuEzGPszF24Q@mail.gmail.com>
	<CAF3hT9BZrUjnFGMK-5j4Qpgeu=kjFRcX2r=Jykowy+UQR0O=jQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:52882 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752960Ab2BAUBd convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Feb 2012 15:01:33 -0500
Received: by ghrr11 with SMTP id r11so798118ghr.19
        for <ceph-devel@vger.kernel.org>; Wed, 01 Feb 2012 12:01:32 -0800 (PST)
In-Reply-To: <CAF3hT9BZrUjnFGMK-5j4Qpgeu=kjFRcX2r=Jykowy+UQR0O=jQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: ceph-devel@vger.kernel.org, Sage Weil <sage@newdream.net>

On Wed, Feb 1, 2012 at 11:35 AM, Gregory Farnum
<gregory.farnum@dreamhost.com> wrote:
> On Wed, Feb 1, 2012 at 10:53 AM, Yehuda Sadeh Weinraub
> <yehudasa@gmail.com> wrote:
>> On Wed, Feb 1, 2012 at 9:39 AM, Gregory Farnum
>> <gregory.farnum@dreamhost.com> wrote:
>>> You are dramatically overstating the impact of latency on an
>>> inherently parallelizable and non-interactive operation. A couple d=
isk
>>> seeks *do not matter.*
>>
>> Do not matter to whom? It affects the overall osd performance, and
>> given enough threads going on in parallel doing the cleanup, it
>> *really* matters, and this is the basic issue.
> You can impact the random lookups based on how the intent log is
> actually designed, to the point that those lookups should not impact
> the OSDs noticeably (a few hundred requests per day to do once-a-day

I lost you here with that assessment. In any case you need to scale
the number of clients that do it with the number of your osds.


> cleanups). Once you have the information on who to delete, you are
> going to run the same sequence of operations; the only question is
> whether they originate on the client or on the OSD. Assuming a large
> load (as you are) and a not-trivial PG, the deletes are all going to
> have to go to disk to find the inodes anyway. So the vast majority of
> the load required for a client-side solution is identical to the load
> required for a scrub-based solution.
>
>>>> Note that setting expiration on an object is a more lightweight
>>>> operation than appending the intent log, as it would be done as a =
sub
>>>> op in the compound operation that created the object.
>>>
>>> ...you're going to set expirations on the objects when you write th=
em?
>>> What if the user's upload takes longer than you expect?
>>
>> You're a few months too late. Go back to the atomic get/put discussi=
on.
> I remember this discussion, but I thought we'd ended up setting
> intent-to-delete when we did the final clone into place?

In any case you expire the old cloned object, not the new one that is
being uploaded, so that only happens when the PUT was completed.

>
>>>>> I think there are a couple questions:
>>>>>
>>>>> Should this be generalized to saying "do these osd ops at time X"=
 instead
>>>>> of "delete at time X". =A0Then it could setxattr, remove, call in=
to a class,
>>>>> whatever.
>>>>
>>>> While I think it'd make a nice feature, I also think that the prob=
lem
>>>> space of a garbage collection is a bit different, and given the ti=
me
>>>> constraints it wouldn't make sense implementing this right now any=
way.
>>>
>>> This is client-side garbage collection, not RADOS garbage collectio=
n.
>>> Don't confuse those issues, either =97=A0the second is appropriate =
to put
>>
>> No. This is a garbage collection utility that RADOS can provide.
>
> Yes, it *can*, but that doesn't mean it *should*. Core OSD
> functionality should be stuff that's widely-used by many clients, and
> I can't think of any other client that's going to want time-based
> garbage collection of this sort. Every other scenario I can think of

Tell that to the Swift guys, or to Amazon.

> will just delete when they are done with the object, or else will wan=
t
> more sophisticated checks than the amount of elapsed time. Which is
> why I support the eventual addition of time-based class triggers, but
> not an interface tailored exclusively for radosgw.

See my previous comment.

>
>>>>> How would the OSD implement this? =A0A kludgey way would be to do=
 it during
>>>>> scrub. =A0The current scrub implementation may make that problema=
tic because
>>>>> it does a whole PG at time, and we probably don't want to issue a=
 whole
>>>>> PG's worth of deletes at a time. =A0Is there a way to make that l=
ess
>>>>> painful?
>>>>
>>>> If we need to lock the entire pg while removing the objects it wou=
ldn't work.
>>>
>>> That's how scrub works right now...
>>>
>>>> I'm not too familiar with the scrub code, and I don't want to dive
>>>> here into possible implementation details, but getting the scrub t=
o
>>>> generate a list of objects for removal may be possible.
>>>
>>> Sam and I tossed around a few ideas for how to do this, and it's no=
t
>>> impossible, but it was significantly more complicated than everybod=
y
>>> thinks it is at first glance. (You need to make sure that it doesn'=
t
>>> interact with recovery at all, which means it needs to go through t=
he
>>> normal request mechanism, which means you need to build up a queue =
of
>>> deletes while scrubbing and then dispatch it properly without
>>> disrupting client requests or running out of memory; you need to ma=
ke
>>> sure that scrubbing runs more reliably than it does right now...etc
>>> etc)
>>
>> I think you're overstating complexity. We're already disrupting clie=
nt
>> requests by running the cleanup externally. Leveraging scrub
>> throttling due to system load is a strength, not a weakness. If any,
>> using the intent log cleanup blindly is a real issue. Also, add to
>> that the fact that we leverage the fact that scrub runs over the
>> objects anyway and heats up the caches, the performance gain we'd ge=
t
>> is much bigger.
> I thought the whole reason this had suddenly become such an issue is
> because not cleaning up the intent log stuff has a performance impact
> on the cluster. Scrub *doesn't run* when the load is too high...which

That's an underlying filesystem (probably temporary) issue. I wouldn't
build my architecture on it.

> means that by leveraging scrub you will get into a circle of death
> where cleanup never occurs because the load is too high, which causes
> the load to continue increasing...
>
>>> The problem is that it changes the nature of scrub. Right now, scru=
b
>>> doesn't change anything at all; scrub repair sets the replicas to h=
ave
>>
>> It doesn't change anything with scrub's nature if it's only used to
>> generate the list of objects to remove (per pg).
>
> If your contention is that doing delayed work immediately following a
> scrub is a huge performance win, then we ought to be able to hang mor=
e

No. We don't ought to do that.

> than deletes off of scrub. Adding deletes now with the intention of
> expanding it later creates an interface and code maintenance nightmar=
e
> =97=A0we either maintain two parallel code tracks or else we have to
> convert old-style delete requests to new-style interface requests.
> Either way, eww! This is directly contrary to the work we're doing
> with message encoding et al to work towards more stable interfaces.

Sorry, lost you above.

>
>>> the same state as the primary. You want to add a client-controlled
>>> state mutation that is triggered as part of scrub, which *really*
>>> makes it different (and complicated)...or else it's a hack to have
>>> scrub trigger some weird sequences of requests (as I outlined above=
).
>>> Either way, it's a big change to scrub that smells hacky.
>>>
>>> The basic issue here is that the RGW stuff can all be done as
>>> client-side operations, and all you've demonstrated is that doing i=
t
>>> serially with a single client is slow (but not slower than the
>>> generation of the objects, which means that it does actually work).
>>> The correct response to that is not to add half-baked features to t=
he
>>> OSD; the correct response is to make your client behave well.
>>
>> The problem is not the client behaving well, but the impact that it
>> has on the overall system performance due to random seeks.
>
> Maybe you've presented data on this to somebody, but the group hasn't
> seen it. Please do show and tell! And demonstrate that the performanc=
e
> impact is inherent in a client-based solution, rather than in the way
> it's currently implemented. :)

Ok, I'm off this thread. Greg, you lost me here with this kind of attit=
ude.

>
>>> If we *do* want to add time-based triggers that clients can set up,
>>> that ought to be a well-thought-out interface that isn't limited to=
 a
>>> single use-case. I'm totally fine with the idea, as long as it come=
s
>>> at some point in the future when we aren't all working hard to
>>> stabilize the core system.
>>
>> We may create that sometime in the future, and implement garbage
>> collection using that. But you're failing to understand the point th=
at
>> using the scrub is just an implementation detail.
> Hanging it off of scrub is not just an implementation detail =97 if y=
ou
> do it without scrub, then the work becomes dramatically more complex
> and the fact that it does deletes instead of arbitrary code execution
> is just an implementation detail. My opposition is to both the
> implementation and the interface (that we have to carry forever).
>
>> I do think that we
>> need object expiration in rados. This is not a single use case.
>> I also think that using external client for that is a mistake
>> (performance on one hand, but also adding administrative pain).
>
> I can't find object expiration anywhere except in S3, and that
> interface is very clearly about end-user ease of use rather than
> pushing the expiration into the object store. The only use case they
> can come up with is logs stored in objects, and expiration generates
> explicit bucket access logs which makes it look to me like it's run a=
s
> a separate process using bucket scanning. *shrug*
> -Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
