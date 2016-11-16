From: Gregory Farnum <gfarnum@redhat.com>
Subject: Build Warnings: spotting them, and cleaning them up
Date: Wed, 16 Nov 2016 14:05:49 -0800
Message-ID: <CAJ4mKGa6ECp6Qdy9jU2fF_NWONKZp=hviTyN68LXvw94J9Fd9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f49.google.com ([209.85.214.49]:37554 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932212AbcKPWFv (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Nov 2016 17:05:51 -0500
Received: by mail-it0-f49.google.com with SMTP id b123so37164itb.0
        for <ceph-devel@vger.kernel.org>; Wed, 16 Nov 2016 14:05:51 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Recently, Patrick noticed an issue with the MDS TrackedOp
implementation where we weren't actually dumping out the event lists
anywhere. It turned out to be as a result of an incorrect cleanup, and
he fixed it by just reverting the commit in
https://github.com/ceph/ceph/pull/11985.

But we also wanted to clean up the spurious "now" parameter which goes
on used, and John did that in https://github.com/ceph/ceph/pull/12007.
It was reviewed by Patrick, Kefu, and myself and got merged with green
checkboxes (ie, Github and Jenkins agreed it was good).

Then Patrick noticed we'd missed the Monitor's use of TrackedOp code
and it was spawning warnings because the relevant _dump() functions no
longer had matching parameter lists
(https://github.com/ceph/ceph/pull/12029). This concerned me since
we'd gotten a pass from Jenkins.

It turns out, Jenkins assumes the build is good if the build script
returns 0 — it doesn't know anything about the actual text output and
doesn't scan for warnings.
I'm not sure how hard it would be to change things from that end. From
the *compilation* end, Casey suggests the "nicest" thing would be to
set the -Werr flag, which turns all warnings into errors. Since we
like warning-free code, that's definitely appealing to me.
Unfortunately, we've got a problem: boost is notorious for build
warnings. At the moment, I'm only seeing one (repeated many times
over) resulting from use of the "remove_whitespace" iterator
functionality in RGW. Does anybody know a good way to handle that?

We also have another (seemingly real) warning: the BlueStore
BitAllocator says there are missing return statements in
BmapEntry::operator new [](size_t). I didn't look at the code; maybe
it's failing to detect return statements in an if-else block. But that
should be fixed up as well.

So, I guess I'll just throw out a few statements and see how people
react to them:

1) The Ceph source should build warning-free. If we have warnings from
external code we still trust, we need a way to suppress *only* those
warnings so that issues we introduce can easily be detected.

2) Patches that generate new warnings should not be merged.

3) We should turn on -Werr just as soon as the existing BlueStore
warning is fixed and the boost warnings can be suppressed. That should
happen quickly.

4) If we do that, I guess the existing Jenkins is okay?

-Greg
