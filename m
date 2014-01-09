From: Haomai Wang <haomaiwang@gmail.com>
Subject: Proposal for adding disable FileJournal option
Date: Thu, 9 Jan 2014 16:13:24 +0800
Message-ID: <08E73B64-A538-4A34-B0F6-1D7A2A00A8AF@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:65319 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751201AbaAIIOG convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Jan 2014 03:14:06 -0500
Received: by mail-pa0-f52.google.com with SMTP id ld10so2990844pab.25
        for <ceph-devel@vger.kernel.org>; Thu, 09 Jan 2014 00:14:05 -0800 (PST)
Received: from [10.0.0.3] (li653-121.members.linode.com. [106.186.118.121])
        by mx.google.com with ESMTPSA id sg1sm7871931pbb.16.2014.01.09.00.14.01
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 09 Jan 2014 00:14:05 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,

We know FileJournal plays a important role in FileStore backend, it can
hugely reduce write latency and improve small write operations.

But in practice, there exists exceptions such as we already use FlashCache or cachepool(although it's not ready).

If cachepool enabled, we may use use journal in cache_pool but may
not like to use journal in base_pool. The main reason why drop journal
in base_pool is that journal take over a single physical device and waste
too much in base_pool.

Like above, if I enable FlashCache or other cache, I'd not like to enable
journal in OSD layer.

So is it necessary to disable journal in special(not really special) case?

Best regards,
Wheats



