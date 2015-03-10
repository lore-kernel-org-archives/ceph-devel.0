From: David Zafman <dzafman@redhat.com>
Subject: Building documentation
Date: Mon, 09 Mar 2015 18:33:27 -0700
Message-ID: <54FE49E7.6050706@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33666 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751496AbbCJBd2 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 9 Mar 2015 21:33:28 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t2A1XSHU012745
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <ceph-devel@vger.kernel.org>; Mon, 9 Mar 2015 21:33:28 -0400
Received: from Davids-iMac.local (vpn-235-166.phx2.redhat.com [10.3.235.166])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t2A1XRJw031684
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO)
	for <ceph-devel@vger.kernel.org>; Mon, 9 Mar 2015 21:33:28 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>


I was having trouble building man pages on my Ubuntu 14.04 build 
machine, so I looked at gitbuilder-doc.  I saw that it was running 
Ubuntu 11.10.  Even though the end-of-life for Ubuntu 11.10 was May 9, 
2013, I installed a new virtual machine with it. I needed to change 
/etc/apt/sources.list in use old-releases.ubuntu.com to install 
additional packages.  Just like gitbuilder-doc the admin/build-doc 
command runs without errors.

I assume other distributions with more up to date packages will see the 
same problem.  I filed bug #11077 with the sphinx log attached.

David Zafman
