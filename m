From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: ceph: cope with out of order (unsafe after safe) mds reply
Date: Mon, 10 Aug 2015 17:54:36 +0300
Message-ID: <20150810145436.GA14295@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:26583 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752971AbbHJOyo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Aug 2015 10:54:44 -0400
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sage@newdream.net
Cc: ceph-devel@vger.kernel.org

Hello Sage Weil,

The patch 85792d0dd6e7: "ceph: cope with out of order (unsafe after
safe) mds reply" from May 13, 2010, leads to the following static
checker warning:

	fs/ceph/mds_client.c:2414 handle_reply()
	warn: we tested 'head->safe' before and it was 'false'

fs/ceph/mds_client.c
  2406          /* dup? */
  2407          if ((req->r_got_unsafe && !head->safe) ||
  2408              (req->r_got_safe && head->safe)) {
                     ^^^^^^^^^^^^^^^    ^^^^^^^^^^
If ->r_got_safe is set we always fail.  If head->safe is set then we
fail here.

  2409                  pr_warn("got a dup %s reply on %llu from mds%d\n",
  2410                             head->safe ? "safe" : "unsafe", tid, mds);
  2411                  mutex_unlock(&mdsc->mutex);
  2412                  goto out;
  2413          }
  2414          if (req->r_got_safe && !head->safe) {

Otherwise we fail here.  The only thing different is the error message.

  2415                  pr_warn("got unsafe after safe on %llu from mds%d\n",
  2416                             tid, mds);
  2417                  mutex_unlock(&mdsc->mutex);
  2418                  goto out;
  2419          }

regards,
dan carpenter
