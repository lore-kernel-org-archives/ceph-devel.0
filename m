From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: Is it possible to restrict to map rbd image on different client
 hosts same time?
Date: Tue, 8 Aug 2017 13:39:23 +0200
Message-ID: <CAOi1vP9Aw4CM1U326_T3wDmpTa3ZEK9fX_7un676PBqdUf4Pkw@mail.gmail.com>
References: <95c441d8-007c-8e2e-3767-1b85ec8453f0@synesis.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f171.google.com ([209.85.217.171]:37838 "EHLO
        mail-ua0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752094AbdHHLjY (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Aug 2017 07:39:24 -0400
Received: by mail-ua0-f171.google.com with SMTP id f9so13335673uaf.4
        for <ceph-devel@vger.kernel.org>; Tue, 08 Aug 2017 04:39:23 -0700 (PDT)
In-Reply-To: <95c441d8-007c-8e2e-3767-1b85ec8453f0@synesis.ru>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Aleksei Gutikov <aleksey.gutikov@synesis.ru>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Aug 8, 2017 at 11:42 AM, Aleksei Gutikov
<aleksey.gutikov@synesis.ru> wrote:
> Hello
>
> I've just created a bug about list of watchers of rbd image and list of
> clients actually using this rbd image: http://tracker.ceph.com/issues/20943
>
> During reproducing of this bug several questions raised:
>
> 1) Does watcher in rbd status output should be treated as 100% reliable mark
> that disk was mapped?

No.  A watch generally means that the image is "open" in rw mode, but
not necessarily by the kernel client.  rbd CLI tool opens images in
rw mode when performing maintenance operations, you can do it yourself
through the API, there are various external daemons, etc.

>
> 2) And in other way: Does watcher absence should be treated as 100% reliable
> mark that disk was not mapped?

No.  A watch can be temporarily lost and you can catch the client in
the process of reestablishing the watch.

>
> 3) And finally: Is it possible to restrict to map disk on several clients in
> the same time (exclusive mapping)?

Yes.  Use "rbd map -o exclusive" (supported since kernel 4.12).

Thanks,

                Ilya
