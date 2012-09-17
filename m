From: Vladimir Bashkirtsev <vladimir@bashkirtsev.com>
Subject: RBD image max simultaneous mounts
Date: Mon, 17 Sep 2012 12:13:07 +0930
Message-ID: <50568E3B.3060403@bashkirtsev.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.logics.net.au ([150.101.56.178]:46390 "EHLO
	mail.logics.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752940Ab2IQCoR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 16 Sep 2012 22:44:17 -0400
Received: from x.logics.net.au (gw.logics.net.au [150.101.235.251] (may be forged))
	(authenticated bits=0)
	by mail.logics.net.au (8.14.5/8.14.1) with ESMTP id q8H2h5Fl001640
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO)
	for <ceph-devel@vger.kernel.org>; Mon, 17 Sep 2012 12:13:05 +0930
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Dear devs,

We just had an incident where two instances of the same VM started up on 
different hosts and mounted the same RBD image. Image had ext4 partition 
and it became corrupted quickly. Therefore it would be good to have some 
setting in RBD info like max_simultaneous_mounts which will dictate how 
many simultaneous mounts of the same RBD image may be in existence. 
Obviously such glusterfs would not have such issue in RBD image but old 
trusty extfs fails miserably. It may be hard to implement in ceph due to 
distributed nature. Then basic check in QEMU-RBD driver would be good as 
well.

Regards,
Vladimir
