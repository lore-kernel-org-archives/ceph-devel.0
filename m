From: =?UTF-8?B?5rGg5L+h5rO9?= <xmdxcxz@gmail.com>
Subject: ceph encoding optimization
Date: Wed, 4 Nov 2015 23:00:04 +0800
Message-ID: <CANE=7sURCs6VHCGAYMjXr2LMD7E6CfwqWkjYQopCOaQ-OzW65g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:34917 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932318AbbKDPAF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 Nov 2015 10:00:05 -0500
Received: by obctp1 with SMTP id tp1so41087222obc.2
        for <ceph-devel@vger.kernel.org>; Wed, 04 Nov 2015 07:00:04 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

hi, all:

     I am focus on the cpu usage of ceph now. I find the struct (such
as pg_info_t , transaction and so on) encode and decode exhaust too
much cpu resource.

     For now, we should encode every member variable one by one which
calling encode_raw finally. When there are many members, we should
encode it many times. But I think, we could reduce some in some cases.

     For example , struct A { int a; int b; int c }; ceph would
encoding int a , and then encode int b , finally int c. But for this
case , we could calling bufferlist.append((char *)(&a), sizeof(A))
because there are not padding bytes in this struct.

     I use the above optimization, the cpu usage of object_stat_sum_t
encoding decrease from 0.5% to 0% (I could not see any using perf
tools).

     This is only a case, so I think we could do similar optimization
other struct. I think we should pay attention to the padding in
struct.

-- +
Regards,
xinze
