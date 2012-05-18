From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: is rados block cluster production ready ?
Date: Fri, 18 May 2012 08:08:04 +0200 (CEST)
Message-ID: <c1099add-5872-4b8b-9250-9dd33791a776@mailpro>
References: <531ff5f3-11d5-488e-adfb-68000f3c36c0@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:43534 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755413Ab2ERGRQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 May 2012 02:17:16 -0400
Received: from localhost (localhost [127.0.0.1])
	by mailpro.odiso.net (Postfix) with ESMTP id 197E41805B602
	for <ceph-devel@vger.kernel.org>; Fri, 18 May 2012 08:08:10 +0200 (CEST)
Received: from mailpro.odiso.net ([127.0.0.1])
	by localhost (mailpro.odiso.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vRQWaykTb+VE for <ceph-devel@vger.kernel.org>;
	Fri, 18 May 2012 08:08:04 +0200 (CEST)
Received: from mailpro.odiso.net (mailpro.odiso.net [10.1.31.112])
	by mailpro.odiso.net (Postfix) with ESMTP id C69EA1803F161
	for <ceph-devel@vger.kernel.org>; Fri, 18 May 2012 08:08:04 +0200 (CEST)
In-Reply-To: <531ff5f3-11d5-488e-adfb-68000f3c36c0@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,
I'm going to build a rados block cluster for my kvm hypervisors.

Is it already production ready ? (stable,no crash)

I have read some btrfs bugs on this mailing list, so I'm a bit scary...


Also, what performance could I expect ?
I try to build a fast cluster, with fast ssd disk.
each node : 8 osds with "ocz talos" sas drive + stec zeusram drive (8GB nvram) for the journal + 10GB ethernet.
Do you think I can saturate the 10GB ?


I also have some questions about performance in time. 
I have had somes problems with my zfs san and zfs fragmentation and metastab problem. 
How does btrfs perform in time ?


About network, does the rados protocol support some kind of multipathing ? Or does I need to use bonding/lacp ?


I have submited the contact form on Inktank website, as we would like to pay for support/expertise to build this cluster, but didn't have response yet.

Regards,

Alexandre Derumier
System Engineer
aderumier@odiso.com


