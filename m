From: Barclay Jameson <almightybeeij@gmail.com>
Subject: Bug?
Date: Fri, 10 Apr 2015 13:27:47 -0500
Message-ID: <CAMzumdaqedD8ANCESRLE44rsA0McwJA32VghpGzDYNgSw4bSqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f170.google.com ([209.85.220.170]:33048 "EHLO
	mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756075AbbDJS1s (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Apr 2015 14:27:48 -0400
Received: by qkx62 with SMTP id 62so40522278qkx.0
        for <ceph-devel@vger.kernel.org>; Fri, 10 Apr 2015 11:27:47 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Watching osd pool stats (watch --interval=.5 -d 'ceph osd pool stats')
while restarting 1/3 of my OSDs give some odd numbers:

pool cephfs_data id 1
  -768/9 objects degraded (-8533.333%)
  recovery io 18846 B/s, 1 objects/s
  client io 15356 B/s wr, 2 op/s

pool cephfs_metadata id 2
  -1/0 objects degraded (-inf%)
