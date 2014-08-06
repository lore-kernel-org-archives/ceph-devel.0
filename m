From: "Matt W. Benjamin" <matt@cohortfs.com>
Subject: mon dependency on OSD MonClient using OSD's client_messenger
Date: Wed, 6 Aug 2014 12:40:24 -0400 (EDT)
Message-ID: <1261081511.125.1407343224581.JavaMail.root@thunderbeast.private.linuxbox.com>
References: <1875667091.100.1407341902410.JavaMail.root@thunderbeast.private.linuxbox.com>
Reply-To: "Matt W. Benjamin" <matt@cohortfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from aa.linuxbox.com ([69.128.83.226]:2807 "EHLO aa.linuxbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754064AbaHFQk2 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 6 Aug 2014 12:40:28 -0400
Received: from thunderbeast.private.linuxbox.com (thunderbeast.private.linuxbox.com [10.1.1.55])
	by aa.linuxbox.com (8.13.1/8.13.1/SuSE Linux 0.7) with ESMTP id s76GeQlU012432
	for <ceph-devel@vger.kernel.org>; Wed, 6 Aug 2014 12:40:27 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by thunderbeast.private.linuxbox.com (Postfix) with ESMTP id F36A63FC84A0
	for <ceph-devel@vger.kernel.org>; Wed,  6 Aug 2014 12:40:25 -0400 (EDT)
Received: from thunderbeast.private.linuxbox.com ([127.0.0.1])
	by localhost (thunderbeast.private.linuxbox.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BC2iUCubmB7o for <ceph-devel@vger.kernel.org>;
	Wed,  6 Aug 2014 12:40:24 -0400 (EDT)
Received: from thunderbeast.private.linuxbox.com (thunderbeast.private.linuxbox.com [10.1.1.55])
	by thunderbeast.private.linuxbox.com (Postfix) with ESMTP id C57863FC849D
	for <ceph-devel@vger.kernel.org>; Wed,  6 Aug 2014 12:40:24 -0400 (EDT)
In-Reply-To: <1875667091.100.1407341902410.JavaMail.root@thunderbeast.private.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

We noticed that OSDs use their client_messenger, rather than their potentially
dedicated cluster_messenger, to drive MonClient.  Then we found that the Mon's setup
of the OSDMap depends on this.

Can someone comment?  We assume this is well known, but what is the background?

Thanks,

Matt

-- 
Matt Benjamin
CohortFS, LLC.
206 South Fifth Ave. Suite 150
Ann Arbor, MI  48104

http://cohortfs.com

tel.  734-761-4689 
fax.  734-769-8938 
cel.  734-216-5309 
