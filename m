From: =?ISO-8859-1?Q?Sz=E9kelyi?= Szabolcs <szekelyi@niif.hu>
Subject: OSD doesn't start
Date: Wed, 04 Jul 2012 17:31:32 +0200
Message-ID: <1563053.ttVafs9Pph@mranderson>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from www.ki.iif.hu ([193.6.222.244]:40885 "EHLO strudel.ki.iif.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754453Ab2GDPjz (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 4 Jul 2012 11:39:55 -0400
Received: from cirkusz.lvs.iif.hu (cirkusz.lvs.iif.hu [193.225.14.182])
	by strudel.ki.iif.hu (Postfix) with ESMTP id D06D7388
	for <ceph-devel@vger.kernel.org>; Wed,  4 Jul 2012 17:31:38 +0200 (CEST)
Received: from strudel.ki.iif.hu ([IPv6:::ffff:193.6.222.244])
	by cirkusz.lvs.iif.hu (cirkusz.lvs.iif.hu [::ffff:193.225.14.72]) (amavisd-new, port 10024)
	with ESMTP id vhW1q2tnrFEk for <ceph-devel@vger.kernel.org>;
	Wed,  4 Jul 2012 17:31:35 +0200 (CEST)
Received: from mranderson.localnet (unknown [IPv6:2001:738:0:401:a9a5:3891:c103:d544])
	by strudel.ki.iif.hu (Postfix) with ESMTPSA id 86F65387
	for <ceph-devel@vger.kernel.org>; Wed,  4 Jul 2012 17:31:34 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

after upgrading to 0.48 "Argonaut", my OSDs won't start up again. This problem 
might not be related to the upgrade, since the cluster had strange behavior 
before, too: ceph-fuse was spinning the CPU around 70%, so did the OSDs. This 
happened to both of my clusters. Thought that upgrading might solve the 
problem, but it just got worse.

I've copied the log of the OSD run to http://pastebin.com/XYRtfFMU . I've 
rebooted all the nodes, but they still don't work.

What should I do to resurrect my OSDs?

Thanks,
-- 
cc


