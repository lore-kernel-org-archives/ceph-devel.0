From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: c++11 merged in master
Date: Fri, 7 Aug 2015 13:56:11 -0600
Message-ID: <55C50D5B.6090806@redhat.com>
References: <alpine.DEB.2.00.1508071041040.22099@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46816 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946294AbbHGT4N (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 7 Aug 2015 15:56:13 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id 42D53A2048
	for <ceph-devel@vger.kernel.org>; Fri,  7 Aug 2015 19:56:13 +0000 (UTC)
In-Reply-To: <alpine.DEB.2.00.1508071041040.22099@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, ceph-devel@vger.kernel.org
Cc: adeza@redhat.com

On 08/07/2015 11:52 AM, Sage Weil wrote:
> We'll need to do something similar on centos6 to get g++ 4.7 or 4.8 in 
> place, and the jenkins slaves for release builds will also need to be 
> updated.

I think the most official repository for this sort of thing for CentOS 6
is SCL [1] (it's a little like PPA for RPM-based systems).

This is going to make our build process even more complicated, so if you
find that this isn't a trivial drop-in solution, I'm good for just
dropping RHEL 6/CentOS 6 support in master.

[1] https://www.softwarecollections.org/en/scls/rhscl/devtoolset-3/

- Ken
