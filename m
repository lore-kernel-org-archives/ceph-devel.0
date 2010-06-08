From: Tomasz Chmielewski <mangoo@wpkg.org>
Subject: ceph, slow (cheap) and fast (expensive) storage?
Date: Tue, 08 Jun 2010 12:30:04 +0200
Message-ID: <4C0E1BAC.8070306@wpkg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.virtall.com ([178.63.195.102]:54357 "EHLO mail.virtall.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751565Ab0FHKhA (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 8 Jun 2010 06:37:00 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.virtall.com (Postfix) with ESMTP id 0E445352DCC
	for <ceph-devel@vger.kernel.org>; Tue,  8 Jun 2010 12:30:09 +0200 (CEST)
Received: from mail.virtall.com ([127.0.0.1])
	by localhost (web1.virtall.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wW9i36PgM1Us for <ceph-devel@vger.kernel.org>;
	Tue,  8 Jun 2010 12:30:06 +0200 (CEST)
Received: from [192.168.10.145] (e183095092.adsl.alicedsl.de [85.183.95.92])
	by mail.virtall.com (Postfix) with ESMTPSA
	for <ceph-devel@vger.kernel.org>; Tue,  8 Jun 2010 12:30:06 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I'd like to build a cluster for storing large amounts of data.

The cluster would consist of slow (cheap) storage and fast (expensive) 
storage.

I would like to migrate data from fast (expensive) storage to slow 
(cheap) storage if it wasn't accessed for, say, 6 months.

Would ceph somehow help me achieve that?

If not, do you know anything which comes to mind?



-- 
Tomasz Chmielewski
http://wpkg.org
