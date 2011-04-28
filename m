From: Zenon Panoussis <oracle@provocation.net>
Subject: Object size
Date: Thu, 28 Apr 2011 20:51:54 +0200
Message-ID: <4DB9B74A.10806@provocation.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from host-88-80-6-138.cust.prq.se ([88.80.6.138]:56698 "EHLO
	mail.nettheatre.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933239Ab1D1SwA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Apr 2011 14:52:00 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi

I'm trying to understand the relation between data size and actual
disk usage. With replication x2 I am seeing a 1:4.4 ratio according
to ceph (12222 MB data, 53579 MB used) and even more according to
'du -m' on the ext3 source of the ceph data (9791 MB instead of
12222 MB).

What is the current default object size? A paper from 2004 by Sage
et al speaks of 1 MB, a later one of 8 MB and
http://diaspora.gen.nz/~rodgerd/archives/1219-Ceph.html says 4 MB.
Is there a way to configure it? And is there any point in configuring
it (I am using ceph to store millions of small files) or would it
make no difference?

Z


