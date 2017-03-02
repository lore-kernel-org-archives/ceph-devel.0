From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Testing with Bluestore and Filestore
Date: Thu, 2 Mar 2017 10:36:32 -0800
Message-ID: <CAJ4mKGaq+d6EzFHsADSnO-nC3VbbugrxgkmrhY=3d5cqDjFBqQ@mail.gmail.com>
References: <CAMdDSN2xU=eRCxEDrq3qP0zmXxxTLAZrSboHcB8N4EH2ZhU8PQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ot0-f180.google.com ([74.125.82.180]:33347 "EHLO
        mail-ot0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751995AbdCBSqS (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Mar 2017 13:46:18 -0500
Received: by mail-ot0-f180.google.com with SMTP id k4so58468264otc.0
        for <ceph-devel@vger.kernel.org>; Thu, 02 Mar 2017 10:45:43 -0800 (PST)
In-Reply-To: <CAMdDSN2xU=eRCxEDrq3qP0zmXxxTLAZrSboHcB8N4EH2ZhU8PQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brett Niver <bniver@redhat.com>, John Spray <jspray@redhat.com>
Cc: Sage Weil <sweil@redhat.com>, Jason Dillaman <jdillama@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Mar 2, 2017 at 8:36 AM, Brett Niver <bniver@redhat.com> wrote:
> Sage,
>
> Perhaps this has already been discussed, but Jason had a good idea,
> that perhaps instead of testing both BS and FS upstream independently,
>  and doubling our testing, we might have teuthology randomly pick
> which to use.
>
> That would potentially reduce TCs and also give us the testing that
> would help prepare for working thru the migration/transition once BS
> is ready.

This is really what the subset functionality is for, although I think
John had started working on a feature in this area that would let the
subset functionality go across the rados configuration options while
guaranteeing full combinatorial explosion on the FS tests.
-Greg

>
> Brett
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
