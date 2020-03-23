From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: mds: where is mdr->slave_commit called?
Date: Mon, 23 Mar 2020 12:34:08 +0800
Message-ID: <CAAM7YAnSxY8QkZWPLT=mDjjf4PVNd=vsi3zb3DEKKhEdivFXVA@mail.gmail.com>
References: <CAMWWNq-8H8JJsPdL1JC9pOKMQY9LawZDRxfKa7Ag8MWGJbBY5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt1-f170.google.com ([209.85.160.170]:45557 "EHLO
        mail-qt1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgCWEeV (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Mar 2020 00:34:21 -0400
Received: by mail-qt1-f170.google.com with SMTP id t17so506006qtn.12
        for <ceph-devel@vger.kernel.org>; Sun, 22 Mar 2020 21:34:20 -0700 (PDT)
In-Reply-To: <CAMWWNq-8H8JJsPdL1JC9pOKMQY9LawZDRxfKa7Ag8MWGJbBY5A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xinying Song <songxinying.ftd@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Sun, Mar 22, 2020 at 3:40 PM Xinying Song <songxinying.ftd@gmail.com> wrote:
>
> Hi, everyone:
> Could anybody give some tips about how `mdr->slave_commit` is called?
>
> As for `link_remote()`, steps are as follows:
> 1. master mds sends OP_(UN)LINKPREP to salve mds.
> 2. slave mds replys OP_LINKPREPACK to master mds after its journal has
> been flushed.
> 3. master mds continues to process the client request.
>
> I only find out there is a chance in MDCache::request_finish() that
> `mdr->slave_commit` will be called. However, after a successful
> journal flush, slave mds only sends an ACK to master mds and bypasses
> MDCache::request_finish().
> So when or where is `mdr->slave_commit` called?
>
> Thanks!

master calls MDCache::request_finsih(),
MDCache::request_drop_foreign_locks() sends
MMDSSlaveRequest::OP_FINISH message to slaves.  slaves call
MDCache::request_finsih() when receiving the message.
