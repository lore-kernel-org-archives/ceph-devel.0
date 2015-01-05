From: Gregory Farnum <greg@gregs42.com>
Subject: Re: Ceph backports
Date: Mon, 5 Jan 2015 15:24:05 -0800
Message-ID: <CAC6JEv94h5edyT68UcseSbYLSnT+eFMsUOxo84sVLw1T1f446g@mail.gmail.com>
References: <54AA7B46.6090706@dachary.org>
	<CAGd4Wr2aw1ODd=06dQa7HQzbFu6sYZeQGTOV5Vn6VW+j6dK63g@mail.gmail.com>
	<54AA80AD.2010901@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:55056 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751485AbbAEXYH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Jan 2015 18:24:07 -0500
Received: by mail-ig0-f178.google.com with SMTP id b16so2620314igk.5
        for <ceph-devel@vger.kernel.org>; Mon, 05 Jan 2015 15:24:06 -0800 (PST)
Received: from mail-ig0-f171.google.com (mail-ig0-f171.google.com. [209.85.213.171])
        by mx.google.com with ESMTPSA id ao5sm4233954igc.3.2015.01.05.15.24.05
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 05 Jan 2015 15:24:05 -0800 (PST)
Received: by mail-ig0-f171.google.com with SMTP id z20so3355103igj.10
        for <ceph-devel@vger.kernel.org>; Mon, 05 Jan 2015 15:24:05 -0800 (PST)
In-Reply-To: <54AA80AD.2010901@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: John Spray <john.spray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Jan 5, 2015 at 4:16 AM, Loic Dachary <loic@dachary.org> wrote:
>
>
> On 05/01/2015 13:03, John Spray wrote:
>> Sounds sane -- is the new plan to always do backports via this
>> process?  i.e. if I see a backport PR which has not been through
>> integration testing, should I refrain from merging it?
>
> I think that's the idea, indeed. QE does the merge, when and if tests are green.
>
>>
>> John
>>
>> On Mon, Jan 5, 2015 at 11:53 AM, Loic Dachary <loic@dachary.org> wrote:
>>> Hi Ceph,
>>>
>>> I'm going to spend time to care for the Ceph backports (i.e. help reduce the time they stay in pull requests or redmine tickets). It should roughly go as follows:
>>>
>>> 0. Developer follows normal process to land PR to master. Once complete and ticket is marked Pending Backport this process initiates.
>>> 1. I periodically polls Redmine to look for tickets in Pending Backport state
>>> 2. I find commit associated with Redmine ticket and Cherry Picks it to backport integration branch off of desired maintenance branch (Dumping, Firefly, etc). (Note - patch may require backport to multiple branches)
>>> 3. I resolve any merge conflicts with the cherry-picked commit
>>> 4. Once satisfied with group of backported commits to integration branch, I notifies QE.
>>> 5. QE tests backport integration branch against appropriate suites
>>> 6a. If QE is satisfied with test results, they merge backport integration branch.
>>> 6b. If QE is NOT satisfied with the test results, they indicate backport integration branch is NOT ready to merge and return to me to work with original Developer to resolve issue and return to steps 2/3
>>> 7. Ticket is moved to Resolved once backport integration branch containing cherry-picked backport is merged to the desired mainteance branch(es)
>>>
>>> I'll first try to implement this semi manually and document / script when convenient. If anyone has ideas to improve this tentative process, now is the time :-)


Okay, I've got a bunch of questions. In your first email it sounds
like you're saying this is how you're going to voluntarily handle some
backports. But in response to John's email it sounds like you want to
gate all backports through yourself and this process. Is this a
request that everybody else stops performing backports, and have you
checked with enough usual suspects to make sure they'll respect the
process? ;)

I am 100% on board with making QE responsible for gating backports, so
thank you for starting down that path. :) But I'm not at all sure how
this scales for you. Right now backports are nominally run through two
important checks:
1) Is it suitable for backport (decided by author or tech lead, marked
via the Pending Backport tag)
2) Has it been through sufficient validation in master to be safe to
backport (not marked in the system anywhere, just by somebody actually
doing the backport).

Knowing if something has been through sufficient validation to
backport requires a fair bit of attention to the details of the ticket
and the patches involved. How do you plan to keep up on that?

Similarly, while point releases are largely ad-hoc, we are trying to
involve all the leads in the time-to-go decision. A lot of those
decisions rest on whether specific backports have been performed yet,
whether there are very new backports we want to run through testing
for a little longer, etc. That sounds like a lot of communications
overhead between the backport gates and the leads when making these
kinds of decisions and I'm not sure how that should happen; is there a
plan? (We can look at ticket status for things which are pending
backport, but that doesn't facilitate prioritizing their backports;
and in the opposite direction there's not a good way to say "this
relatively large backport needs to go through at least three test runs
before a release".)
-Greg
