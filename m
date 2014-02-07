From: Daniel Poelzleithner <poelzleithner@b1-systems.de>
Subject: Unfixable corruption in ceph cluster
Date: Fri, 07 Feb 2014 22:19:33 +0100
Message-ID: <52F54DE5.2020109@b1-systems.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.b1-systems.de ([84.200.69.220]:35702 "EHLO
	mx1.b1-systems.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751617AbaBGV3R (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Feb 2014 16:29:17 -0500
Received: from [172.22.99.170] (anon-32-5.vpn.ipredator.se [46.246.32.5])
	by mx1.b1-systems.de (Postfix) with ESMTPSA id 978B74088
	for <ceph-devel@vger.kernel.org>; Fri,  7 Feb 2014 22:04:54 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

we experience a strange corruption in the ceph cluster that makes it
impossible to restart all nodes of it. Always one node crashes when some
pg gets replicated.
As much as I understood the admin, if the node is cleared completely,
the node synces, but some other node crashes then.

I think there was a similar bug
http://tracker.ceph.com/issues/6101#note-7 already filed.

Removing the rados block did not fix the problem.

In my opinion the bug is severe, as it shows that some internal
corruption seems to be triggered by network failure and causes a
permanent unfixable broken cluster.

Could someone please take a look at it ?
I will try to provide additional information when required.


kind regards
 Daniel
