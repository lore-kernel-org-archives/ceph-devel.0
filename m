From: =?ISO-8859-1?Q?Sz=E9kelyi?= Szabolcs <szekelyi@niif.hu>
Subject: [WRN] map e### wrongly marked me down or wrong addr
Date: Mon, 27 Feb 2012 17:59:01 +0100
Message-ID: <2230716.Iq9SpLVmvc@mranderson>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ki.iif.hu ([193.6.222.241]:50389 "EHLO mail.ki.iif.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753751Ab2B0Q7K (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 27 Feb 2012 11:59:10 -0500
Received: from bolha.lvs.iif.hu (bolha.lvs.iif.hu [193.225.14.181])
	by mail.ki.iif.hu (Postfix) with ESMTP id 57AD987A0E
	for <ceph-devel@vger.kernel.org>; Mon, 27 Feb 2012 17:59:08 +0100 (CET)
Received: from mail.ki.iif.hu ([IPv6:::ffff:193.6.222.241])
	by bolha.lvs.iif.hu (bolha.lvs.iif.hu [::ffff:193.225.14.72]) (amavisd-new, port 10024)
	with ESMTP id e6G5mnopvBxQ for <ceph-devel@vger.kernel.org>;
	Mon, 27 Feb 2012 17:59:02 +0100 (CET)
Received: from mranderson.localnet (unknown [IPv6:2001:738:0:401:5e26:aff:fe15:fe40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.ki.iif.hu (Postfix) with ESMTPSA id 9BA8487A0B
	for <ceph-devel@vger.kernel.org>; Mon, 27 Feb 2012 17:59:02 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,

whenever I restart osd.0 I see a pair of messages like

2012-02-27 17:26:00.132666 mon.0 <osd_1_ip>:6789/0 106 : [INF] osd.0 
<osd_0_ip>:6801/29931 failed (by osd.1 <osd_1_ip>:6806/20125)
2012-02-27 17:26:21.074926 osd.0 <osd_0_ip>:6801/29931 1 : [WRN] map e370 
wrongly marked me down or wrong addr

a couple of times. The situation stabilizes in a normal state after about two 
minutes.

Should I worry about this? Maybe the first message is about the just killed 
OSD, and the second comes from the new incarnation, and this is completely 
normal? This is Ceph 0.41.

Thanks,
-- 
cc


