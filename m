From: Milosz Tanski <milosz@adfin.com>
Subject: Re: fscache recursive hang -- similar to loopback NFS issues
Date: Tue, 29 Jul 2014 21:48:34 -0400
Message-ID: <CANP1eJHo7xrFoXWWgKQNrTi94vaxN9x-ViXNBE4VcXAa_jjQ3Q@mail.gmail.com>
References: <CANP1eJEVnH2w7t6r8g1ow07UNWRA8bPduwD-FezqCBKB_J_=XQ@mail.gmail.com>
	<CANP1eJE7tU9touhSq+Utt=MLE4w5D_C4pT1TAFAiFNBh8ee_mA@mail.gmail.com>
	<20140721164044.2845f3fd@notabene.brown>
	<29057.1406650354@warthog.procyon.org.uk>
	<20140730071735.21ab7ca6@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20140730071735.21ab7ca6@notabene.brown>
Sender: linux-fsdevel-owner@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: David Howells <dhowells@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-cachefs@redhat.com" <linux-cachefs@redhat.com>
List-Id: ceph-devel.vger.kernel.org

I would vote on the lower end of the spectrum by default (closer to
100ms) since I imagine anybody deploying this in production
environment would likely be using SSD drives for the caching. And in
my tests on spinning disks there was little to no benefit outside of
reducing network traffic.

- Milosz

On Tue, Jul 29, 2014 at 5:17 PM, NeilBrown <neilb@suse.de> wrote:
> On Tue, 29 Jul 2014 17:12:34 +0100 David Howells <dhowells@redhat.com> wrote:
>
>> Milosz Tanski <milosz@adfin.com> wrote:
>>
>> > That's the same thing exact fix I started testing on Saturday. I found that
>> > there already is a wait_event_timeout (even without your recent changes). The
>> > thing I'm not quite sure is what timeout it should use?
>>
>> That's probably something to make an external tuning knob for.
>>
>> David
>
> Ugg.  External tuning knobs should be avoided wherever possible, and always
> come with detailed instructions on how to tune them  </rant>
>
> In this case I think it very nearly doesn't matter *at all* what value is
> used.
>
> If you set it a bit too high, then on the very very rare occasion that it
> would currently deadlock, you get a longer-than-necessary wait.  So just make
> sure that is short enough that by the time the sysadmin notices and starts
> looking for the problem, it will be gone.
>
> And if you set it a bit too low, then it will loop around to find another
> page to deal with before that one is finished being written out, and so maybe
> do a little bit more work than is needed (though it'll be needed eventually).
>
> So the perfect number is somewhere between the typical response time for
> storage, and the typical response time for the sys-admin.  Anywhere between
> 100ms and 10sec would do.  1 second is the geo-mean.
>
> (sorry I didn't reply earlier - I missed you email somehow).
>
> NeilBrown



-- 
Milosz Tanski
CTO
16 East 34th Street, 15th floor
New York, NY 10016

p: 646-253-9055
e: milosz@adfin.com
