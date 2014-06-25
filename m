From: Luis Pabon <lpabon@redhat.com>
Subject: Speeding up ceph builds
Date: Wed, 25 Jun 2014 11:15:44 -0400
Message-ID: <53AAE7A0.5060404@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38842 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756769AbaFYPPp (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 25 Jun 2014 11:15:45 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s5PFFiRe029894
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <ceph-devel@vger.kernel.org>; Wed, 25 Jun 2014 11:15:45 -0400
Received: from lpabon-desktop.bos.redhat.com ([10.18.41.173])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id s5PFFiPq005856
	for <ceph-devel@vger.kernel.org>; Wed, 25 Jun 2014 11:15:44 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,
   I have tried disabling static builds which cut build time by half.  I 
have built it without static builds and they work, but I wanted to see 
if others could try it out also and determine that the software still 
works.  To speed up the build time, you can type:

./configure --disable-static

If no one finds any issues with this mode, we can set it up as the 
default in configure.ac.

This could provide a speed up while we wait for the Cmake patch.

- Luis
