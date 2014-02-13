From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: rbd: use watch/notify for changes in rbd header
Date: Thu, 13 Feb 2014 12:50:06 +0300
Message-ID: <20140213095005.GA27350@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:34872 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751880AbaBMJuB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Feb 2014 04:50:01 -0500
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: yehuda@hq.newdream.net
Cc: ceph-devel@vger.kernel.org

Hello Yehuda Sadeh,

The patch 59c2be1e4d42: "rbd: use watch/notify for changes in rbd
header" from Mar 21, 2011, leads to the following static checker
warning:

	drivers/block/rbd.c:687 parse_rbd_opts_token()
	warn: we tested 'token < 0' before and it was 'false'

drivers/block/rbd.c
   677  static int parse_rbd_opts_token(char *c, void *private)
   678  {
   679          struct rbd_options *rbd_opts = private;
   680          substring_t argstr[MAX_OPT_ARGS];
   681          int token, intval, ret;
   682  
   683          token = match_token(c, rbd_opts_tokens, argstr);
   684          if (token < 0)
                    ^^^^^^^^^
   685                  return -EINVAL;
   686  
   687          if (token < Opt_last_int) {
                    ^^^^^^^^^^^^^^^^^^^^
Opt_last_int is zero so this is never true.  Should the < be == or
something?

   688                  ret = match_int(&argstr[0], &intval);
   689                  if (ret < 0) {
   690                          pr_err("bad mount option arg (not int) "
   691                                 "at '%s'\n", c);
   692                          return ret;
   693                  }
   694                  dout("got int token %d val %d\n", token, intval);
   695          } else if (token > Opt_last_int && token < Opt_last_string) {
   696                  dout("got string token %d val %s\n", token,
   697                       argstr[0].from);
   698          } else if (token > Opt_last_string && token < Opt_last_bool) {
   699                  dout("got Boolean token %d\n", token);
   700          } else {
   701                  dout("got token %d\n", token);
   702          }

regards,
dan carpenter
