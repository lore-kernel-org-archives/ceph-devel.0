From: Casier David <casierdavid@gmail.com>
Subject: Perfomance CPU and IOPS
Date: Sun, 24 May 2015 13:21:40 +0200
Message-ID: <5561B444.6060108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:38277 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750927AbbEXLWc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 24 May 2015 07:22:32 -0400
Received: by wichy4 with SMTP id hy4so25846746wic.1
        for <ceph-devel@vger.kernel.org>; Sun, 24 May 2015 04:22:31 -0700 (PDT)
Received: from [192.168.1.97] (84.197.151.77.rev.sfr.net. [77.151.197.84])
        by mx.google.com with ESMTPSA id bm9sm11691236wjc.21.2015.05.24.04.22.30
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 May 2015 04:22:30 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello everybody,
I have some suggestions to improve the Ceph performance with in case of 
using Rados Block Device.

On FileStore :
  - Remove all metadata in HDD and used omap on SSD. This reduce IOPS 
and increases throughput.
  - Remove journal, thread "sync_entry", and write directly in 
queue_transaction.

To compensate journal, you could use Cache Tier Ceph.

ceph-osd must be with less Thread and Lock.
With 1 OSD for 1 HDD, i think Lock is necessary only for scrub, recovery 
or other background job.
And only one thread with the use of libaio.

I think Ceph-OSD should be very light.
Potentially with direct writing aftergiven the transmitted data to other 
OSD from map.
In this case, a lot of ceph-osd could work on the same server.

Actually, i work on the repository https://www.github.com/dcasier/ceph.
You could see start works on FileStore.*
But potentially not safe.

David.
