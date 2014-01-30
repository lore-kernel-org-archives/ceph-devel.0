From: "Don Talton (dotalton)" <dotalton@cisco.com>
Subject: down but not (auto) out?
Date: Thu, 30 Jan 2014 17:03:09 +0000
Message-ID: <57ED724085B72141BB091CF1314E471F018B5B78@xmb-rcd-x15.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from alln-iport-8.cisco.com ([173.37.142.95]:34682 "EHLO
	alln-iport-8.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751148AbaA3RMi convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Jan 2014 12:12:38 -0500
Received: from xhc-rcd-x03.cisco.com (xhc-rcd-x03.cisco.com [173.37.183.77])
	by rcdn-core-4.cisco.com (8.14.5/8.14.5) with ESMTP id s0UH3AA8008336
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <ceph-devel@vger.kernel.org>; Thu, 30 Jan 2014 17:03:10 GMT
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

I noticed when pulling data from the api via osd/dump that there is no interval state for an OSD that was brought down but is not yet set to autoout. The info for state will just be "exists", and stay that way until the OSD is out, which it then becomes "exists","autoout".

Does it make sense to have an interim state? Is there one that isn't reported to the API? I looked at the strings file. What state is "???"?

https://github.com/ceph/ceph/blob/master/src/common/ceph_strings.cc#L108



Donald Talton
Cloud Systems Development
Cisco Systems


