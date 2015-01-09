From: David Zafman <dzafman@redhat.com>
Subject: Some gitbuilders not working
Date: Thu, 08 Jan 2015 22:56:52 -0800
Message-ID: <54AF7BB4.3050403@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45501 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754030AbbAIG4y (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 9 Jan 2015 01:56:54 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t096urhx024808
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <ceph-devel@vger.kernel.org>; Fri, 9 Jan 2015 01:56:53 -0500
Received: from David-Zs-MacBook-Pro.local (vpn-227-143.phx2.redhat.com [10.3.227.143])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t096uqpa015162
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO)
	for <ceph-devel@vger.kernel.org>; Fri, 9 Jan 2015 01:56:53 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


We are seeing gitbuilder failures.  This is what I saw on one.

error: Failed build dependencies:
xmlstarlet is needed by ceph-1:0.90-821.g680fe3c.el7.x86_64

David Zafman
Senior Developer
http://www.redhat.com
