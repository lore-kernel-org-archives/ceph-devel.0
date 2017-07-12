From: Patrick Donnelly <pdonnell@redhat.com>
Subject: Re: updating the documentation
Date: Wed, 12 Jul 2017 11:37:32 -0700
Message-ID: <CA+2bHPaRDo=HLpui_4jcMXcFCzgR6UsmetpX7B6t2L-160oV=A@mail.gmail.com>
References: <alpine.DEB.2.11.1707121823111.3424@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f174.google.com ([209.85.216.174]:34392 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751015AbdGLSiE (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Jul 2017 14:38:04 -0400
Received: by mail-qt0-f174.google.com with SMTP id 32so19926922qtv.1
        for <ceph-devel@vger.kernel.org>; Wed, 12 Jul 2017 11:38:03 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1707121823111.3424@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>

On Wed, Jul 12, 2017 at 11:29 AM, Sage Weil <sweil@redhat.com> wrote:
> In the meantime, we can also avoid making the problem worse by requiring
> that all pull requests include any relevant documentation updates.  This
> means (1) helping educate contributors that doc updates are needed, (2)
> helping maintainers and reviewers remember that doc updates are part of
> the merge criteria (it will likely take a bit of time before this is
> second nature), and (3) generally inducing developers to become aware of
> the documentation that exists so that they know what needs to be updated
> when they make a change.

There was a joke to add a bot which automatically fails PRs for no
documentation but I think there is an way to make that work in a
reasonable way. Perhaps the bot could simply comment on all PRs
touching src/ that documentation is required and where to look, and
then fails a doc check. A developer must comment on the PR to say it
passes documentation requirements before the bot changes the check to
pass.

This addresses all three points in an automatic way.

-- 
Patrick Donnelly
