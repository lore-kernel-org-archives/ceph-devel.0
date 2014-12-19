From: David Zafman <dzafman@redhat.com>
Subject: ceph-objectstore-tool and make check
Date: Fri, 19 Dec 2014 14:09:17 -0800
Message-ID: <5494A20D.7000208@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38606 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752463AbaLSWJS (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 19 Dec 2014 17:09:18 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id sBJM9Ink030489
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <ceph-devel@vger.kernel.org>; Fri, 19 Dec 2014 17:09:18 -0500
Received: from David-Zs-MacBook-Pro.local (vpn-225-116.phx2.redhat.com [10.3.225.116])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id sBJM9Ho9007176
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO)
	for <ceph-devel@vger.kernel.org>; Fri, 19 Dec 2014 17:09:18 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


The objectstore tool has been renamed from ceph_objectstore_tool to 
ceph-objectstore-tool.

Please remove src/.libs/ceph_objectstore_tool and 
src/.libs/lt-ceph_objectstore_tool or do a "make clean" with latest 
master branch.  Otherwise, a local make check can fail because the old 
binary of the tool will always be executed.


David Zafman
Senior Developer
http://www.redhat.com
