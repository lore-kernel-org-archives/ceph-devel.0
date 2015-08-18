From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: WIP for C++11 Time Support
Date: Tue, 18 Aug 2015 14:08:24 -0400
Message-ID: <55D37498.8060504@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55173 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751443AbbHRSHj (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 18 Aug 2015 14:07:39 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (Postfix) with ESMTPS id CAD252631
	for <ceph-devel@vger.kernel.org>; Tue, 18 Aug 2015 18:07:38 +0000 (UTC)
Received: from [10.3.113.95] (ovpn-113-95.phx2.redhat.com [10.3.113.95])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t7II7b2W014637
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ceph-devel@vger.kernel.org>; Tue, 18 Aug 2015 14:07:38 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Developers <ceph-devel@vger.kernel.org>

I've pushed a branch, wip-cxx11time for inspection. It includes basic 
support for std::chrono (including clocks linked to specific POSIX 
CLOCK_* identifiers) and a new timer class that doesn't require Context*.

As was suggested to me, I updated one subsystem to use std::chrono as an 
example, in this case OSDC.

Please review/critique.

Thank you.
