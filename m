From: Tomasz Chmielewski <mangoo@wpkg.org>
Subject: Ceph on just two nodes being clients - reasonable?
Date: Wed, 19 Jan 2011 11:33:29 +0100
Message-ID: <4D36BDF9.4030404@wpkg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.virtall.com ([178.63.195.102]:41635 "EHLO mail.virtall.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750984Ab1ASKn4 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 19 Jan 2011 05:43:56 -0500
Received: from mail.virtall.com (localhost [127.0.0.1])
	by mail.virtall.com (Postfix) with ESMTP id DD63A35CAFB
	for <ceph-devel@vger.kernel.org>; Wed, 19 Jan 2011 11:33:31 +0100 (CET)
Received: from [192.168.10.145] (e183095092.adsl.alicedsl.de [85.183.95.92])
	by mail.virtall.com (Postfix) with ESMTPSA id A278335CAF8
	for <ceph-devel@vger.kernel.org>; Wed, 19 Jan 2011 11:33:31 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Is it reasonable to set up Ceph on two nodes, which are Ceph clients at 
the same time?


Say, we have two machines:

   ceph1 -- ceph2


On each of them, Ceph filesystem is mounted in /shared, which is used by 
services like a webserver or a mailserver.

Is it a reasonable approach?


-- 
Tomasz Chmielewski
http://wpkg.org
