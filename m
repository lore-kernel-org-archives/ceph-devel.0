From: =?iso-8859-1?q?Sz=E9kelyi_Szabolcs?= <szekelyi@niif.hu>
Subject: Logging to syslog from clients
Date: Tue, 16 Aug 2011 02:31:53 +0200
Message-ID: <201108160231.53287.szekelyi@niif.hu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ki.iif.hu ([193.6.222.241]:60276 "EHLO mail.ki.iif.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752353Ab1HPAb6 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 15 Aug 2011 20:31:58 -0400
Received: from bolha.lvs.iif.hu (bolha.lvs.iif.hu [193.225.14.181])
	by mail.ki.iif.hu (Postfix) with ESMTP id 9AA7C876A5
	for <ceph-devel@vger.kernel.org>; Tue, 16 Aug 2011 02:31:57 +0200 (CEST)
Received: from mail.ki.iif.hu ([IPv6:::ffff:193.6.222.241])
	by bolha.lvs.iif.hu (bolha.lvs.iif.hu [::ffff:193.225.14.72]) (amavisd-new, port 10024)
	with ESMTP id PA1YfXaYquv0 for <ceph-devel@vger.kernel.org>;
	Tue, 16 Aug 2011 02:31:54 +0200 (CEST)
Received: from mranderson.localnet (adsl166.adsl.hungarnet.hu [193.6.17.166])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.ki.iif.hu (Postfix) with ESMTPSA id A76A48764C
	for <ceph-devel@vger.kernel.org>; Tue, 16 Aug 2011 02:31:54 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,

I'm running a Ceph cluster with a number of read-only ramdisk based clients 
mounting the filesystem. I'd like to get the logs of the client out via syslog. 
I've seen some posts dealing with logging to syslog, namely the thread 
starting at http://www.spinics.net/lists/ceph-devel/msg02876.html . I see 
options like "log to syslog" and "clog to syslog". It's not clear what they 
mean, could someone tell me the difference?

Anyway, currently my logging settings on the client are

[global]
log file =
log dir =
log to syslog = true
clog to syslog = true

But when the filesystem is mounted with the FUSE client, I still get

failed to open log file '/var/log/ceph/client.admin.log': error 2: No such file 
or directory

which is surprising. I thought that the above options should have disabled 
logging to file, but it looks like it still tries to open it. Is this a bug, or 
me doing something wrong?

Thanks,
-- 
cc

