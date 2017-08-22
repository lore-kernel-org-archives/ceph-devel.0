From: John Spray <jspray@redhat.com>
Subject: Re: needs-backport label on github/ceph/ceph
Date: Tue, 22 Aug 2017 16:12:18 +0100
Message-ID: <CALe9h7cvEeD27eyL8rMTsbfwzXvX20RebMSDkBm+=F0kKzVBMA@mail.gmail.com>
References: <CAJE9aONVUvVCuKEdrLxNf8Z1YEard8ZoT9wy+tdzgCn9UTQb-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f53.google.com ([209.85.218.53]:35550 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932913AbdHVPMj (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Aug 2017 11:12:39 -0400
Received: by mail-oi0-f53.google.com with SMTP id r200so52872762oie.2
        for <ceph-devel@vger.kernel.org>; Tue, 22 Aug 2017 08:12:39 -0700 (PDT)
In-Reply-To: <CAJE9aONVUvVCuKEdrLxNf8Z1YEard8ZoT9wy+tdzgCn9UTQb-Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kefu chai <tchaikov@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Aug 22, 2017 at 4:09 PM, kefu chai <tchaikov@gmail.com> wrote:
> i noticed that we have a new label named "needs-backport" [0]? could
> you shed some light on how we are supposed to use it? i thought we
> were going to cherry-pick all PRs with this label merged after the
> luminous was forked. but seems we are still marking PRs should be
> included by luminous with the "luminous" milestone. so i have no clues
> now =(

I'm curious too -- I believe the authoriative way to mark something
for backport is in a tracker ticket, so a separate label probably
isn't needed?

John

>
> cheers,
>
> ---
> [0] https://github.com/ceph/ceph/pulls?q=label%3Aneeds-backport
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
