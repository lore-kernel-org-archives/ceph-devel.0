From: John Spray <jspray@redhat.com>
Subject: Re: getting ready for jewel 10.2.1
Date: Fri, 1 Apr 2016 17:19:47 +0100
Message-ID: <CALe9h7fMNGxX=5sEVQickLA0vt1N0je=AUp1pQN9YkBJoaTSFg@mail.gmail.com>
References: <56FBAADF.3020407@dachary.org> <CALe9h7d65pM08w8KWqo03zT09ny5MAkZgDacOdty97Y7ojCV+Q@mail.gmail.com>
 <alpine.DEB.2.11.1604011107430.22014@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:34660 "EHLO
	mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752044AbcDAQUH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Apr 2016 12:20:07 -0400
Received: by mail-oi0-f47.google.com with SMTP id o62so111996388oig.1
        for <ceph-devel@vger.kernel.org>; Fri, 01 Apr 2016 09:20:07 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1604011107430.22014@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Loic Dachary <loic@dachary.org>, Abhishek Varshney <abhishek.varshney@flipkart.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Fri, Apr 1, 2016 at 4:18 PM, Sage Weil <sage@newdream.net> wrote:
> On Thu, 31 Mar 2016, John Spray wrote:
>> On Wed, Mar 30, 2016 at 11:30 AM, Loic Dachary <loic@dachary.org> wrote:
>> > Hi,
>> >
>> > Now is a good time to get ready for jewel 10.2.1 and I created
>> > http://tracker.ceph.com/issues/15317 for that purpose. The goal is to
>> > be able to run as many suites as possible on OpenStack, so that we do
>> > not have to wait days (sometime a week) for runs to complete on Sepia.
>> > Best case scenario, all OpenStack specific problems are fixed by the
>> > time 10.2.1 is being prepared. Worst case scenario there is no time to
>> > fix issues and we keep using the sepia lab. I guess we'll end up
>> > somewhere in the middle : some suites will run fine on Openstack and
>> > we'll use sepia for others.
>> >
>> > In a previous mail I voiced my concerns regarding the lack of interest
>> > of developers regarding teuthology job failures that are cause by
>> > variations in the infrastructure. I still have no clue how to convey
>> > my belief that it is important for teuthology jobs to succeed despite
>> > infrastructure variations. But instead of just giving up and do
>> > nothing, I will work on that for the rados suite and hope things will
>> > evolve in a good way. To be honest, figuring out
>> > http://tracker.ceph.com/issues/15236 and seeing a good run of the
>> > rados suite on jewel as a result renewed my motivation in that area
>> > :-)
>>
>> If I was dedicating time to working on lab infrastructure, I think I
>> would prioritise stabilising the existing sepia lab.  I still see
>> infrastructure issues (these day usually package install failures)
>> sprinkled all over the place, so I have to question the value of
>> spreading ourselves even more thinly by trying to handle multiple
>> environments with their different quirks.
>
> I think we can't afford not to do both.  The problem with focusing only on
> sepia is that it makes it prevents new contributors from testing their
> code, and testing is one of the key pieces that preventing us from scaling
> our overall development velocity.
>
> Also, FWIW, Sam sank a couple days this week into improvements on the
> sepia side that have eliminated almost all of the sepia package install
> noise we've been seeing (at least on the rados suite).  With Jewel
> stabilizing now is a good time to do the same with openstack.
>
>> I have nothing against the openstack work, it is a good tool, but I
>> don't think it was wise to just deploy it and expect other developers
>> to handle the issues.  I would have liked to see at least one passing
>> filesystem run on openstack before regular nightlies were scheduled on
>> it.  Maybe now that we have fixes for #13980 and #13876 we will see a
>> passing run, and can get more of a sense of how stable/unstable these
>> tests are in the openstack environment: I think it's likely that we
>> will continue to see timeouts/instability from the comparatively
>> underpowered nodes.
>
> The earlier transition to openstack left much to be desired, although to
> be fair it would have been hard to do it all that differently given we
> were forced out of Irvine by the sepia lab move.  In my view the main
> lesson learned was that without everyone feeling invested in fixing the
> issues to make the tests pass, the issues won't get fixed.  The lab folks
> don't understand all of the tests and their weird issues, and the
> developers are too busy with code to help debug them.
>
> I'd like to convince everyone that making openstack a reliable testing
> environment is an importat strategic goal for the project as a whole, and
> in everyone's best interests, and that right now (while we're focusing on
> teuthology tests and waiting for the final blocking jewel bugs to be
> squashed) is as good a time as any to dig into the remaining issues...
> both with sepia *and* openstack.
>
> Is that reasonable?

OK -- if we are committed to doing both, then my opinions about
priorities are kind of academic :-)  If we're all pulling in the same
direction I think it's fine.

Cheers,
John
