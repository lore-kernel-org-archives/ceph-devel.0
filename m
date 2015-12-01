From: Vimal <vikumar@redhat.com>
Subject: Suggestions on tracker 13578
Date: Tue, 1 Dec 2015 18:53:45 +0530
Message-ID: <565D9F61.6070108@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36540 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751640AbbLANXs (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 1 Dec 2015 08:23:48 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (Postfix) with ESMTPS id 2CD5C8E6EF
	for <ceph-devel@vger.kernel.org>; Tue,  1 Dec 2015 13:23:48 +0000 (UTC)
Received: from [10.65.223.165] (dhcp223-165.pnq.redhat.com [10.65.223.165])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id tB1DNk1R023751
	for <ceph-devel@vger.kernel.org>; Tue, 1 Dec 2015 08:23:47 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,

This mail is to discuss the feature request at 
http://tracker.ceph.com/issues/13578.

If done, such a tool should help point out several mis-configurations 
that may cause problems in a cluster later.

Some of the suggestions are:

a) A check to understand if the MONs and OSD nodes are on the same machines.

b) If /var is a separate partition or not, to prevent the root 
filesystem from being filled up.

c) If monitors are deployed in different failure domains or not.

d) If the OSDs are deployed in different failure domains.

e) If a journal disk is used for more than six OSDs. Right now, the 
documentation suggests upto 6 OSD journals to exist on a single journal 
disk.

f) Failure domains depending on the power source.

There can be several more checks, and it can be a useful tool to test 
the problems an existing cluster or a new installation.

But I'd like to know how the engineering community sees this, if its 
seems to be worth pursuing, and what suggestions do you have for 
improving/adding to this.

Thank you,

Vimal
