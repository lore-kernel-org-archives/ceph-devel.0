From: John Spray <jspray@redhat.com>
Subject: Re: Get IO request execution profile
Date: Mon, 23 Jan 2017 12:54:59 +0000
Message-ID: <CALe9h7ePYu5_JYTU9NppGhsvUr5FQJJMTw5kcj1yb2kyF+MXHQ@mail.gmail.com>
References: <CACxKWaxt5+9BiQEM-fG=iHkwHJsPYK9EukNoyPtPNQunq65adw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ot0-f178.google.com ([74.125.82.178]:34217 "EHLO
        mail-ot0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750703AbdAWMzU (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Jan 2017 07:55:20 -0500
Received: by mail-ot0-f178.google.com with SMTP id f9so101482730otd.1
        for <ceph-devel@vger.kernel.org>; Mon, 23 Jan 2017 04:55:19 -0800 (PST)
In-Reply-To: <CACxKWaxt5+9BiQEM-fG=iHkwHJsPYK9EukNoyPtPNQunq65adw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Konstantin Danilov <kdanilov@mirantis.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Jan 23, 2017 at 12:36 PM, Konstantin Danilov
<kdanilov@mirantis.com> wrote:
> Hi all,
>
> is there a way to get something like 'dump historic ops' for particular request?
> Probably from client side. Ideally I'd like to send a normal IO
> request with special
> flag and get execution profile in response metadata.
> If it's not possible right now - is this an interesting feature to
> implement, or I miss
> something and it's useless?

Potentially interesting idea, although it's not obvious to me why it's
useful to have this dumped on the client rather than the server?
Would be it equally useful to be able to tag a specific client on the
server side to have its requests dumped like this?

John

>
> Thanks
>
> --
> Kostiantyn Danilov aka koder.ua
> Principal software engineer, Mirantis
>
> skype:koder.ua
> http://koder-ua.blogspot.com/
> http://mirantis.com
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
