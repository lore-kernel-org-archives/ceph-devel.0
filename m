From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: efficient removal of old objects
Date: Wed, 1 Feb 2012 09:39:05 -0800
Message-ID: <CAF3hT9DXMz6Ga-=FHz35KGMaj+bS8pA2bZky3mvo7xbEejxppQ@mail.gmail.com>
References: <Pine.LNX.4.64.1201311549170.21770@cobra.newdream.net>
	<CAC-hyiG512de2h+R98g1POOy0Lw18A15TPwE=ge-OgjofdR8Wg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:35933 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754357Ab2BARjG convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Feb 2012 12:39:06 -0500
Received: by iacb35 with SMTP id b35so1791423iac.19
        for <ceph-devel@vger.kernel.org>; Wed, 01 Feb 2012 09:39:06 -0800 (PST)
In-Reply-To: <CAC-hyiG512de2h+R98g1POOy0Lw18A15TPwE=ge-OgjofdR8Wg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@newdream.net>, Yehuda Sadeh Weinraub <yehudasa@gmail.com>

On Wed, Feb 1, 2012 at 12:04 AM, Yehuda Sadeh Weinraub
<yehudasa@gmail.com> wrote:
> (resending to list, sorry tv)
>
> On Tue, Jan 31, 2012 at 5:02 PM, Tommi Virtanen
> <tommi.virtanen@dreamhost.com> wrote:
>>
>> On Tue, Jan 31, 2012 at 16:33, Sage Weil <sage@newdream.net> wrote:
>> > Currently rgw logs objects it wants to delete after some period of=
 time,
>> > and an radosgw-admin command comes back later to process the log. =
=A0It
>> > works, but is currently slow (one sync op at a time).
>> >
>> > A better approach would be to mark objects for later removal, and =
have the
>> > OSD do it in some more efficient way. =A0wip-objs-expire has a cli=
ent side
>> > (librados) interface for this.
>>
>> Is there some reason why this would be significantly more performant
>> when done by the OSD itself? It seems like the deletion times can be
>> bucketed by time nicely, then each bucket just contains a set of ids
>> -- a good fit for the map data type -- and the client for running th=
is
>> deletion just streams the bucket contents over and issues delete
>> messages for everything. What makes that inherently slow?
>
> Random access to random cold objects is generally slower than doing
> the operations on a single pg. E.g., if doing it as part of the scrub=
,
> then objects are accessed anyway and are hopefully cached.

You are dramatically overstating the impact of latency on an
inherently parallelizable and non-interactive operation. A couple disk
seeks *do not matter.*

On Wed, Feb 1, 2012 at 12:26 AM, Yehuda Sadeh Weinraub
<yehudasa@gmail.com> wrote:
> On Tue, Jan 31, 2012 at 4:33 PM, Sage Weil <sage@newdream.net> wrote:
>> A better approach would be to mark objects for later removal, and ha=
ve the
>> OSD do it in some more efficient way. =A0wip-objs-expire has a clien=
t side
>> (librados) interface for this.
>
> Note that setting expiration on an object is a more lightweight
> operation than appending the intent log, as it would be done as a sub
> op in the compound operation that created the object.

=2E..you're going to set expirations on the objects when you write them=
?
What if the user's upload takes longer than you expect?

>> I think there are a couple questions:
>>
>> Should this be generalized to saying "do these osd ops at time X" in=
stead
>> of "delete at time X". =A0Then it could setxattr, remove, call into =
a class,
>> whatever.
>
> While I think it'd make a nice feature, I also think that the problem
> space of a garbage collection is a bit different, and given the time
> constraints it wouldn't make sense implementing this right now anyway=
=2E

This is client-side garbage collection, not RADOS garbage collection.
Don't confuse those issues, either =97=A0the second is appropriate to p=
ut
into the OSDs as special logic; the first is not. That's why we think
that any OSD implementation of this should be generalized as a class
interface, rather than a specific hack.

>> How would the OSD implement this? =A0A kludgey way would be to do it=
 during
>> scrub. =A0The current scrub implementation may make that problematic=
 because
>> it does a whole PG at time, and we probably don't want to issue a wh=
ole
>> PG's worth of deletes at a time. =A0Is there a way to make that less
>> painful?
>
> If we need to lock the entire pg while removing the objects it wouldn=
't work.

That's how scrub works right now...

> I'm not too familiar with the scrub code, and I don't want to dive
> here into possible implementation details, but getting the scrub to
> generate a list of objects for removal may be possible.

Sam and I tossed around a few ideas for how to do this, and it's not
impossible, but it was significantly more complicated than everybody
thinks it is at first glance. (You need to make sure that it doesn't
interact with recovery at all, which means it needs to go through the
normal request mechanism, which means you need to build up a queue of
deletes while scrubbing and then dispatch it properly without
disrupting client requests or running out of memory; you need to make
sure that scrubbing runs more reliably than it does right now...etc
etc)

>> Not using scrub means we need some sort of index to keep track of ob=
jects
>> with delayed events. =A0Using a collection for this might work, but =
loading
>> all this state into memory would be slow if there were too many even=
ts
>> registered.
>>
>> Given all that, and that we need a solution to the expiration soon
>> (weeks), do we
>> =A0- do a complete solution now,
>> =A0- parallelize radosgw-admin log processing,
>> =A0- or hack it into scrub?
>>
> I don't expect to see many hands going up for "hacking" anything. I
> would argue that having a garbage collection related job going on
> inside a maintenance activity is not that far fetched. Not at any cos=
t
> though.

The problem is that it changes the nature of scrub. Right now, scrub
doesn't change anything at all; scrub repair sets the replicas to have
the same state as the primary. You want to add a client-controlled
state mutation that is triggered as part of scrub, which *really*
makes it different (and complicated)...or else it's a hack to have
scrub trigger some weird sequences of requests (as I outlined above).
Either way, it's a big change to scrub that smells hacky.

The basic issue here is that the RGW stuff can all be done as
client-side operations, and all you've demonstrated is that doing it
serially with a single client is slow (but not slower than the
generation of the objects, which means that it does actually work).
The correct response to that is not to add half-baked features to the
OSD; the correct response is to make your client behave well.
If we *do* want to add time-based triggers that clients can set up,
that ought to be a well-thought-out interface that isn't limited to a
single use-case. I'm totally fine with the idea, as long as it comes
at some point in the future when we aren't all working hard to
stabilize the core system.

-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
