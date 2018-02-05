From: Sage Weil <sage@newdream.net>
Subject: Re: Better anticipation for minor releases
Date: Mon, 5 Feb 2018 16:30:16 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1802051624220.15996@piezo.novalocal>
References: <CAC-Np1yBwYUMBiS1tg=9CaJsgEkQJZazP43HzSKT=bR=eof=Uw@mail.gmail.com> <4173fd50ca3d6d4e4f691f116b425397@suse.com> <CAC-Np1xbgABOgjDoYpPrDUvX7hOn3U-AD-YF-LpRsbjAfEPi6g@mail.gmail.com> <bfc90180-334b-519b-cf2c-db13b33abff2@suse.cz>
 <CALqRxCzxBuihz6FTtFq4oROmgstnh79uB8F-iosameNo4+7SOQ@mail.gmail.com> <robbat2-20180202T195241-795645967Z@orbis-terrarum.net> <b0e75bc4-e7da-db16-ddb3-bb70df281699@suse.cz> <CAEPMp+4mVJd6155ZykTUmrgupLAvoLFEPUTBLVY26Hk+anXogA@mail.gmail.com>
 <alpine.DEB.2.11.1802051529210.24931@piezo.novalocal> <CALqRxCwD199oo-=TGsnNgy5vLAaFyD2sqqX2YSjtJx9AVZtLQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from tragedy.dreamhost.com ([66.33.205.236]:60691 "EHLO
        tragedy.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752972AbeBEQaT (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Feb 2018 11:30:19 -0500
In-Reply-To: <CALqRxCwD199oo-=TGsnNgy5vLAaFyD2sqqX2YSjtJx9AVZtLQg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>
Cc: Andrew Schoen <aschoen@redhat.com>, Nathan Cutler <ncutler@suse.cz>, "Robin H. Johnson" <robbat2@gentoo.org>, Alfredo Deza <adeza@redhat.com>, Abhishek <abhishek@suse.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Mon, 5 Feb 2018, Ken Dreyer wrote:
> On Mon, Feb 5, 2018 at 8:50 AM, Sage Weil <sage@newdream.net> wrote:
> > Building from a tag seems like the wrong approach.  What if the build
> > fails for some reason (e.g., minor error in cmake files that affects
> > release build but not test build)?
> 
> Do you have a specific example of this type of failure?
>
> In general I want our test builds to be as close to our release builds
> as possible. Some of the reasons for the differences are mainly
> historical rather than technical. If there are particular differences
> that could cause build failures, let's identify those and fix them!

I don't have an example, but I suspect Alfredo has half a dozen.  Totally 
agree that we should keep the build processes identical, but things 
happen, and even if they don't, it might be that the tip commit hasn't had 
a regular shaman build yet (or that the release person forgot to verify 
that build was successful before kicking off the release build).

> > Or, perhaps for important, what if we
> > get to the point where we do some testing on the final build
> > artifact before finalizing/blessing the release?
> 
> This is an interesting idea. How would you picture someone doing this
> testing, and who would that person be?

Maybe we stage the rc build, run it through qa, and only after that 
passes do we publish the tag and build artifacts.
 
> What happens when the testing fails and people have already merged
> more racing PRs to luminous? We would have to back those out right?

No... this is exactly the point.  Git branches remove any concern for 
"races".  If someone pushed 100 commits to luminous, just create a 
different branch with exactly the commit(s) you *do* want and build from 
that.  After everything is confirmed built, good, and tagged, push and 
merge it back into the luminous stream.

> v10.2.5 and v10.2.9 were quick releases to fix problems in the
> immediate prior releases. If we merged a bunch of PRs at the same time
> there, those quick versions would not have been as quick/safe.
> 
> > I don't understand why racing updates is a problem.  git branching/merge
> > solves exactly this problem:
> 
> Again just my opinion, I think this makes the history harder to read.
> For example, it's already a challenge to remember to run "git
> describe" on the merge commit rather than the code change commit.

It seems like the history complexity is there because history *was* 
complex: work didn't stop for the day(s) that the release was being built 
and finalized.  A simple fork+merge pattern like in my previous email 
isn't that complicated to understand, and it's how pretty every other 
change in the repo appears.

sage
