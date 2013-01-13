From: Xing Lin <xinglin@cs.utah.edu>
Subject: [debug help]: get dprintk() outputs in src/crush/mapper.c or net/crush/mapper.c
Date: Sun, 13 Jan 2013 12:15:58 -0700
Message-ID: <50F307EE.5020507@cs.utah.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from rio.cs.utah.edu ([155.98.64.241]:37967 "EHLO
	mail-svr1.cs.utah.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755748Ab3AMTQA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 13 Jan 2013 14:16:00 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail-svr1.cs.utah.edu (Postfix) with ESMTP id F232A6500C5
	for <ceph-devel@vger.kernel.org>; Sun, 13 Jan 2013 12:15:59 -0700 (MST)
Received: from mail-svr1.cs.utah.edu ([127.0.0.1])
	by localhost (mail-svr1.cs.utah.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cyNJ3Zu1qmyd for <ceph-devel@vger.kernel.org>;
	Sun, 13 Jan 2013 12:15:59 -0700 (MST)
Received: from [192.168.1.6] (155-97-235-236.usahousing.utah.edu [155.97.235.236])
	by smtps.cs.utah.edu (Postfix) with ESMTPSA id 81F9A6500C3
	for <ceph-devel@vger.kernel.org>; Sun, 13 Jan 2013 12:15:59 -0700 (MST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

There are many dprintk() statements in the file mapper.c. How can we get 
to see outputs from these statements? I would like to see these, to get 
a better understanding about how these functions work together and then 
enhance my added algorithm. Besides, adding a printf() statement in the 
crush_do_rule() or my simple bucket_directmap_choose() does not give me 
any output. Thanks.

Xing
