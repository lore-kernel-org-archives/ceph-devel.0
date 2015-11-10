From: =?UTF-8?B?5rGg5L+h5rO9?= <xmdxcxz@gmail.com>
Subject: why ShardedWQ in osd using smart pointer for PG?
Date: Tue, 10 Nov 2015 23:19:29 +0800
Message-ID: <CANE=7sUynZ+uvM6sR_WjvUnbLxfwj6LQDMWwonCmi2nM21ZEuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:33693 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752580AbbKJPTa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Nov 2015 10:19:30 -0500
Received: by obbww6 with SMTP id ww6so139995423obb.0
        for <ceph-devel@vger.kernel.org>; Tue, 10 Nov 2015 07:19:29 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

hi, all:

     op_wq is declared as ShardedThreadPool::ShardedWQ < pair <PGRef,
OpRequestRef> > &op_wq. I do not know why we should use PGRef in this?

     Because the overhead of the smart pointer is not small. Maybe the
raw point PG* is also OK?

     If op_wq is changed to ShardedThreadPool::ShardedWQ < pair <PG*,
OpRequestRef> > &op_wq (using raw point)

     the latency for PrioritizedQueue:;enqueue decrease from 3.38us -> 1.89us

     the latency for PrioritizedQueue:;dequeue decrease from 3.44us -> 1.65us

     Is this make sense to you?

-- 
Regards,
xinze
