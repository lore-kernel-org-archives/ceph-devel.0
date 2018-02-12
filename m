From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: osdmap consistency during incremental applying in kernel client
Date: Mon, 12 Feb 2018 11:52:50 +0100
Message-ID: <CAOi1vP-HJqO00X8ndS6QnGFNUeK0gqu-AYnWH3Oo8+L_Zmg-dw@mail.gmail.com>
References: <302D379F-727B-489C-B257-633CF16577C8@icloud.com>
 <CAOi1vP9j=hBeZ73oguLBuXp-YDE5tk3h=HU5_MDJgOxY300kFQ@mail.gmail.com> <58F2BA12-2C4D-4C35-BC8D-F4896D22F41C@icloud.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f173.google.com ([209.85.223.173]:40651 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933798AbeBLKwv (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Feb 2018 05:52:51 -0500
Received: by mail-io0-f173.google.com with SMTP id t22so16791881ioa.7
        for <ceph-devel@vger.kernel.org>; Mon, 12 Feb 2018 02:52:51 -0800 (PST)
In-Reply-To: <58F2BA12-2C4D-4C35-BC8D-F4896D22F41C@icloud.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chengguang Xu <cgxu519@icloud.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Feb 12, 2018 at 11:44 AM, Chengguang Xu <cgxu519@icloud.com> wrote:
> Hi Ilya
>
> Thanks for reply, please let me ask one more question, is there
> no side-effect to ceph cluster side?

No, there shouldn't be any.

Thanks,

                Ilya
