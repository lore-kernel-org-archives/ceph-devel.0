From: Milosz Tanski <milosz@adfin.com>
Subject: Re: fscache recursive hang -- similar to loopback NFS issues
Date: Tue, 5 Aug 2014 00:12:25 -0400
Message-ID: <CANP1eJGoT2RmKB6asjbFgP=emLuxQqgqE4Xf9Gx7fYzPfS1img@mail.gmail.com>
References: <CANP1eJEVnH2w7t6r8g1ow07UNWRA8bPduwD-FezqCBKB_J_=XQ@mail.gmail.com>
	<CANP1eJE7tU9touhSq+Utt=MLE4w5D_C4pT1TAFAiFNBh8ee_mA@mail.gmail.com>
	<20140721164044.2845f3fd@notabene.brown>
	<29057.1406650354@warthog.procyon.org.uk>
	<20140730071735.21ab7ca6@notabene.brown>
	<CANP1eJHo7xrFoXWWgKQNrTi94vaxN9x-ViXNBE4VcXAa_jjQ3Q@mail.gmail.com>
	<20140730121935.124bc7c9@notabene.brown>
	<CANP1eJEBO0VbG2MoBzRB1h3c0QzOhAjvqUtHSX0+Y_uDT5oZug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <CANP1eJEBO0VbG2MoBzRB1h3c0QzOhAjvqUtHSX0+Y_uDT5oZug@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: David Howells <dhowells@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-cachefs@redhat.com" <linux-cachefs@redhat.com>
List-Id: ceph-devel.vger.kernel.org

I was away for a few days but I did think about this some more and how
to avoid a tunable and having a sensible default option.

FSCache already tracks statistics about how long writes and reads take
(at least if you enable that option). With those stats in hand we
should be able generate a default timeout value that works well and
avoid a tunable.

My self I thinking something like the 90th percentile time for page
write... whatever the value may be this should be a decent way of
auto-optimizing this timeout.

- M

On Wed, Jul 30, 2014 at 12:06 PM, Milosz Tanski <milosz@adfin.com> wrote:
> I don't think that fixing a dead lock should impose a somewhat
> un-explainable high latency for the for the end user (or system
> admin). With old drives such latencies (second plus) were not
> unexpected.
>
> - Milosz
>
> On Tue, Jul 29, 2014 at 10:19 PM, NeilBrown <neilb@suse.de> wrote:
>> On Tue, 29 Jul 2014 21:48:34 -0400 Milosz Tanski <milosz@adfin.com> wrote:
>>
>>> I would vote on the lower end of the spectrum by default (closer to
>>> 100ms) since I imagine anybody deploying this in production
>>> environment would likely be using SSD drives for the caching. And in
>>> my tests on spinning disks there was little to no benefit outside of
>>> reducing network traffic.
>>
>> Maybe I'm confused......
>>
>> I thought the whole point of this patch was to avoid deadlocks.
>> Now you seem to be talking about a performance benefit.
>> What did I miss?
>>
>> NeilBrown
>>
>>
>>>
>>> - Milosz
>>>
>>> On Tue, Jul 29, 2014 at 5:17 PM, NeilBrown <neilb@suse.de> wrote:
>>> > On Tue, 29 Jul 2014 17:12:34 +0100 David Howells <dhowells@redhat.com> wrote:
>>> >
>>> >> Milosz Tanski <milosz@adfin.com> wrote:
>>> >>
>>> >> > That's the same thing exact fix I started testing on Saturday. I found that
>>> >> > there already is a wait_event_timeout (even without your recent changes). The
>>> >> > thing I'm not quite sure is what timeout it should use?
>>> >>
>>> >> That's probably something to make an external tuning knob for.
>>> >>
>>> >> David
>>> >
>>> > Ugg.  External tuning knobs should be avoided wherever possible, and always
>>> > come with detailed instructions on how to tune them  </rant>
>>> >
>>> > In this case I think it very nearly doesn't matter *at all* what value is
>>> > used.
>>> >
>>> > If you set it a bit too high, then on the very very rare occasion that it
>>> > would currently deadlock, you get a longer-than-necessary wait.  So just make
>>> > sure that is short enough that by the time the sysadmin notices and starts
>>> > looking for the problem, it will be gone.
>>> >
>>> > And if you set it a bit too low, then it will loop around to find another
>>> > page to deal with before that one is finished being written out, and so maybe
>>> > do a little bit more work than is needed (though it'll be needed eventually).
>>> >
>>> > So the perfect number is somewhere between the typical response time for
>>> > storage, and the typical response time for the sys-admin.  Anywhere between
>>> > 100ms and 10sec would do.  1 second is the geo-mean.
>>> >
>>> > (sorry I didn't reply earlier - I missed you email somehow).
>>> >
>>> > NeilBrown
>>>
>>>
>>>
>>
>
>
>
> --
> Milosz Tanski
> CTO
> 16 East 34th Street, 15th floor
> New York, NY 10016
>
> p: 646-253-9055
> e: milosz@adfin.com



-- 
Milosz Tanski
CTO
16 East 34th Street, 15th floor
New York, NY 10016

p: 646-253-9055
e: milosz@adfin.com
