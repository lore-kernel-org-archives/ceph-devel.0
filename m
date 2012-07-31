From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: [EXTERNAL] Re: avoiding false detection of down OSDs
Date: Tue, 31 Jul 2012 09:07:56 -0600
Message-ID: <5017F4CC.9070308@sandia.gov>
References: <CAPYLRzjoaWkMkz4U+=rZQ+YMS76vkLf_KVZfbWmdLnPuCYadSw@mail.gmail.com>
 <50170EF0.5040004@sandia.gov>
 <CAPYLRzhH-MNPHhXbg36jkMGGdh3mtn+jqR5FQDzGta0y67UkPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:38401 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753987Ab2GaPIS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 31 Jul 2012 11:08:18 -0400
In-Reply-To: <CAPYLRzhH-MNPHhXbg36jkMGGdh3mtn+jqR5FQDzGta0y67UkPw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 07/30/2012 06:24 PM, Gregory Farnum wrote:
> On Mon, Jul 30, 2012 at 3:47 PM, Jim Schutt<jaschut@sandia.gov>  wrot=
e:
>>
>> Above you mentioned that you are seeing these issues as you scaled
>> out a storage cluster, but none of the solutions you mentioned
>> address scaling.  Let's assume your preferred solution handles
>> this issue perfectly on the biggest cluster anyone has built
>> today.  What do you predict will happen when that cluster size
>> is scaled up by a factor of 2, or 10, or 100?
> Sage should probably describe in more depth what we've seen since he'=
s
> looked at it the most, but I can expand on it a little. In argonaut
> and earlier version of Ceph, processing a new OSDMap for an OSD is
> very expensive. I don't remember the precise numbers we'd whittled it
> down to but it required at least one disk sync as well as pausing all
> request processing for a while. If you combined this expense with a
> large number of large maps (if, perhaps, one quarter of your 800-OSD
> system had been down but not out for 6+ hours), you could cause memor=
y
> thrashing on OSDs as they came up, which could force them to become
> very, very, veeery slow. In the next version of Ceph, map processing
> is much less expensive (no syncs or full-system pauses required),
> which will prevent request backup. And there are a huge number of way=
s
> to reduce the memory utilization of maps, some of which can be
> backported to argonaut and some of which can't.
> Now, if we can't prevent our internal processes from running an OSD
> out of memory, we'll have failed. But we don't think this is an
> intractable problem; in fact we have reason to hope we've cleared it
> up now that we've seen the problem =E2=80=94 although we don't think =
it's
> something that we can absolutely prevent on argonaut (too much code
> churn).
> So we're looking for something that we can apply to argonaut as a
> band-aid, but that we can also keep around in case forces external to
> Ceph start causing similar cluster-scale resource shortages beyond ou=
r
> control (runaway co-located process eats up all the memory on lots of
> boxes, switch fails and bandwidth gets cut in half, etc). If somethin=
g
> happens that means Ceph can only supply half as much throughput as it
> was previously, then Ceph should provide that much throughput; right
> now if that kind of incident occurs then Ceph won't provide any
> throughput because it'll all be eaten by spurious recovery work.

Ah, thanks for the extra context.  I hadn't fully appreciated
the proposal was primarily a mitigation for argonaut, and
otherwise as a fail-safe mechanism.

>>
>> As I mentioned above, I'm concerned this is addressing
>> symptoms, rather than root causes.  I'm concerned the
>> root cause has something to do with how the map processing
>> work scales with number of OSDs/PGs, and that this will
>> limit the maximum size of a Ceph storage cluster.
> I think I discussed this above enough already? :)

Yep, thanks.
>
>
>> But, if you really just want to not mark down an OSD that is
>> laggy, I know this will sound simplistic, but I keep thinking
>> that the OSD knows for itself if it's up, even when the
>> heartbeat mechanism is backed up.  Couldn't there be some way
>> to ask an OSD suspected of being down whether it is or not,
>> separate from the heartbeat mechanism?  I mean, if you're
>> considering having the monitor ignore OSD down reports for a
>> while based on some estimate of past behavior, wouldn't it be
>> better for the monitor to just ask such an OSD, "hey, are you
>> still there?"  If it gets an immediate "I'm busy, come back later",
>> extend the grace period; otherwise, mark the OSD down.
> Hmm. The concern is that if an OSD is stuck on disk swapping then it'=
s
> going to be just as stuck for the monitors as the OSDs =E2=80=94 they=
're all
> using the same network in the basic case, etc. We want to be able to
> make that guess before the OSD is able to answer such questions.
> But I'll think on if we could try something else similar.

OK - thanks.

Also, FWIW I've been running my Ceph servers with no swap,
and I've recently doubled the size of my storage cluster.
Is it possible to have map processing do a little memory
accounting and log it, or to provide some way to learn
that map processing is chewing up significant amounts of
memory?  Or maybe there's already a way to learn this that
I need to learn about?  I sometimes run into something that
shares some characteristics with what you describe, but is
primarily triggered by high client write load.  I'd like
to be able to confirm or deny it's the same basic issue
you've described.

Thanks -- Jim

> -Greg
>
>


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
