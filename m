From: Martin Wilderoth <martin.wilderoth@linserv.se>
Subject: Disk allocation
Date: Sun, 20 Mar 2011 07:43:29 +0100 (CET)
Message-ID: <51655650.12833.1300603409038.JavaMail.root@mail.linserv.se>
References: <1449881494.12831.1300600065210.JavaMail.root@mail.linserv.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 194-17-14-101.customer.telia.com ([194.17.14.101]:55274 "EHLO
	mail.linserv.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751151Ab1CTGt5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 20 Mar 2011 02:49:57 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.linserv.se (Postfix) with ESMTP id 9BC76E800F
	for <ceph-devel@vger.kernel.org>; Sun, 20 Mar 2011 07:43:29 +0100 (CET)
Received: from mail.linserv.se ([127.0.0.1])
	by localhost (mail.linserv.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tR3y45y3ra6P for <ceph-devel@vger.kernel.org>;
	Sun, 20 Mar 2011 07:43:29 +0100 (CET)
Received: from mail.linserv.se (mail.linserv.se [194.17.14.101])
	by mail.linserv.se (Postfix) with ESMTP id 29B3F12002C
	for <ceph-devel@vger.kernel.org>; Sun, 20 Mar 2011 07:43:29 +0100 (CET)
In-Reply-To: <1449881494.12831.1300600065210.JavaMail.root@mail.linserv.se>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I have a small ceph cluster with 4 osd ( 2 disks on 2 hosts). 

I have been adding and removing files from the file system, mounted as ceph on an other host.
 
Now I have removed most of the data on the file system, so I only have 300 MB left plus two snapshots. 

The problem is that looking at the disks the are allocating 88G of data 
on the ceph filesystem. 

osd1 1.1 G 
osd2 1.2 G 
osd3 33 G 
osd4 53 G 

Any reson for this ? 
