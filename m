From: "Yan, Zheng " <yanzheng@21cn.com>
Subject: Memory leak bug in the latest master
Date: Sat, 3 Nov 2012 23:38:48 +0800
Message-ID: <CAAM7YAkMNe-0ig4DcumUHA++0gkqArwj-SYMzoqN7PDU2W9-OA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:46671 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755404Ab2KCPiu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 3 Nov 2012 11:38:50 -0400
Received: by mail-la0-f46.google.com with SMTP id h6so3213816lag.19
        for <ceph-devel@vger.kernel.org>; Sat, 03 Nov 2012 08:38:48 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, reiher@inktank.com

Hi Everybody,

I found there is a memory leak bug in the latest master (c51e1f9b64).
The bug affects
both ceph-osd and ceph-mds. git bisect show bad commit could be any of:
27974c4621188cf403a558d7f01f7409539158f3
cc5d05bc294711155324d21a8bdba574847f881e
2b56e800b58ed8322428f24ff9b9fafb2e35a01c
7cce4d41548bde68b93bfbc902a6eb1cd25bfcb7
1166f3a085e4a6bb84a976646d778df913bde648

Regards
