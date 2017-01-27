From: Ming Lin <minggr@gmail.com>
Subject: code question: PGQueueable VS OpRequestRef
Date: Thu, 26 Jan 2017 23:41:02 -0800
Message-ID: <CAF1ivSYfmH9hezSc-Vcqdd7nU6y33TDZ1E9KVHm-XJRz+1w5dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f172.google.com ([209.85.223.172]:36441 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754135AbdA0HlD (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 27 Jan 2017 02:41:03 -0500
Received: by mail-io0-f172.google.com with SMTP id j13so55092230iod.3
        for <ceph-devel@vger.kernel.org>; Thu, 26 Jan 2017 23:41:03 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

void PG::queue_op(OpRequestRef& op)
{
...
  osd->op_wq.queue(make_pair(PGRef(this), op));


class OSDService {
....
  ShardedThreadPool::ShardedWQ < pair <PGRef, PGQueueable> > &op_wq;

"op" is of type OpRequestRef, but op_wq second is of type PGQueueable

How does this work? Is "PGQueueable" same as "OpRequestRef"?

Thanks.
