From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: rbd: enforce parent overlap
Date: Tue, 30 Apr 2013 10:24:10 +0300
Message-ID: <20130430072410.GA7237@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:17613 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751586Ab3D3HYS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Apr 2013 03:24:18 -0400
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: elder@inktank.com
Cc: ceph-devel@vger.kernel.org

Hello Alex Elder,

This is a semi-automatic email about new static checker warnings.

The patch 64548e0638af: "rbd: enforce parent overlap" from Apr 21,
2013, leads to the following Smatch complaint:

drivers/block/rbd.c:1449 rbd_osd_read_callback()
	 error: we previously assumed 'img_request' could be null (see line 1448)

drivers/block/rbd.c
  1447			img_request = obj_request->img_request;
  1448			layered = img_request && img_request_layered_test(img_request);
                                  ^^^^^^^^^^^
Old check.
  1449			rbd_dev = img_request->rbd_dev;
                                  ^^^^^^^^^^^^^^^^^^^^
New dereference.

  1450		}
  1451	

regards,
dan carpenter
