From: Vladimir Bashkirtsev <vladimir@bashkirtsev.com>
Subject: Is there any way to throttle recovery?
Date: Mon, 03 Sep 2012 16:12:24 +0930
Message-ID: <50445150.7080804@bashkirtsev.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.logics.net.au ([150.101.56.178]:40758 "EHLO
	mail.logics.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752366Ab2ICGme (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Sep 2012 02:42:34 -0400
Received: from x.logics.net.au (gw.logics.net.au [150.101.235.251] (may be forged))
	(authenticated bits=0)
	by mail.logics.net.au (8.14.5/8.14.1) with ESMTP id q836gOjR007935
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO)
	for <ceph-devel@vger.kernel.org>; Mon, 3 Sep 2012 16:12:25 +0930
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hello devs,

I have noticed that while ceph recovering from OSD failure RBD 
performance becomes dismal. Judging by load on the net ceph attempts to 
shuffle around huge amount of data leaving virtually no bandwidth for 
normal operations. Is there any way to throttle recovery process? 
Network throttling is out of question as it will slow everything down. 
So I guess ceph should have (or already has) a setting which says do not 
recover faster than X.

Regards,
Vladimir
