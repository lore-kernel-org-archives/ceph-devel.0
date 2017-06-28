From: Abhishek L <abhishek.lekshmanan@gmail.com>
Subject: Re: Minor doc nits for Luminous upgrade
Date: Wed, 28 Jun 2017 06:23:45 +0200
Message-ID: <CAEw75dMcOjzfZFYWhPpo4yRfpU7ReN6a_gg5a7vKbm61Bn=X9A@mail.gmail.com>
References: <a29ea0cb-a1b8-9c26-ae4c-9ff91ba6a917@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:38870 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750842AbdF1EXq (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 28 Jun 2017 00:23:46 -0400
Received: by mail-wm0-f42.google.com with SMTP id b184so45471544wme.1
        for <ceph-devel@vger.kernel.org>; Tue, 27 Jun 2017 21:23:46 -0700 (PDT)
In-Reply-To: <a29ea0cb-a1b8-9c26-ae4c-9ff91ba6a917@catalyst.net.nz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Jun 28, 2017 at 3:07 AM, Mark Kirkwood
<mark.kirkwood@catalyst.net.nz> wrote:
> I've just done an upgrade from Jewel to Luminous following
> http://docs.ceph.com/docs/master/release-notes/#upgrade-from-jewel-or-kraken
> . Generally nice and easy to follow, but there are a couple of (fortunately
> very obvious) instructions that are wrong:
>
> 1/ Mon feature list
>
> <# ceph mon feature ls
>># ceph mon feature list

While the final feature of release and the next RC will feature the
`ls` version, this  RC still had the older list version, I've made a
correction to the blog entry.

> 2/ Osd restart
>
> <# systemctl ceph-osd.target
>># systemctl restart ceph-osd.target

Ah thanks, there seem to be a bunch of these, good catch
> Otherwise all good.
>
> Cheers
>
>
> Mark
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
