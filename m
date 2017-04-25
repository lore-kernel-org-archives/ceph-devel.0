From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: cephfs issue, get_reply data > preallocated
Date: Tue, 25 Apr 2017 09:51:04 +0800
Message-ID: <CAAM7YAkdQzoX9=KodrGfcyCZFxbefw741XoPCKp_mhPFcE82jA@mail.gmail.com>
References: <CAGbvivLexKgh7L5hhLXjWSJiPj-nEwuxC4O3Hefxt5WGWjHpgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f46.google.com ([209.85.213.46]:32950 "EHLO
        mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S979753AbdDYBvG (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Apr 2017 21:51:06 -0400
Received: by mail-vk0-f46.google.com with SMTP id j127so48037760vkh.0
        for <ceph-devel@vger.kernel.org>; Mon, 24 Apr 2017 18:51:05 -0700 (PDT)
In-Reply-To: <CAGbvivLexKgh7L5hhLXjWSJiPj-nEwuxC4O3Hefxt5WGWjHpgw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Apr 24, 2017 at 11:51 PM, Wyllys Ingersoll
<wyllys.ingersoll@keepertech.com> wrote:
> Ubuntu 16.04.1
> Ceph 10.2.5
> Linux 4.9.10 kernel
>
> We are having problems accessing some files in cephfs, the process
> reading the files become hung when trying to read them (md5sum, for
> example).  When these hangups occur, there are messages in the system
> logs that look like this:
>
> "libceph: get_reply osd6 tid 55 data 1305852 > preallocated 1048576, skipping"
>
> The cluster shows healthy status and all OSD are reporting as up/up.
>
> Wondering if our hanging read issues are related to the messages being
> reported, they seem to be since we only see the messages once we
> encounter the issue reading the files.

http://tracker.ceph.com/issues/19189. the fix has been merged into 4.9.14 kernel

Regards
Yan, Zheng

>
> Wyllys Ingersoll
> Keeper Technology, LLC
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
