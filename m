From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Testing fuse implementation.
Date: Mon, 20 Mar 2017 12:57:16 -0400
Message-ID: <CAJ4mKGYPLYYTooHYY8KayXxCub1OtmBVXTdXgp+5MLxo7RkzMA@mail.gmail.com>
References: <2a2aa01a-4511-1bc2-0575-051f626575ad@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:36449 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752346AbdCTR12 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Mar 2017 13:27:28 -0400
Received: by mail-oi0-f49.google.com with SMTP id r203so21530717oib.3
        for <ceph-devel@vger.kernel.org>; Mon, 20 Mar 2017 10:27:22 -0700 (PDT)
In-Reply-To: <2a2aa01a-4511-1bc2-0575-051f626575ad@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Mar 20, 2017 at 12:52 PM, Willem Jan Withagen <wjw@digiware.nl> wrote:
> Hi,
>
> Compiling ceph-fuse-fs on FreeBSD seemed like a few (1)  very tiny
> change, and I'll need to update the install-deps for some extra packages.
> But when I run the test-set there is not much that I see that gets
> tested specifically for the fuse implementation.
>
> So that is hidden somewhere else...
> Can somebody give me a pointer?

There's not really anything in make check for it; we rely on the
libcephfs tests for smoking out problems there.

In teuthology ceph-fuse gets all kinds of proper filesystem tests run
on it. Just pick whatever's convenient on BSD? (On Linux I'd recommend
the pjd filesystem test suite, but I don't know if that's
BSD-compatible or not.)
-Greg

>
> Thanx,
> --WjW
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
