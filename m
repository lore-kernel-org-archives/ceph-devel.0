From: Li Wang <liwang@ubuntukylin.com>
Subject: 4x write amplification?
Date: Wed, 10 Jul 2013 10:08:37 +0800
Message-ID: <51DCC225.1050700@ubuntukylin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m59-178.qiye.163.com ([123.58.178.59]:58407 "EHLO
	m59-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753627Ab3GJCIr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Jul 2013 22:08:47 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>

Hi,
   We did a simple throughput test on Ceph with 2 OSD nodes configured
with one replica policy. For each OSD node, the throughput measured by 
'dd' run locally is 117MB/s. Therefore, in theory, the two OSDs could 
provide 200+MB/s throughput. However, using 'iozone' from clients we 
only get a peak throughput at around 40MB/s. Is that because a write 
will incur 2 replica * 2 journal write? That is, writing into journal
and replica doubled the traffic, respectively, which results in a total
4x write amplification. Is that true, or our understanding is wrong,
and some performance tuning hint?

Cheers,
Li Wang


