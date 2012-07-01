From: Vladimir Bashkirtsev <vladimir@bashkirtsev.com>
Subject: Ceph and KVM live migration
Date: Sun, 01 Jul 2012 10:12:25 +0930
Message-ID: <4FEF9CF1.6030008@bashkirtsev.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.logics.net.au ([150.101.56.178]:42104 "EHLO
	mail.logics.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932069Ab2GAAms (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 30 Jun 2012 20:42:48 -0400
Received: from x.logics.net.au (gw.logics.net.au [150.101.235.251] (may be forged))
	(authenticated bits=0)
	by mail.logics.net.au (8.14.5/8.14.1) with ESMTP id q610gPEJ023203
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO)
	for <ceph-devel@vger.kernel.org>; Sun, 1 Jul 2012 10:12:25 +0930
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Dear all,

Currently I testing KVMs running on ceph and particularly testing recent 
cache feature. Performance is of course vastly improved but still have 
occasional KVM hold ups - not sure who is at blame ceph of KVM. But I 
will deal with it later. Right now I've got myself a question which I 
could not get answered myself: if I do live migration of KVM while there 
some uncommitted data in ceph cache will this cache be committed prior 
cut-over to another host? Reading through the list I've got an 
impression that it may be left uncommitted and thus it may cause data 
corruption. I just would like a simple confirmation if code which 
commits cache on cut-over to new host does exist and no data corruption 
due to RBD cache+live migration should happen.

Regards,
Vladimir
