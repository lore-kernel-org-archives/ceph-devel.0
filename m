From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: ceph: fix encoding of ino only (not relative) paths
Date: Fri, 28 Sep 2012 18:46:28 +0300
Message-ID: <20120928154628.GA19145@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:32009 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757969Ab2I1Pqi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 28 Sep 2012 11:46:38 -0400
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sage@newdream.net
Cc: ceph-devel@vger.kernel.org

Hello Sage Weil,

This is a semi-automatic email about new static checker warnings.

The patch 795858dbd253: "ceph: fix encoding of ino only (not 
relative) paths" from Aug 15, 2011, leads to the following Smatch 
complaint:

fs/ceph/mds_client.c:1593 set_request_path_attr()
	 error: we previously assumed 'rpath' could be null (see line 1590)

fs/ceph/mds_client.c
  1589			     *ppath);
  1590		} else if (rpath || rino) {
                           ^^^^^^^^^^^^^
Check.

  1591			*ino = rino;
  1592			*ppath = rpath;
  1593			*pathlen = strlen(rpath);
                                   ^^^^^^^^^^^^^
Dereference.

  1594			dout(" path %.*s\n", *pathlen, rpath);
  1595		}

regards,
dan carpenter

