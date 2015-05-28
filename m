From: Robert LeBlanc <robert@leblancnet.us>
Subject: Re: RFC: progress bars
Date: Thu, 28 May 2015 10:41:03 -0600
Message-ID: <CAANLjFoGRNqGH34BsFKp54R3L5o1x8HKi+s9FQrN+HtbbQjBbg@mail.gmail.com>
References: <5523D388.6010008@redhat.com>
	<CAC6JEv8FEMieXZH0+muXNNMT1xkY863HGvsUy0qB9AMzeQLfWQ@mail.gmail.com>
	<5566EA5D.3000800@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:36068 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753357AbbE1QlF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 May 2015 12:41:05 -0400
Received: by wgbgq6 with SMTP id gq6so41474646wgb.3
        for <ceph-devel@vger.kernel.org>; Thu, 28 May 2015 09:41:03 -0700 (PDT)
In-Reply-To: <5566EA5D.3000800@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <john.spray@redhat.com>
Cc: Gregory Farnum <greg@gregs42.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Let me see if I understand this... Your idea is to have a progress bar
that show (active+clean + active+scrub + active+deep-scrub) / pgs and
then estimate time remaining?

So if PGs are split the numbers change and the progress bar go
backwards, is that a big deal? I don't think so, it might take a
little time to recalculate how long it will take, but no big deal. I
do like the idea of the progress bar even if it is fuzzy. I keep
running ceph status or ceph -w to watch things and have to imagine it
in my mind. It might be nice to have some other stats like client I/O
and rebuild I/O so that I can see if recovery is impacting production
I/O.
-----BEGIN PGP SIGNATURE-----
Version: Mailvelope v0.13.1
Comment: https://www.mailvelope.com

wsFcBAEBCAAQBQJVZ0UcCRDmVDuy+mK58QAA5aoP/35AF2j39uo4RiKLi1NF
Er7onOEoMng4ZLX3xBelc4MOhFR6WYFtbAx+KBi2mILZBBI3OK24mDagSIRu
6CD8iNQo0EDbec1J4ny63pzs+5PruPgT0WdU5VInlfwYzzn+2OnZidOxrQHN
kGseN5V/VB0M+ooGBp2oclZp9a2PCOq3jm8npvas+3kNdflmVPntXo/W9zDn
K6sMbkwzp+N2kmCykA5f28PYnitMVP5QfDiM9qYmLdF6U1saQ8O3ULUAGz8j
3HSaA8gUwKsbLQHQQWRvy/8OAvFEIp3I3CzGzgcryTKQNoZJhHm2ueai26qn
u+6T+Sj+t+R6x4oosJKLm7ZlBavMW/bsFO+4prei6kw+dbVsRI7SOZ48mgWn
qgRFtbKVdIeK+ARgCqvOeOvKyUblcsuc9B5yC4uGZ6ozGVQIjOIEZeOOLaqZ
oo/385VIjv/oO5//aIOBjqBt9Pdn+vQzGN1IUjiWucq1B0Nlx3imCIXDnoG7
EY+W0BU8snH3aQS+xuBEv8OUqzuQyvrOgXe8VXKV48i2ks34REcQDemFxsbu
7yCKS4lho9uJyrDK9Pe7V3u3o/SJypWzQt9uI9LimtLUv0O9J3EGjlyfzBmP
zUayeb/pYWtjcLZYB079Yjl5NKqWOdewStCM9JhTNwjc7bclQ4H0LLW3EW2P
jeQE
=KYfI
-----END PGP SIGNATURE-----
----------------
Robert LeBlanc
GPG Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1


On Thu, May 28, 2015 at 4:13 AM, John Spray <john.spray@redhat.com> wrote:
>
>
> On 28/05/2015 06:47, Gregory Farnum wrote:
>>
>> Thread necromancy! (Is it still necromancy if it's been waiting in my
>> inbox the whole time?)
>
>
> Braaaaains.
>
>
>>
>> On Tue, Apr 7, 2015 at 5:54 AM, John Spray <john.spray@redhat.com> wrote:
>>>
>>> Hi all,
>>>
>>> [this is a re-send of a mail from yesterday that didn't make it, probably
>>> due to an attachment]
>>>
>>> It has always annoyed me that we don't provide a simple progress bar
>>> indicator for things like the migration of data from an OSD when it's
>>> marked
>>> out, the rebalance that happens when we add a new OSD, or scrubbing the
>>> PGs
>>> on an OSD.
>>>
>>> I've experimented a bit with adding user-visible progress bars for some
>>> of
>>> the simple cases (screenshot at http://imgur.com/OaifxMf). The code is
>>> here:
>>>
>>> https://github.com/ceph/ceph/blob/wip-progress-events/src/mon/ProgressEvent.cc
>>>
>>> This is based on a series of "ProgressEvent" classes that are
>>> instantiated
>>> when certain things happen, like marking and OSD in or out.  They provide
>>> an
>>> init() hook that captures whatever state is needed at the start of the
>>> operation (generally noting which PGs are affected) and a tick() hook
>>> that
>>> checks whether the affected PGs have reached their final state.
>>>
>>> Clearly, while this is simple for the simple cases, there are lots of
>>> instances where things will overlap: a PG can get moved again while it's
>>> being backfilled following a particular OSD going out. These progress
>>> indicators don't have to capture that complexity, but the goal would be
>>> to
>>> make sure they did complete eventually rather than getting stuck/confused
>>> in
>>> those cases.
>>
>> I haven't really looked at the code yet, but I'd like to hear more
>> about how you think this might work from a UI and tracking
>> perspective. This back-and-forth shuffling is likely to be a pretty
>> common case. I like the idea of better exposing progress states to
>> users, but I'm not sure progress bars in the CLI are quite the right
>> approach. Are you basing these on the pg_stat reports of sizes across
>> nodes? (Won't that break down when doing splits?)
>
>
> For some definitions of "break down".  I think we need to be a little bit
> easy on ourselves and recognise that there will always be situations that
> aren't quite captured in a single ProgressEvent. Trying to capture all those
> things in perfect detail drives the complexity up a lot: I think that for a
> "nice to have" feature like this to fly it has to be kept simple.  More
> generally, the principle that we can't capture everything perfectly
> shouldn't prevent us from exposing simple cases like rebalance progress
> after they add a disk.
>
> In the splitting example, where some PGs were being backfilled
> (ProgressEvent "OSD died, rebalancing") and then split, the first event
> would become inaccurate (although would complete promptly), but there would
> be a new "Expanding pool" event that would prevent the user thinking their
> system was back in a steady state.
>
>>
>> In particular, I think I'd want to see something that we can report in
>> a nested or reversible fashion that makes some sort of sense. If we do
>> it based on position in the hash space that seems easier than if we
>> try to do percentages: you can report hash ranges for each subsequent
>> operation, including rollbacks, and if you want the visuals you can
>> output each operation as a single row that lets you trace the overlaps
>> between operations by going down the columns.
>> I'm not sure how either would scale to a serious PG reorganization
>> across the cluster though; perhaps a simple 0-100 progress bar would
>> be easier to generalize in that case. But I'm not really comfortable
>> with the degree of lying involved there.... :/
>
>
> Hmm, the hash space concept is interesting, but I think that it's much
> harder for anyone to consume (be it a human being, or a GUI), because they
> have to understand the concept of this space to know what they're looking
> at.
>
> That kind of richer presentation would be very useful for the general cases
> that require more advanced treatment (and knowledge of what PGs are etc),
> whereas my goal with this patch was to hit the special (but common) cases
> that require very little reasoning (my cluster is rebuilding some data, how
> soon will it be done?)
>
> Put another way, I think that if one implemented a really nice form of
> presentation involving overlapping operations in the hash space, there would
> still be an immediate need for something that collapsed that down into a
> "10% (5GB of 50GB) 00:43 remaining" indicator.
>
> The ideally would always be to have both available of course!
>
>>
>>> This is just a rough cut to play with the idea, there's no persistence of
>>> the ProgressEvents, and the init/tick() methods are peppered with
>>> correctness issues.  Still, it gives a flavour of how we could add
>>> something
>>> friendlier like this to expose simplified progress indicators.
>>>
>>> Ideas for further work:
>>>   * Add in an MDS handler to capture the progress of an MDS rank as it
>>> goes
>>> through replay/reconnect/clientreplay
>>>   * A handler for overall cluster restart, that noticed when the mon
>>> quorum
>>> was established and all the map timestamps were some time in the past,
>>> and
>>> then generated progress based on OSDs coming up and PGs peering.
>>>   * Simple: a handler for PG creation after pool creation
>>>   * Generate estimated completion times from the rate of progress so far
>>>   * Friendlier PGMap output, by hiding all PG states that are explained
>>> by an
>>> ongoing ProgressEvent, to only indicate low level PG status for things
>>> that
>>> the ProgressEvents don't understand.
>>
>> Eeek. These are all good ideas, but now I'm *really* uncomfortable
>> reporting a 0-100 number as the progress. Don't you remember how
>> frustrating those Windows copy dialogues used to be? ;)
>
>
> GUI copy dialogs are a lot less frustrating than tools that sliently block
> with no indication of when (or if ever!) they might complete :-)
>
> In my experience, progress indicators go wrong when they start lying about
> progress.  For example, I remember how internet explorer (and probably
> others) would continue to "bounce" the progress bar as long as they were
> waiting for DNS resolution: you could yank the network cable and the system
> would still act like something was happening. That would be equivalent to us
> bouncing a progress bar because we had a PG that claimed to be backfilling
> (we shouldn't do this!), rather than moving the bar when we saw actual
> progress happening (my patch).
>
> Regarding units vs percentages:
>
> If someone wants to know the exact state of an exact number of PGs, they
> still have the detailed PG info for that.  In my mind, progress bars are
> about giving people three things:
>  * The indication that the state of the system (e.g. a WARN state) is
> temporary
>  * The confidence that something is progressing, the system isn't stuck
>  * An estimate of how long it might take for the system to reach a steady
> state.
>
> None of those needs an exact number. Because these progress metrics can be a
> little fuzzy in the case where multiple overlapping changes to the system
> are happening, the actual units could be a mouthful like "number of PGs
> whose placement has was affected by this event and have since achieved
> active+clean status".  But when there are other operations going on it might
> be even more convoluted like "...excluding any that have been affected by a
> split operation and therefore we aren't tracking any more".
>
> Despite those points in defence of the %ge output, there is of course no
> reason at the API level not to also expose the PG counts for items that
> progress in terms of PGs, or the "step" identifier for things progressing
> through a process like MDS replay/reconnect/etc.  It's key that the API
> consumer doesn't *have* to understand these detailed things in order to slap
> a progress bar on the screen though: there should always be a "for dummies"
> %ge value.
>
> Cheers,
> John
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
