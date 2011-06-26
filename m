From: Martin Wilderoth <martin.wilderoth@linserv.se>
Subject: Data distribution
Date: Sun, 26 Jun 2011 05:48:59 +0200 (CEST)
Message-ID: <1793430427.17772.1309060138965.JavaMail.root@mail.linserv.se>
References: <344660039.17770.1309060083991.JavaMail.root@mail.linserv.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 194-17-14-101.customer.telia.com ([194.17.14.101]:52154 "EHLO
	mail.linserv.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752665Ab1FZD5i (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 25 Jun 2011 23:57:38 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.linserv.se (Postfix) with ESMTP id 797F412002C
	for <ceph-devel@vger.kernel.org>; Sun, 26 Jun 2011 05:48:59 +0200 (CEST)
Received: from mail.linserv.se ([127.0.0.1])
	by localhost (mail.linserv.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jDfLILzAD3l9 for <ceph-devel@vger.kernel.org>;
	Sun, 26 Jun 2011 05:48:59 +0200 (CEST)
Received: from mail.linserv.se (mail.linserv.se [194.17.14.101])
	by mail.linserv.se (Postfix) with ESMTP id 2345812002B
	for <ceph-devel@vger.kernel.org>; Sun, 26 Jun 2011 05:48:59 +0200 (CEST)
In-Reply-To: <344660039.17770.1309060083991.JavaMail.root@mail.linserv.se>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hello

I have a ceph cluster of 6 osd 146gb each. I have copied a lot of data
filling to 87%. Between the osd's the data is not evenly distributed

host1
/dev/sdb              137G  119G   15G  90% /data/osd0
/dev/sdc              137G  126G  7.4G  95% /data/osd1

host2
/dev/sdc              137G  114G   21G  85% /data/osd2
/dev/sdd              137G  130G  3.6G  98% /data/osd3

host3
/dev/sdb              137G  107G   27G  81% /data/osd4
/dev/sdc              137G   98G   36G  74% /data/osd5

During the copy i got I/O error, but after restarting the cluster it seems fine.

By some reason osd3 seems to have much more data than osd5. Is there a way of geting the data distributed better ?.
