From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: Fw: XFS on RBD deadlock
Date: Tue, 7 Nov 2017 14:21:54 +0100
Message-ID: <CAOi1vP-JQ4o7UQGD-EVFCH3PFi_a_W9b_q-0u9aLZ-FcYPRT5g@mail.gmail.com>
References: <199f2d4449ab4445a2fc9bd366a7f472@sap.com> <5f20f87b0ee243d9a61e852fe72aaf3f@sap.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f175.google.com ([209.85.223.175]:48979 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751726AbdKGNVz (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Nov 2017 08:21:55 -0500
Received: by mail-io0-f175.google.com with SMTP id d66so2068379ioe.5
        for <ceph-devel@vger.kernel.org>; Tue, 07 Nov 2017 05:21:55 -0800 (PST)
In-Reply-To: <5f20f87b0ee243d9a61e852fe72aaf3f@sap.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Brennecke, Simon" <simon.brennecke@sap.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "Schneider, Robert" <robert.schneider03@sap.com>

On Tue, Nov 7, 2017 at 11:10 AM, Brennecke, Simon
<simon.brennecke@sap.com> wrote:
> Hi guys,
>
> I have a question regarding an old email which I found via google on the mailling list:
>
> https://www.spinics.net/lists/ceph-devel/msg33806.html
>
> The issue described there is pretty much what we are seeing on some of our servers.
> As it appears the kernel runs out of memory while writing back data to a XFS formatted RBD (actually the root volume).
> The kernel version we are using is 4.1.42 - outdated, I know, but we plan on upgrading if it helps the issue.
>
>
> Now my question is: Was the issue fixed? Or is disabling the signature still the only option?

Hi Simon,

Yes, it was fixed in 4.10, and backported to 4.9.z.

> Also it would be interessting if it only affects XFS, or if other filesystems suffer from the same issue.

It affected all file systems -- the bug was in the block driver.

Thanks,

                Ilya
