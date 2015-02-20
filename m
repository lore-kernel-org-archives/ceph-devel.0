From: David Zafman <dzafman@redhat.com>
Subject: Clocks out of sync
Date: Fri, 20 Feb 2015 15:08:29 -0800
Message-ID: <54E7BE6D.5040503@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42452 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754737AbbBTXIc (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 20 Feb 2015 18:08:32 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t1KN8Wdx022814
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <ceph-devel@vger.kernel.org>; Fri, 20 Feb 2015 18:08:32 -0500
Received: from David-Zs-MacBook-Pro.local (vpn-59-47.rdu2.redhat.com [10.10.59.47])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t1KN8UhR025694
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO)
	for <ceph-devel@vger.kernel.org>; Fri, 20 Feb 2015 18:08:31 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


On 2 of my rados thrash runs clocks out of sync.   Is this an occasional 
issue or did we have an infrastructure problem?

On burnupi19 and burnupi25:
2015-02-20 12:52:52.636017 mon.1 10.214.134.14:6789/0 177 : cluster 
[WRN] message from mon.0 was stamped 0.501458s in the future, clocks not 
synchronized

On plana62 and plana64:
2015-02-20 10:00:56.842533 mon.0 10.214.132.14:6789/0 3 : cluster [WRN] 
message from mon.1 was stamped 0.855106s in the future, clocks not 
synchronized


