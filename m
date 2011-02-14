From: "Longguang Yue" <longguang_yue@tcloudcomputing.com>
Subject: question about socket conection among osd,mds,mon
Date: Mon, 14 Feb 2011 11:13:20 +0800
Message-ID: <D0C67741759ABD4BBD8D3A5CB815606E07E935@mail.cloud-valley.com.cn>
References: <4D57DFFB.5080703@nadir-seen-fire.com> <Pine.LNX.4.64.1102131028450.27567@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from [203.114.244.241] ([203.114.244.241]:8531 "EHLO
	mail.cloud-valley.com" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751917Ab1BNDNX convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 13 Feb 2011 22:13:23 -0500
Content-class: urn:content-classes:message
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

1.Netstat info:
10.10.1.100:6800		<--- 10.10.1.106:34585, 10.10.1.98:46625
10.10.1.100:6801		<--- 10.10.1.106:59284, 10.10.1.98:35101
When osd need 2(more) listen sockets? Why  others osd connect as many
times as its listen socket?


2.how to deal with blacklist osds
osd e35: 3 osds: 3 up, 3 in -- 2 blacklisted MDSes

according to 1 case, how to deal with blacklist.
If I need  run  'ceph osd blacklist rm  10.10.1.106:34585 &&
10.10.1.98:46625 ' ??????

I think just only one osd listen socket exists!!!!!!
