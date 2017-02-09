From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] libceph: Complete stuck requests to OSD with EIO
Date: Thu, 9 Feb 2017 15:27:04 +0100
Message-ID: <CAOi1vP-7hcHAaVcqvLAcu9vL4ohQW4u9XoGdg-d5AuaX7E19Dw@mail.gmail.com>
References: <4e080919-2df5-1b75-3c8a-3ae95eb8f08d@synesis.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f170.google.com ([209.85.217.170]:36518 "EHLO
        mail-ua0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753211AbdBIO1G (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Feb 2017 09:27:06 -0500
Received: by mail-ua0-f170.google.com with SMTP id 96so4021549uaq.3
        for <ceph-devel@vger.kernel.org>; Thu, 09 Feb 2017 06:27:05 -0800 (PST)
In-Reply-To: <4e080919-2df5-1b75-3c8a-3ae95eb8f08d@synesis.ru>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Artur Molchanov <artur.molchanov@synesis.ru>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Feb 9, 2017 at 2:04 PM, Artur Molchanov
<artur.molchanov@synesis.ru> wrote:
> From: Artur Molchanov <artur.molchanov@synesis.ru>
>
> Complete stuck requests to OSD with error EIO after osd_request_timeout
> expired.
> If osd_request_timeout equals to 0 (default value) then do nothing with
> hung requests (keep default behavior).
>
> Create RBD map option osd_request_timeout to set timeout in seconds. Set
> osd_request_timeout to 0 by default.

Hi Artur,

What is the use case?  What do you expect this timeout to be in your
environment?

I actually have a slightly more compact version of this somewhere,
which I deliberately excluded when updating the OSD client a few kernel
releases ago.  IIRC complete_request() wasn't meant to be called
arbitrarily, but we can probably fix that.

Thanks,

                Ilya
