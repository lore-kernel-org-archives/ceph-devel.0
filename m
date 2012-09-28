From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: ceph: factor out libceph from Ceph file system
Date: Fri, 28 Sep 2012 18:46:44 +0300
Message-ID: <20120928154643.GB19145@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:20717 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758568Ab2I1Pqy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 28 Sep 2012 11:46:54 -0400
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: yehuda@hq.newdream.net
Cc: ceph-devel@vger.kernel.org

Hello Yehuda Sadeh,

This is a semi-automatic email about new static checker warnings.

The patch 3d14c5d2b6e1: "ceph: factor out libceph from Ceph file 
system" from Apr 6, 2010, leads to the following Smatch complaint:

fs/ceph/super.c:279 strcmp_null()
	 error: we previously assumed 's1' could be null (see line 277)

fs/ceph/super.c
   276			return -1;
   277		if (!s1 && s2)
                    ^^^^^^^^^
Check.

   278			return 1;
   279		return strcmp(s1, s2);
                       ^^^^^^^^^^^^^^
Dereference inside function call.

   280	}
   281	

regards,
dan carpenter

See also:
