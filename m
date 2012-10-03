From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: crush: warn on do_rule failure
Date: Wed, 3 Oct 2012 10:24:12 +0300
Message-ID: <20121003072412.GA10383@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:38531 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756074Ab2JCHYU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Oct 2012 03:24:20 -0400
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sage@inktank.com
Cc: ceph-devel@vger.kernel.org

Hello Sage Weil,

The patch 8b3932690084: "crush: warn on do_rule failure" from May 7,
2012, leads to the following warning:
net/ceph/osdmap.c:1117:8: warning: comparison of unsigned expression < 0 is always false [-Wtautological-compare]

net/ceph/osdmap.c
  1114          r = crush_do_rule(osdmap->crush, ruleno, pps, osds,
  1115                            min_t(int, pool->v.size, *num),
  1116                            osdmap->osd_weight);
  1117          if (r < 0) {
                    ^^^^^
r is unsigned so it's never less than zero.  Also crush_do_rule() never
returns negative numbers.

  1118                  pr_err("error %d from crush rule: pool %d ruleset %d type %d"
  1119                         " size %d\n", r, poolid, pool->v.crush_ruleset,
  1120                         pool->v.type, pool->v.size);
  1121                  return NULL;
  1122          }
  1123          *num = r;

regards,
dan carpenter

