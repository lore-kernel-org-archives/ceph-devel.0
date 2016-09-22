From: Samuel Just <sjust@redhat.com>
Subject: Re: async messenger --debug-ms=1 too verbose?
Date: Thu, 22 Sep 2016 10:40:22 -0700
Message-ID: <CAN=+7FXv2JMxO3Y1haFxZamL-hGAkpnafAi-KrXsEdbYL1Fadw@mail.gmail.com>
References: <CALe9h7cUtAL7Rw5r01=d=KXwmG_Fwc-ULjKBuY1NUsHyKSijcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f176.google.com ([209.85.220.176]:33168 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965694AbcIVRkY (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Sep 2016 13:40:24 -0400
Received: by mail-qk0-f176.google.com with SMTP id g67so23282528qkd.0
        for <ceph-devel@vger.kernel.org>; Thu, 22 Sep 2016 10:40:23 -0700 (PDT)
In-Reply-To: <CALe9h7cUtAL7Rw5r01=d=KXwmG_Fwc-ULjKBuY1NUsHyKSijcw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>, "Wang, Haomai" <haomaiwang@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

I hadn't noticed, but I think the convention of having debug ms = 1
print outgoing and incoming messages only is probably the right thing.
-Sam

On Thu, Sep 22, 2016 at 10:31 AM, John Spray <jspray@redhat.com> wrote:
> Hi all,
>
> Minor thing, I'm finding --debug-ms=1 harder to read with my squishy
> mammal brain since we switched to async messenger (comparison here:
> http://pastebin.com/LcG2Z91m).  There is just more noise in the screen
> now and it's harder to read as a list of messages.
>
> Any thoughts?  Was it kind of accidental or is there a strong need for
> the extra stuff?
>
> Cheers,
> John
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
