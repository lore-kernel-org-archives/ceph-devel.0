From: liuchang0812 <liuchang0812@gmail.com>
Subject: Re: code question: PGQueueable VS OpRequestRef
Date: Fri, 27 Jan 2017 19:33:13 +0800
Message-ID: <CACKY0b8kB3FsG-vfRDXuZW=eXUD8R+HyWUZ6dCbpuJaJno=mUA@mail.gmail.com>
References: <CAF1ivSYfmH9hezSc-Vcqdd7nU6y33TDZ1E9KVHm-XJRz+1w5dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yb0-f194.google.com ([209.85.213.194]:33616 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932590AbdA0LdU (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 27 Jan 2017 06:33:20 -0500
Received: by mail-yb0-f194.google.com with SMTP id 123so22287618ybe.0
        for <ceph-devel@vger.kernel.org>; Fri, 27 Jan 2017 03:33:19 -0800 (PST)
In-Reply-To: <CAF1ivSYfmH9hezSc-Vcqdd7nU6y33TDZ1E9KVHm-XJRz+1w5dw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ming Lin <minggr@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi, Ming.

PGQueueable class has a constructor as: `PGQueueable(OpRequestRef
op)`, which does not have `explicit`, so CPP compiler translates
OpRequestRef to PGQueueable in `
osd->op_wq.queue(make_pair(PGRef(this), op));`, as `
osd->op_wq.queue(make_pair(PGRef(this), PGQueueable(op)));`



2017-01-27 15:41 GMT+08:00 Ming Lin <minggr@gmail.com>:
> void PG::queue_op(OpRequestRef& op)
> {
> ...
>   osd->op_wq.queue(make_pair(PGRef(this), op));
>
>
> class OSDService {
> ....
>   ShardedThreadPool::ShardedWQ < pair <PGRef, PGQueueable> > &op_wq;
>
> "op" is of type OpRequestRef, but op_wq second is of type PGQueueable
>
> How does this work? Is "PGQueueable" same as "OpRequestRef"?
>
> Thanks.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
