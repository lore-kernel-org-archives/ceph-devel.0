From: David Zafman <dzafman@redhat.com>
Subject: Disk failing plana74
Date: Fri, 20 Feb 2015 13:10:48 -0800
Message-ID: <54E7A2D8.7070906@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57098 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754363AbbBTVKu (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 20 Feb 2015 16:10:50 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t1KLAooc015481
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <ceph-devel@vger.kernel.org>; Fri, 20 Feb 2015 16:10:50 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sandon Van Ness <svanness@redhat.com>
Cc: ceph-devel@vger.kernel.org


A recent test run had an EIO on the following disk:

plana74 /dev/sdb

The machine is locked right now.

David Zafman
Senior Developer
