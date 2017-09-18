From: Blair Bethwaite <blair.bethwaite@gmail.com>
Subject: Re: Ceph RDMA Memory Leakage
Date: Mon, 18 Sep 2017 17:30:31 +1000
Message-ID: <CA+z5DsyuPjL6e3O2zS_CMdp3ij-F6kKLkcK3=7Dq0T9VX4po_w@mail.gmail.com>
References: <CAGRcXKaZJBFnTtDVKzPyfVyK3Wrnve0Un83TjAWq4opdGaT+yA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f170.google.com ([209.85.216.170]:49129 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751938AbdIRHax (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Sep 2017 03:30:53 -0400
Received: by mail-qt0-f170.google.com with SMTP id q8so6646288qtb.5
        for <ceph-devel@vger.kernel.org>; Mon, 18 Sep 2017 00:30:53 -0700 (PDT)
In-Reply-To: <CAGRcXKaZJBFnTtDVKzPyfVyK3Wrnve0Un83TjAWq4opdGaT+yA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jin Cai <caijin.laurence@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Haomai Wang <haomai@xsky.com>, adirl@mellanox.com

I don't have any specific feedback on the issue you've observed, but I
have a question about your config...

On 18 September 2017 at 16:09, Jin Cai <caijin.laurence@gmail.com> wrote:
>         ms_async_rdma_roce_ver = 1
>         ms_async_rdma_sl = 5
>         ms_async_rdma_dscp = 136

Doesn't the DSCP field only apply to IP traffic and therefore require
a "trust L3" QoS config, which would imply RoCE version 2? The setting
is probably irrelevant if you have configured the network for L2
flow-control and Ceph is using the correct RoCE GID, but I was
curious.

-- 
Cheers,
~Blairo
