From: =?ISO-8859-1?Q?Sz=E9kelyi?= Szabolcs <szekelyi@niif.hu>
Subject: Stale NFS file handle
Date: Tue, 14 Feb 2012 00:32:18 +0100
Message-ID: <7386587.xNpCPNsyj0@mranderson>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ki.iif.hu ([193.6.222.241]:51365 "EHLO mail.ki.iif.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758336Ab2BMXcY (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 13 Feb 2012 18:32:24 -0500
Received: from cirkusz.lvs.iif.hu (cirkusz.lvs.iif.hu [193.225.14.182])
	by mail.ki.iif.hu (Postfix) with ESMTP id 7BE5B8799A
	for <ceph-devel@vger.kernel.org>; Tue, 14 Feb 2012 00:32:22 +0100 (CET)
Received: from mail.ki.iif.hu ([IPv6:::ffff:193.6.222.241])
	by cirkusz.lvs.iif.hu (cirkusz.lvs.iif.hu [::ffff:193.225.14.72]) (amavisd-new, port 10024)
	with ESMTP id Z8Ljpo5gbPGa for <ceph-devel@vger.kernel.org>;
	Tue, 14 Feb 2012 00:32:20 +0100 (CET)
Received: from mranderson.localnet (adsl166.adsl.hungarnet.hu [193.6.17.166])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.ki.iif.hu (Postfix) with ESMTPSA id 5CF7187991
	for <ceph-devel@vger.kernel.org>; Tue, 14 Feb 2012 00:32:19 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I'm using Ceph 0.41 with the FUSE client. After a while I get stale NFS file 
errors when trying to read a file or list a directory. Logs and scrubbing 
doesn't show any errors or suspicious entries. After remounting the filesystem 
either by restarting the cluster thus forcing the clients to reconnect or 
umount+mount, files and directories either show up again or seem lost forever.

Can you give me any hint on what to check?

Thanks,
-- 
cc


