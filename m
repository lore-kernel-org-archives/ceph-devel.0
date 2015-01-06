From: Gregory Farnum <greg@gregs42.com>
Subject: Re: Ceph backports
Date: Mon, 5 Jan 2015 16:22:40 -0800
Message-ID: <CAC6JEv-uzfzEtLb5X29ne2ME7gTDeysByG0DDJRNZxBQ2WCUEg@mail.gmail.com>
References: <54AA7B46.6090706@dachary.org>
	<CAGd4Wr2aw1ODd=06dQa7HQzbFu6sYZeQGTOV5Vn6VW+j6dK63g@mail.gmail.com>
	<54AA80AD.2010901@dachary.org>
	<CAC6JEv94h5edyT68UcseSbYLSnT+eFMsUOxo84sVLw1T1f446g@mail.gmail.com>
	<54AB2887.8000503@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:43087 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753060AbbAFAWm convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Jan 2015 19:22:42 -0500
Received: by mail-ig0-f181.google.com with SMTP id a13so270293igq.14
        for <ceph-devel@vger.kernel.org>; Mon, 05 Jan 2015 16:22:41 -0800 (PST)
Received: from mail-ie0-f171.google.com (mail-ie0-f171.google.com. [209.85.223.171])
        by mx.google.com with ESMTPSA id 5sm27322490ioe.6.2015.01.05.16.22.40
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 05 Jan 2015 16:22:40 -0800 (PST)
Received: by mail-ie0-f171.google.com with SMTP id ar1so170385iec.2
        for <ceph-devel@vger.kernel.org>; Mon, 05 Jan 2015 16:22:40 -0800 (PST)
In-Reply-To: <54AB2887.8000503@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Jan 5, 2015 at 4:12 PM, Loic Dachary <loic@dachary.org> wrote:
> :-) This process is helpful if it allows me to help a little more than I currently do with the backport process. It would be a loss if the end result is that everyone cares less about backports. My primary incentive for sending this mail is to start the conversation and avoid that kind of unintended drawback.

Why do you want to get involved with other people's backports at all?
I don't mean that to sound possessive, but having the patch's primary
author responsible for getting backports done at least has the
singular merit of sharding the work up into manageable pieces. ;)

>
>> I am 100% on board with making QE responsible for gating backports, so
>> thank you for starting down that path. :) But I'm not at all sure how
>> this scales for you. Right now backports are nominally run through two
>> important checks:
>> 1) Is it suitable for backport (decided by author or tech lead, marked
>> via the Pending Backport tag)
>> 2) Has it been through sufficient validation in master to be safe to
>> backport (not marked in the system anywhere, just by somebody actually
>> doing the backport).
>>
>> Knowing if something has been through sufficient validation to
>> backport requires a fair bit of attention to the details of the ticket
>> and the patches involved. How do you plan to keep up on that?
>
> I can't do that all by myself.
>
>> Similarly, while point releases are largely ad-hoc, we are trying to
>> involve all the leads in the time-to-go decision. A lot of those
>> decisions rest on whether specific backports have been performed yet,
>> whether there are very new backports we want to run through testing
>> for a little longer, etc. That sounds like a lot of communications
>> overhead between the backport gates and the leads when making these
>> kinds of decisions and I'm not sure how that should happen; is there a
>> plan? (We can look at ticket status for things which are pending
>> backport, but that doesn't facilitate prioritizing their backports;
>> and in the opposite direction there's not a good way to say "this
>> relatively large backport needs to go through at least three test runs
>> before a release".)
>
> Could you point me to a mail thread / IRC conversation that is representative of this process ?

No; that's pretty much all done in video chats. :/

>
> Here is a revised process which is hopefully more realistic:
>
> 0. Developer follows normal process to land PR to master. Once complete and ticket is marked Pending Backport this process initiates.
> 1. I periodically polls Redmine to look for tickets in Pending Backport state and focus on the ones that are left unattended for too long
> 1a. Under the supervision of the author of the original patch, I find the commits associated with the Redmine ticket and Cherry Pick to the backport integration branch off of the desired maintenance branch (Dumping, Firefly, etc).
> 1b. I resolve any merge conflicts with the cherry-picked commit
> 2. I merge all backports for a given branch in an integration branch
> 3. I ask the leads of each project to review the integration
> 4. Once satisfied with group of backported commits to integration branch, I notify QE.
> 5. QE tests backport integration branch against appropriate suites
> 6a. If QE is satisfied with test results, they merge backport integration branch.
> 6b. If QE is NOT satisfied with the test results, they indicate backport integration branch is NOT ready to merge and return to me to work with original Developer to resolve issue and return to steps 2/3
> 7. Ticket is moved to Resolved once backport integration branch containing cherry-picked backport is merged to the desired mainteance branch(es)
>
> What do you think ?

I think if we're going to add a process to anything it should be
followed by everybody involved. I really would love for everything to
be gated by QE before it goes into a backport branch, but if you're
going off and building integration branches and QE is testing them, I
think other people are going to keep backporting as we have been and
trip all over each other. We've periodically used "firefly-next"
branches and related things, but it's always been ad-hoc.

Something more realistic might involve locking down the stable
branches so they can only be merged into by QE or some approved group,
and then letting people do their own backports onto a
<stable-branch>-next that is periodically taken up and
integration-tested prior to merge into the LTS proper. That ensures
that only patches which have all been tested together get into a
stable branch without forcing each individual backport into a lot of
process.
-Greg
