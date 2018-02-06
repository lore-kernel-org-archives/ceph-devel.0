From: Xuehan Xu <xxhdx1985126@gmail.com>
Subject: Re: LOCK_SYNC_MIX state makes "getattr" operations extremely slow
 when there are lots of clients issue writes or reads to the same file
Date: Tue, 6 Feb 2018 14:44:25 +0800
Message-ID: <CAJACTud5FdaoybJ7W_CTQCRqZVBghHMwqGbsSyX3SZEpOvmN+A@mail.gmail.com>
References: <CAJACTudeJCqQiEOxuSxfFsH2KdnSeors-6cCvx9jh-Nn8u6huA@mail.gmail.com>
 <CAAM7YA=_+WQc+_y9ukX68DPzFBUotEcGXny1BvuHekvs_Q1kXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ot0-f170.google.com ([74.125.82.170]:35872 "EHLO
        mail-ot0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752190AbeBFGo0 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Feb 2018 01:44:26 -0500
Received: by mail-ot0-f170.google.com with SMTP id m20so777539otf.3
        for <ceph-devel@vger.kernel.org>; Mon, 05 Feb 2018 22:44:26 -0800 (PST)
In-Reply-To: <CAAM7YA=_+WQc+_y9ukX68DPzFBUotEcGXny1BvuHekvs_Q1kXQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <ukernel@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

> Getattr request for stat(2) needs to get inode size. MDS revokes Fw
> capability from the writer, to prevent writer from changing inode size
> at the same time. This is price of mantaining POSIX-compliant .

Thanks, Zheng Yan:-)

In our case, there is only one client want the "Fw" capability, most
of the clients just needs "Fscr". However, as LOCK_MIX state allows
only "Frwl", CInode::filelock had to wait in LOCK_SYNC_MIX state for
those tens of READ clients to release "Fsc" caps, which led to the
long wait and inefficient processing of getattr requests. We think
waiting for clients to release "Fsc" in this case might not be
necessary, is this right?
