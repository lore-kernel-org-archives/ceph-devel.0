From: Paul Chiang <paul_chiang@tcloudcomputing.com>
Subject: mkmonfs error
Date: Tue, 11 May 2010 09:53:05 +0800
Message-ID: <AANLkTin_nfsvA5jqFQ5BhsuzI1IVLmU2ubk6YKPTFagX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f46.google.com ([74.125.82.46]:34406 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754055Ab0EKBxJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 10 May 2010 21:53:09 -0400
Received: by wwa36 with SMTP id 36so2078579wwa.19
        for <ceph-devel@vger.kernel.org>; Mon, 10 May 2010 18:53:05 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,

I'm getting an error with mkmonfs while trying to expand the monitor
cluster as per the instructions on the wiki.

The error seems to originate from line 951~970 of Monitor.cc

Suppose we start with map epoch 3:
1. create_pending() increments the epoch to 4
2. create_initial() then sets it back to 3
3. encode_pending() finds 3+1 != 3, throws an error and dies

Not sure if this is a bug or there's something wrong with my proceedure.

Thanks in advance,
Paul Chiang

P.S. I'm using the unstable branch
