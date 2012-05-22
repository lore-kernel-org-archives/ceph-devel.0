From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: write cache disabling recommendations for journal and storage disks ?
Date: Tue, 22 May 2012 11:22:46 +0200 (CEST)
Message-ID: <d287d282-620a-4f13-afe6-2a0f603600c1@mailpro>
References: <e1be3949-6a8b-47c6-b3c1-179be84d9836@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:49655 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757192Ab2EVJXI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 May 2012 05:23:08 -0400
Received: from localhost (localhost [127.0.0.1])
	by mailpro.odiso.net (Postfix) with ESMTP id 0BA7D18024BDA
	for <ceph-devel@vger.kernel.org>; Tue, 22 May 2012 11:22:52 +0200 (CEST)
Received: from mailpro.odiso.net ([127.0.0.1])
	by localhost (mailpro.odiso.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9ARnmmiKNE-s for <ceph-devel@vger.kernel.org>;
	Tue, 22 May 2012 11:22:46 +0200 (CEST)
Received: from mailpro.odiso.net (mailpro.odiso.net [10.1.31.112])
	by mailpro.odiso.net (Postfix) with ESMTP id B9F45180250E1
	for <ceph-devel@vger.kernel.org>; Tue, 22 May 2012 11:22:46 +0200 (CEST)
In-Reply-To: <e1be3949-6a8b-47c6-b3c1-179be84d9836@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi, I have some questions about disabling write cache
"
http://ceph.com/docs/master/config-cluster/file-system-recommendations/

Ceph aims for data safety, which means that when the application receives notice that data was written to the disk, that data was actually written to the disk. For old kernels (<2.6.33), disable the write cache if the journal is on a raw disk. Newer kernels should work fine.

Use hdparm to disable write caching on the hard disk:

hdparm -W 0 /dev/hda 0
"



Cache on journal disk:

what happen if we have a powerfailure, if data are in cache of journal disk (ssd with/without supercapicitor) (so write is ack, but not really write on disk).


Cache on disks storage:
what happen if we have a powerfailure,if write is commited to journal, but write are in cache of storage disks and not yet on the platters ?


Maybe the best way is to disable write cache on both (journal and storage disks) ?

-Alexandre

