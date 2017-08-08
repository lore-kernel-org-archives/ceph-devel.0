From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: Is it possible to restrict to map rbd image on different client
 hosts same time?
Date: Tue, 8 Aug 2017 18:57:39 +0200
Message-ID: <CAOi1vP8fQKxkQ3_qU7zT6acTBfMHiwn4ABUHayDafhZ1EO6DJg@mail.gmail.com>
References: <95c441d8-007c-8e2e-3767-1b85ec8453f0@synesis.ru>
 <CAOi1vP9Aw4CM1U326_T3wDmpTa3ZEK9fX_7un676PBqdUf4Pkw@mail.gmail.com> <f41f41fc-2a75-1584-80d3-f17e29d191a0@synesis.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f41.google.com ([209.85.213.41]:38306 "EHLO
        mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752059AbdHHQ5k (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Aug 2017 12:57:40 -0400
Received: by mail-vk0-f41.google.com with SMTP id g189so15841763vke.5
        for <ceph-devel@vger.kernel.org>; Tue, 08 Aug 2017 09:57:40 -0700 (PDT)
In-Reply-To: <f41f41fc-2a75-1584-80d3-f17e29d191a0@synesis.ru>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Aleksei Gutikov <aleksey.gutikov@synesis.ru>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Aug 8, 2017 at 6:35 PM, Aleksei Gutikov
<aleksey.gutikov@synesis.ru> wrote:
>
> Ilya, thank you for your suggestion, it works for me.
>
> But during testing I realized that what actually I need is not just
> exclusive lock, but some kind of idempotent exclusive lock.
> I mean the last who exclusively mapped image should kick out others.
> Is it possible now?

No, I don't think there is anything like that out of the box.

What are you trying to accomplish?

Thanks,

                Ilya
