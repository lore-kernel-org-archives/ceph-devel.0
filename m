From: wenjunh <huangwenjun310@gmail.com>
Subject: My test on newstore show much poorer performance than filestore
Date: Thu, 27 Aug 2015 16:51:45 +0800
Message-ID: <55DECFA1.7050203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:32938 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751625AbbH0Ivt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Aug 2015 04:51:49 -0400
Received: by pacti10 with SMTP id ti10so19028858pac.0
        for <ceph-devel@vger.kernel.org>; Thu, 27 Aug 2015 01:51:49 -0700 (PDT)
Received: from [10.3.156.4] ([203.205.141.123])
        by smtp.gmail.com with ESMTPSA id m2sm1605042pdr.64.2015.08.27.01.51.47
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Aug 2015 01:51:48 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi
I have a try of the newstore to explore its performance, which shows its performance is much poorer than filestore.

I test my cluster using fio, Here is the comparison of the two store with randread & randwrite scenario:

rw=randread, bs=4K, numjobs=1:
newstore: bw=2280.7KB/s, iops=570
filestore: bw=4846.6KB/s, iops=1211

rw=randwrite, bs=4K, numjobs=1:
newstore: bw=32999 B/s, iops=8
filestore: bw=250978 B/s, iops=61
The two tests are performed using the same hardware, but newstore is much poorer than filestore. From the view of the community, newstore is the next default backend store in Ceph, but why its performance so poor. Could someone tell me why?

Thanks
wenjunh
