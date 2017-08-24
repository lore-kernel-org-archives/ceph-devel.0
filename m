From: Alfredo Deza <adeza@redhat.com>
Subject: Re: docs build check - necessary for Jewel?
Date: Thu, 24 Aug 2017 14:42:11 -0400
Message-ID: <CAC-Np1yKuyBjuNXuLaUANnOJw=svvx1R5pvT5q8hyGi1OpBoiQ@mail.gmail.com>
References: <8fb1422b-b2b0-88d2-f6ff-849219d1ec46@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f178.google.com ([209.85.128.178]:38412 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753210AbdHXSmN (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Aug 2017 14:42:13 -0400
Received: by mail-wr0-f178.google.com with SMTP id y44so875221wrd.5
        for <ceph-devel@vger.kernel.org>; Thu, 24 Aug 2017 11:42:13 -0700 (PDT)
In-Reply-To: <8fb1422b-b2b0-88d2-f6ff-849219d1ec46@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Aug 24, 2017 at 3:59 AM, Nathan Cutler <ncutler@suse.cz> wrote:
> Hi, is the "docs build check" on GitHub necessary for jewel? If not, can it
> be disabled for jewel?

Anything before the recent changes to master (and now Luminous)
shouldn't create false positives, and can still
allow errors and warnings like before.

This is because the sphinx command used is in ceph.git itself, so just
in master and luminous is the flag needed
to fail hard a build that has errors or warnings.

>
> Given the instability of the checks themselves (false negatives are quite
> common), this new docs check - in addition to guarding against doc
> regressions - also serves to make it even more difficult to get a green
> check mark on a PR.

I am not seeing that many failures in the job history though:
https://jenkins.ceph.com/job/ceph-pr-docs/

We've recently found out that some nodes where getting killed just
when a job was starting and that got deployed
yesterday. Were you seeing some of those? Or some other specific type
of failures?

False negatives is a thing we certainly need to work on, and will not
affect only Jewel but pretty much everything else. Like I mentioned,
even in Jewel the amount of false negatives should be even less since
valid failures are ignored.

There is currently no way to black list a target branch, although
there is a way to whitelist (which would mean extra effort to keep up
with).

This is fairly new, and it did take a few days to stabilize. Sorry if
it caused some issues!

>
> (I know the check is not "required" and PRs can be merged when it is
> failing. The problem arises when the failing docs check causes PRs to go
> from having a nice green checkmark in the list, to having a nasty red X -
> each red X has to be investigated and dealt with, generating additional work
> in an already labor-intensive process.)
>
> Thanks!
> Nathan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
