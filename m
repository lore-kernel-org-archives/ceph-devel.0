From: Andrew Hume <andrew@research.att.com>
Subject: rados get failure
Date: Tue, 5 Mar 2013 03:55:35 -0700
Message-ID: <B444B650-9F67-4A5C-AE7B-3A0F2DA421AB@research.att.com>
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pink.research.att.com ([192.20.225.111]:40255 "EHLO
	mail-pink.research.att.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751746Ab3CEKzm convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 5 Mar 2013 05:55:42 -0500
Received: from mail-green.research.att.com (unknown [135.207.178.10])
	by mail-pink.research.att.com (Postfix) with ESMTP id 7F3FC12016C
	for <ceph-devel@vger.kernel.org>; Tue,  5 Mar 2013 05:58:27 -0500 (EST)
Received: from bigmail.research.att.com (bigmail.research.att.com [135.207.177.180])
	by mail-green.research.att.com (Postfix) with ESMTP id 728CAE36D7
	for <ceph-devel@vger.kernel.org>; Tue,  5 Mar 2013 05:48:48 -0500 (EST)
Received: from [192.168.1.161] (castle7164.research.att.com [135.207.39.164])
	by bigmail.research.att.com (8.13.8+Sun/8.11.6) with ESMTP id r25AtfK5023726
	for <ceph-devel@vger.kernel.org>; Tue, 5 Mar 2013 05:55:41 -0500 (EST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

i have a new ceph installation across 4 nodes with 10TB of storage.
i loaded a few TB of objects (averaging 2-3GB each) via teh rados put command.
when i do a rados get command to retrieve one of these objects,
i get an "unknown error 1464856576".

i am running bobtail, and none of the logs contains anything alarming.
any advice on how to proceed?

(i would have included more details here but this mailing list has
odd restrictions on content.)

-----------------------
Andrew Hume
623-551-2845 (VO and best)
973-236-2014 (NJ)
andrew@research.att.com



