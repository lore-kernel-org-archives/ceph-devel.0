From: Alfredo Deza <adeza@redhat.com>
Subject: Re: master branch merges must pass unit tests
Date: Wed, 9 Nov 2016 08:37:45 -0500
Message-ID: <CAC-Np1wATLgOiRJ4OFef2=1-3xawPprrAKFghi25VwGY-A21fQ@mail.gmail.com>
References: <alpine.DEB.2.11.1611082147590.29278@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f179.google.com ([209.85.220.179]:34345 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752650AbcKINhq (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Nov 2016 08:37:46 -0500
Received: by mail-qk0-f179.google.com with SMTP id q130so255838152qke.1
        for <ceph-devel@vger.kernel.org>; Wed, 09 Nov 2016 05:37:46 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1611082147590.29278@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Nov 8, 2016 at 4:49 PM, Sage Weil <sweil@redhat.com> wrote:
> I enabled the github check that the unit tests pass in order to merge to
> master.

Thank you!

> These tests still aren't completely reliable, but they're close,
> and we'll make better progress if we start enforcing it now.
>

I would like to see some effort put into make it more reliable. One of
the things that it has to do is reboot the box where it runs
to ensure that processes are really killed. I would love to see some
effort put into the targets to make them robust.

There is nothing too complicated going on at the CI level, we just
call run-make-check.sh:

https://github.com/ceph/ceph-build/blob/master/ceph-pull-requests/config/definitions/ceph-pull-requests.yml#L49

> Note that core developers can still override the check to merge if
> it's necessary, but I encourage you to avoid doing so!
>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
