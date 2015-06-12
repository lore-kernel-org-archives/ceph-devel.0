From: Samuel Just <sjust@redhat.com>
Subject: Rados multi-object transaction use cases
Date: Fri, 12 Jun 2015 18:15:02 -0400 (EDT)
Message-ID: <1235935092.20915764.1434147302334.JavaMail.zimbra@redhat.com>
References: <1237345102.20915406.1434147190410.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37]:59868 "EHLO
	mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752623AbbFLWPC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 12 Jun 2015 18:15:02 -0400
Received: from zmail24.collab.prod.int.phx2.redhat.com (zmail24.collab.prod.int.phx2.redhat.com [10.5.83.30])
	by mx5-phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t5CMF2KM014249
	for <ceph-devel@vger.kernel.org>; Fri, 12 Jun 2015 18:15:02 -0400
In-Reply-To: <1237345102.20915406.1434147190410.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

In the Infernalis CDS, we had a session on RADOS multi-object transactions.  I'd like to continue the discussion at the upcoming Jewel CDS.  I thought I'd prime the discussion by asking: if librados supported multi-object read and write transactions, what would you use them for?  Some idea of use cases would be valuable when considering things like deadlock coping strategies.
-Sam
