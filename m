From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] libceph: wake up sync waiter when unregistering request
Date: Tue, 29 Nov 2016 14:54:21 +0100
Message-ID: <CAOi1vP8ieneOG-UhTysHNoOvoZ3_kcV_x7zqw9p3BSUpMLK_9Q@mail.gmail.com>
References: <20161129114921.62964-1-zyan@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f42.google.com ([209.85.213.42]:32942 "EHLO
        mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755393AbcK2NyW (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 29 Nov 2016 08:54:22 -0500
Received: by mail-vk0-f42.google.com with SMTP id 137so91982778vkl.0
        for <ceph-devel@vger.kernel.org>; Tue, 29 Nov 2016 05:54:22 -0800 (PST)
In-Reply-To: <20161129114921.62964-1-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Nov 29, 2016 at 12:49 PM, Yan, Zheng <zyan@redhat.com> wrote:
> Current code does not wake up sync waiter if osd replies error
> or the request does not want ondisk ack.

Hi Zheng,

Did you mean to write "and" instead of "or" - "if osd replies error
*and* the request does not want ondisk ack"?

Thanks,

                Ilya
