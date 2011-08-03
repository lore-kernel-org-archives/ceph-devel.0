From: =?iso-8859-1?q?Sz=E9kelyi_Szabolcs?= <szekelyi@niif.hu>
Subject: Monitors fallen apart
Date: Wed, 3 Aug 2011 11:16:37 +0200
Message-ID: <201108031116.37824.szekelyi@niif.hu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ki.iif.hu ([193.6.222.241]:58095 "EHLO mail.ki.iif.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752629Ab1HCJXh (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 3 Aug 2011 05:23:37 -0400
Received: from bolha.lvs.iif.hu (bolha.lvs.iif.hu [193.225.14.181])
	by mail.ki.iif.hu (Postfix) with ESMTP id 7235E875F3
	for <ceph-devel@vger.kernel.org>; Wed,  3 Aug 2011 11:16:41 +0200 (CEST)
Received: from mail.ki.iif.hu ([IPv6:::ffff:193.6.222.241])
	by bolha.lvs.iif.hu (bolha.lvs.iif.hu [::ffff:193.225.14.72]) (amavisd-new, port 10024)
	with ESMTP id f-solWUCpt+d for <ceph-devel@vger.kernel.org>;
	Wed,  3 Aug 2011 11:16:39 +0200 (CEST)
Received: from mranderson.localnet (dhcp112.ki.iif.hu [193.6.223.112])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.ki.iif.hu (Postfix) with ESMTPSA id 39780875D7
	for <ceph-devel@vger.kernel.org>; Wed,  3 Aug 2011 11:16:38 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,

I'm running ceph 0.32, and since a while it looks like if a monitor fails, 
then the cluster doesn't find a new one.

I have three nodes, two with cmds+cosd+cmon, and one with cmds+cmon, which is 
also running the client. If I stop one of the cmds+cosd+cmon nodes, ceph -w 
run on the cmds+cmon node tells nothing but

2011-08-03 11:10:47.291875 7f4f043d5700 -- <client_ip>:0/14633 >> 
<killed_node_ip>:6789/0 pipe(0x1a7f9c0 sd=4 pgs=0 cs=0 l=0).fault first fault

infinitely and the filesystem stops working (processes using files in it block 
forever). Looks like it rties to connect to the killed monitor instead of 
failing over to a working one.

The first message after killing the node was:

2011-08-03 10:57:40.687871 7f4f01563700 monclient: hunting for new mon

Do you have any idea what I'm doing wrong?

Thanks,
-- 
cc

