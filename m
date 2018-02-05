From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: Better anticipation for minor releases
Date: Mon, 5 Feb 2018 09:22:52 -0700
Message-ID: <CALqRxCwD199oo-=TGsnNgy5vLAaFyD2sqqX2YSjtJx9AVZtLQg@mail.gmail.com>
References: <CAC-Np1yBwYUMBiS1tg=9CaJsgEkQJZazP43HzSKT=bR=eof=Uw@mail.gmail.com>
 <4173fd50ca3d6d4e4f691f116b425397@suse.com> <CAC-Np1xbgABOgjDoYpPrDUvX7hOn3U-AD-YF-LpRsbjAfEPi6g@mail.gmail.com>
 <bfc90180-334b-519b-cf2c-db13b33abff2@suse.cz> <CALqRxCzxBuihz6FTtFq4oROmgstnh79uB8F-iosameNo4+7SOQ@mail.gmail.com>
 <robbat2-20180202T195241-795645967Z@orbis-terrarum.net> <b0e75bc4-e7da-db16-ddb3-bb70df281699@suse.cz>
 <CAEPMp+4mVJd6155ZykTUmrgupLAvoLFEPUTBLVY26Hk+anXogA@mail.gmail.com> <alpine.DEB.2.11.1802051529210.24931@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f54.google.com ([209.85.213.54]:46259 "EHLO
        mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752925AbeBEQWx (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Feb 2018 11:22:53 -0500
Received: by mail-vk0-f54.google.com with SMTP id e125so17998411vkh.13
        for <ceph-devel@vger.kernel.org>; Mon, 05 Feb 2018 08:22:53 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1802051529210.24931@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Andrew Schoen <aschoen@redhat.com>, Nathan Cutler <ncutler@suse.cz>, "Robin H. Johnson" <robbat2@gentoo.org>, Alfredo Deza <adeza@redhat.com>, Abhishek <abhishek@suse.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Feb 5, 2018 at 8:50 AM, Sage Weil <sage@newdream.net> wrote:
> Building from a tag seems like the wrong approach.  What if the build
> fails for some reason (e.g., minor error in cmake files that affects
> release build but not test build)?

Do you have a specific example of this type of failure?

In general I want our test builds to be as close to our release builds
as possible. Some of the reasons for the differences are mainly
historical rather than technical. If there are particular differences
that could cause build failures, let's identify those and fix them!

> Or, perhaps for important, what if we
> get to the point where we do some testing on the final build
> artifact before finalizing/blessing the release?

This is an interesting idea. How would you picture someone doing this
testing, and who would that person be?

What happens when the testing fails and people have already merged
more racing PRs to luminous? We would have to back those out right?

v10.2.5 and v10.2.9 were quick releases to fix problems in the
immediate prior releases. If we merged a bunch of PRs at the same time
there, those quick versions would not have been as quick/safe.

> I don't understand why racing updates is a problem.  git branching/merge
> solves exactly this problem:

Again just my opinion, I think this makes the history harder to read.
For example, it's already a challenge to remember to run "git
describe" on the merge commit rather than the code change commit.
