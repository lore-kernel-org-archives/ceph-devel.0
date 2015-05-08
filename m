From: Mark Nelson <mnelson@redhat.com>
Subject: Newstore Update Part 2
Date: Fri, 08 May 2015 18:21:07 -0500
Message-ID: <554D44E3.7080600@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35341 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751307AbbEHXVK (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 8 May 2015 19:21:10 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (Postfix) with ESMTPS id EA92635C80C
	for <ceph-devel@vger.kernel.org>; Fri,  8 May 2015 23:21:09 +0000 (UTC)
Received: from [10.3.112.73] (ovpn-112-73.phx2.redhat.com [10.3.112.73])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t48NL7pD005318
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ceph-devel@vger.kernel.org>; Fri, 8 May 2015 19:21:09 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi Guys,

At the performance meeting this week we discussed the possibility of 
changing how newstore handles large partial overwrites.  To determine if 
this is useful, we look at rados bench and rbd performance of newstore 
at various IO sizes.  I've also included some rados bench read results 
as folks were interested in those.  On the graphs I've tried to mark 
interesting improvements/regressions and also some questions/comments. 
These tests were run without overlay which may help small IO performance 
in some cases.

Graphs are here:

http://nhm.ceph.com/newstore/8c8c5903_rbd_rados_tests.pdf

Thanks,
Mark
