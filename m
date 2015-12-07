From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: proposal to run Ceph tests on pull requests
Date: Mon, 7 Dec 2015 06:42:58 -0800
Message-ID: <CAJ4mKGaNswQrRWVzy7Fy9GpLFcg-Kbmjj-Ra7CEi+oKjzzUY6Q@mail.gmail.com>
References: <5662CF55.3050702@dachary.org>
	<CALe9h7eZZb5dXgu6cH5BWjhRtU2_R6NkfpFXgNz-SVOmf3hOiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:34958 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932706AbbLGOnA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Dec 2015 09:43:00 -0500
Received: by wmuu63 with SMTP id u63so143290942wmu.0
        for <ceph-devel@vger.kernel.org>; Mon, 07 Dec 2015 06:42:58 -0800 (PST)
In-Reply-To: <CALe9h7eZZb5dXgu6cH5BWjhRtU2_R6NkfpFXgNz-SVOmf3hOiQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Loic Dachary <loic@dachary.org>, Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Dec 7, 2015 at 3:29 AM, John Spray <jspray@redhat.com> wrote:
> On Sat, Dec 5, 2015 at 11:49 AM, Loic Dachary <loic@dachary.org> wrote:
>> Hi Ceph,
>>
>> TL;DR: a ceph-qa-suite bot running on pull requests is sustainable and is an incentive for contributors to use teuthology-openstack independently
>
> A bot for scheduling a named suite on a named PR, and posting the
> results back the PR is definitely a good thing.
>
> Thinking further about using commit messages to toggle the testing, I
> think that this could get awkward when it's coupled to the human side
> of code review.  When someone pushes a "how about this?" modification
> they don't necessarily want to re-run the test suite until the
> reviewer has okayed it, but then that means that they have to push
> again, and the final thing that's tested would be a different SHA1
> (hopefully the same code) than what the human last reviewed.  We'll
> also have e.g. rebases, where there tends to be some discretion about
> whether a rebase requires a re-test.
>
> When you were talking about having the suite selected in the qa: tag,
> there was the motivation to put it in the commit message so that it
> would be preserved in backports.  However, if the "Needs-qa:" flag is
> just a boolean, then I think it makes more sense to control it with a
> github label or by posting a command in a PR comment.
>
> I'm not sure how this really helps with the resource issues; for
> example with the fs suite we would probably not be able to make a
> finer-grained choice about what tests to run based on the diff.  The
> part about randomly dropping a subset of tests when resources are low
> doesn't make sense to me -- I think the bot should either give up or
> enqueue itself.

Yeah. It might eventually be nice for whitelisted people to be able to
trigger a suite run from the github interface, but right now we don't
have anywhere near the resources for an automatic run of each PR, and
I don't see us getting them.
And as John says, for almost every change an automatic selection isn't
going to be able to do any better than picking a full suite to run
(based on what a developer has manually entered into the commit
message).

Let's just stick with what we've got for now and see how it goes with
getting people to do their own testing.
-Greg
