From: Xuehan Xu <xxhdx1985126@gmail.com>
Subject: Re: LOCK_SYNC_MIX state makes "getattr" operations extremely slow
 when there are lots of clients issue writes or reads to the same file
Date: Fri, 9 Feb 2018 15:59:09 +0800
Message-ID: <CAJACTud76jU5kqGMUfYXA2H2SASjnP3DNF7XT=aA_X6f=V6txQ@mail.gmail.com>
References: <CAJACTudeJCqQiEOxuSxfFsH2KdnSeors-6cCvx9jh-Nn8u6huA@mail.gmail.com>
 <CAAM7YA=_+WQc+_y9ukX68DPzFBUotEcGXny1BvuHekvs_Q1kXQ@mail.gmail.com>
 <CAJACTud5FdaoybJ7W_CTQCRqZVBghHMwqGbsSyX3SZEpOvmN+A@mail.gmail.com>
 <CAJACTucSQM8hrCfj0aY4nsVhyFeB+PwxHGOfwxao5tnqxwDTtg@mail.gmail.com>
 <CAJACTucKaWvtAKKnPQVQ3EhkeEXTncJgFu2uJ6V2T0NBpkqqqg@mail.gmail.com>
 <CAAM7YA=pvgX2ty0B=FDsixp_A52rfvKVt2FUp-D8jJEK8z1V8A@mail.gmail.com>
 <CAJACTudf7qzDYqtXdC5rF5KPMMDvBk0Rqcrau=SU=7tnhtFAAg@mail.gmail.com>
 <CAJACTufGU+tDE4G_9xNqJ7fFiixKNTgBqJ4EZv0obQz3t+WGeA@mail.gmail.com> <CAAM7YAnKFsHdmXqwTpdm+-TsvjmumugQk9Esxwxw1uWGrpRJzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f53.google.com ([209.85.215.53]:37178 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751040AbeBIH7L (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Feb 2018 02:59:11 -0500
Received: by mail-lf0-f53.google.com with SMTP id f137so9996343lfe.4
        for <ceph-devel@vger.kernel.org>; Thu, 08 Feb 2018 23:59:10 -0800 (PST)
In-Reply-To: <CAAM7YAnKFsHdmXqwTpdm+-TsvjmumugQk9Esxwxw1uWGrpRJzg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <ukernel@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

> please try https://github.com/ukernel/ceph/commit/7db1563416b5559310dbbc834795b83a4ccdaab4

Hi, Zheng Yan.

Could you make a PR of this commit?
We really want to use this commit, however, without the approval of
the community, we won't have the courage to put this into our online
clusters.
Thank you:-)
