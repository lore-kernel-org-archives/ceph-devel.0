From: Mike Dawson <mdawson@gammacode.com>
Subject: Guidelines for Calculating IOPS?
Date: Fri, 19 Oct 2012 10:47:46 -0400
Message-ID: <50816812.2040008@gammacode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 23-25-46-103-static.hfc.comcastbusiness.net ([23.25.46.103]:46399
	"EHLO mail1.gammacode.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932959Ab2JSO55 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Oct 2012 10:57:57 -0400
Received: from localhost (mail1.gammacode.com [127.0.0.1])
	by mail1.gammacode.com (iRedMail) with ESMTP id F28E23D802E
	for <ceph-devel@vger.kernel.org>; Fri, 19 Oct 2012 10:46:35 -0400 (EDT)
Received: from mail1.gammacode.com ([127.0.0.1])
	by localhost (mail1.gammacode.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9Ih97fqfHaMp for <ceph-devel@vger.kernel.org>;
	Fri, 19 Oct 2012 10:46:35 -0400 (EDT)
Received: from [10.10.1.203] (unknown [10.10.1.203])
	by mail1.gammacode.com (iRedMail) with ESMTPSA id 4E62E3D802D
	for <ceph-devel@vger.kernel.org>; Fri, 19 Oct 2012 10:46:35 -0400 (EDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

All,

I am investigating the use of Ceph for a video surveillance project with 
the following minimum block storage requirements:

385 Mbps of constant write bandwidth
100TB storage requirement
5250 IOPS (size of ~8 KB)

I believe 2 replicas would be acceptable. We intend to use large 
capacity (2 or 3TB) SATA 7200rpm 3.5" drives, if the IOPS work out properly.

Is there a method / formula to estimate IOPS for RDB? Specifically I 
would like to understand:

- How does replica count affect read/write IOPS?

- I'm trying to understand best practice for when to optimize server 
count, drives per server, and drive capacity as it relates to IOPS. Is 
there a point of diminishing I/O performance using server chassis with 
lots of drive slots, like the 36-drive Supermicro SC847a?


Thanks,
Mike
