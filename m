From: Xuehan Xu <xxhdx1985126@gmail.com>
Subject: Re: LOCK_SYNC_MIX state makes "getattr" operations extremely slow
 when there are lots of clients issue writes or reads to the same file
Date: Thu, 8 Feb 2018 17:54:15 +0800
Message-ID: <CAJACTufGU+tDE4G_9xNqJ7fFiixKNTgBqJ4EZv0obQz3t+WGeA@mail.gmail.com>
References: <CAJACTudeJCqQiEOxuSxfFsH2KdnSeors-6cCvx9jh-Nn8u6huA@mail.gmail.com>
 <CAAM7YA=_+WQc+_y9ukX68DPzFBUotEcGXny1BvuHekvs_Q1kXQ@mail.gmail.com>
 <CAJACTud5FdaoybJ7W_CTQCRqZVBghHMwqGbsSyX3SZEpOvmN+A@mail.gmail.com>
 <CAJACTucSQM8hrCfj0aY4nsVhyFeB+PwxHGOfwxao5tnqxwDTtg@mail.gmail.com>
 <CAJACTucKaWvtAKKnPQVQ3EhkeEXTncJgFu2uJ6V2T0NBpkqqqg@mail.gmail.com>
 <CAAM7YA=pvgX2ty0B=FDsixp_A52rfvKVt2FUp-D8jJEK8z1V8A@mail.gmail.com> <CAJACTudf7qzDYqtXdC5rF5KPMMDvBk0Rqcrau=SU=7tnhtFAAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f54.google.com ([209.85.215.54]:40122 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751910AbeBHJyS (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Feb 2018 04:54:18 -0500
Received: by mail-lf0-f54.google.com with SMTP id i24so2410280lfc.7
        for <ceph-devel@vger.kernel.org>; Thu, 08 Feb 2018 01:54:17 -0800 (PST)
In-Reply-To: <CAJACTudf7qzDYqtXdC5rF5KPMMDvBk0Rqcrau=SU=7tnhtFAAg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <ukernel@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

> Hi, Zheng Yan, thanks for your reply:-)
>
> However, I think as long as MDS processes client requests in the order
> of their arrival, writer shouldn't be starved, right?
> Actually, in our case, the current mechanism starves writers as
> illustrated in http://tracker.ceph.com/issues/22925

Sorry, it should be http://tracker.ceph.com/issues/22925#note-3
