From: David Zafman <dzafman@redhat.com>
Subject: Hammer incompat bits and ceph-objectstore-tool
Date: Tue, 17 Mar 2015 18:55:50 -0700
Message-ID: <5508DB26.5000706@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38654 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752963AbbCRBzu (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 17 Mar 2015 21:55:50 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t2I1tnPY028867
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <ceph-devel@vger.kernel.org>; Tue, 17 Mar 2015 21:55:49 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sjust@redhat.com>, Sage Weil <sweil@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>


During upgrade testing an error occurred because ceph-objectstore-tool 
found during import on a Firefly node the compat_features from a export 
from Hammer.

There are 2 new feature bits set as shown in the error message:

Export has incompatible features set 
compat={},rocompat={},incompat={12=transaction hints,13=pg meta object}

In this case as far as I can tell these osd incompatible changes 
wouldn't make the export data in any way incompatible.  So we may have 
to check compatibility bits on a case by case basis, if we want to allow 
the tool to work in the most cases possible.

During upgrade testing it is interesting that one node has the 
transaction hints feature, but other nodes still running firefly don't.  
Is this a case where we don't have to wait for all  OSDs to update 
before the cluster can start handling OP_COLL_HINT operations?

David Zafman

