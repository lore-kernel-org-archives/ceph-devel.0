From: John Spray <jspray@redhat.com>
Subject: Re: Persistent storage for Mgr Modules
Date: Mon, 29 Jan 2018 09:55:21 +0000
Message-ID: <CALe9h7fmH4=W6ZzQ3csyk1v9=8frNwcLNNdphQB0-=P0xkXc9Q@mail.gmail.com>
References: <a813a336-1e16-1d34-cf8b-7179cf04dba0@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:38595 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750913AbeA2Jzo (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Jan 2018 04:55:44 -0500
Received: by mail-wm0-f46.google.com with SMTP id 141so32242301wme.3
        for <ceph-devel@vger.kernel.org>; Mon, 29 Jan 2018 01:55:43 -0800 (PST)
In-Reply-To: <a813a336-1e16-1d34-cf8b-7179cf04dba0@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Jan 29, 2018 at 9:12 AM, Wido den Hollander <wido@42on.com> wrote:
> Hi,
>
> I'm still working on the 'brag' module for the Mgr to send out a report
> every X interval back to the Ceph project so that we get a feeling of how
> people use Ceph.
>
> I'd like to store a timestamp of the last report send and then wait for it
> to expire before sending a new one.
>
> The interval will be something like a week by default and I'd like to store
> it somewhere persistent.
>
> Obviously I can store it in a local variable, but if the Mgr fails or is
> restarted so is the module and thus that data is lost.
>
> Is it OK to use the config-key for this? It's not really configuration, but
> is it allowed to store such values in there?

Yep!

The "config" naming is a strong hint to programmers that this is not
for bulk data, but ultimately it's all just bytes :-)

John

>
> Thanks,
>
> Wido
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
