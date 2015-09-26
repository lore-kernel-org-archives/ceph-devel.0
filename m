From: Matt Benjamin <mbenjamin@redhat.com>
Subject: libcephfs invalidate upcalls
Date: Sat, 26 Sep 2015 15:03:40 -0400 (EDT)
Message-ID: <1783969650.22232082.1443294220601.JavaMail.zimbra@redhat.com>
References: <1591173292.22231917.1443293684497.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:52751 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753293AbbIZTDl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 26 Sep 2015 15:03:41 -0400
In-Reply-To: <1591173292.22231917.1443293684497.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>
Cc: John Spray <jspray@redhat.com>

Hi John,

I prototyped an invalidate upcall for libcephfs and the Gasesha Ceph fsal, building on the Client invalidation callback registrations.

As you suggested, NFS (or AFS, or DCE) minimally expect a more generic "cached vnode may have changed" trigger than the current inode and dentry invalidates, so I extended the model slightly to hook cap revocation, feedback appreciated.

git@github.com:linuxbox2/ceph.git , branch invalidate
git@github.com:linuxbox2/nfs-ganesha.git , branch ceph-invalidates

thanks,

Matt

-- 
Matt Benjamin
Red Hat, Inc.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://www.redhat.com/en/technologies/storage

tel.  734-761-4689
fax.  734-769-8938
cel.  734-216-5309

