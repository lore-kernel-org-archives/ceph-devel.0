From: Abhishek <abhishek@suse.com>
Subject: Re: Better anticipation for minor releases
Date: Wed, 31 Jan 2018 20:25:31 +0100
Message-ID: <4173fd50ca3d6d4e4f691f116b425397@suse.com>
References: <CAC-Np1yBwYUMBiS1tg=9CaJsgEkQJZazP43HzSKT=bR=eof=Uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:33387 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751559AbeAaTZc (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 31 Jan 2018 14:25:32 -0500
In-Reply-To: <CAC-Np1yBwYUMBiS1tg=9CaJsgEkQJZazP43HzSKT=bR=eof=Uw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alfredo Deza <adeza@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, ceph-devel-owner@vger.kernel.org, Nathan Cutler <ncutler@suse.cz>

On 2018-01-31 18:46, Alfredo Deza wrote:
> Hi Abhishek,
> 
> For almost every minor release we have, there is a cloud of
> uncertainty where nobody really knows when the release will be cut.
> 
> Most of the time there is an email (or series of emails) that trigger
> the conversation of "are we now ready to cut a release?", where leads
> respond what backports are still pending, or if there are test suites
> that aren't really in the clear.
> 
> For minor releases a mix of a time-based schedule with a set of each
> lead's group of passing tests, would be a nice way to predict when we
> can start having the conversation of cutting a release.

Agree, we wanted to introduce a better process for 12.2.3 but this 
mostly took a backseat with vacations and all. Yuri has been kind enough 
to spend time on running the QE suites and we've a lot backports raised 
from Shinobu and the rest of the ceph community which was great. We've 
mostly had a relatively reddish run on QE suites for 12.2.2 and this has 
relatively changed a lot in 12.2.3 with smaller greener runs thanks to 
Yuri.

For a ~6 week schedule we need to close all the backports in 4 weeks 
since the final qe run takes ~2weeks. Which gives 4 weeks for adding PRs 
as well as going through integration suites etc, we'll have to come up 
with a soft stop in 3 weeks so that we've sufficient time in the 4th 
week to triage and merge the pending queue + any critical PRs we really 
want in the timeframe.

Quoting Nathan from an earlier email; there are roughly two parts to 
this process: - triaging, backporting and integration testing of PRs
- Asking leads for approval, release notes, working with QE for the 
final suite approval.

If we approximately stop accepting new PRs at the third week, ask leads 
at beginning of week 4 and go through only critical PRs for week 4; and 
go to QE in week5,6 we might be able to somewhat get to a more scheduled 
minor releases.

Brickbats and suggestions ?:)
> It isn't a one-shot fix, but would certainly improve everyone who
> wants/needs a new release and can't get any clues as to what that may
> be.
> 
> Something like:
> 
> * Minor releases every 6 weeks
> * subset of test suites passing from each lead
> 
> Would be a good way to start. If we can get that initial release path,
> it would be possible to start thinking about what "gating" really
> means for our releases (since we don't really have any sort of gating
> today)


> 
> What do you think?
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" 
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

