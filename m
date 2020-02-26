From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [bug report] libceph: revamp subs code, switch to SUBSCRIBE2 protocol
Date: Wed, 26 Feb 2020 17:59:27 +0300
Message-ID: <20200226145927.jtuc5bgiojhoefad@kili.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from aserp2120.oracle.com ([141.146.126.78]:34562 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbgBZO7h (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 26 Feb 2020 09:59:37 -0500
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: idryomov@gmail.com
Cc: ceph-devel@vger.kernel.org

Hello Ilya Dryomov,

The patch 82dcabad750a: "libceph: revamp subs code, switch to
SUBSCRIBE2 protocol" from Jan 19, 2016, leads to the following static
checker warning:

	net/ceph/mon_client.c:495 ceph_monc_handle_map()
	error: dereferencing freed memory 'monc->monmap'

net/ceph/mon_client.c
   466  static void ceph_monc_handle_map(struct ceph_mon_client *monc,
   467                                   struct ceph_msg *msg)
   468  {
   469          struct ceph_client *client = monc->client;
   470          struct ceph_monmap *monmap = NULL, *old = monc->monmap;
                                                    ^^^^^^^^^^^^^^^^^^

   471          void *p, *end;
   472  
   473          mutex_lock(&monc->mutex);
   474  
   475          dout("handle_monmap\n");
   476          p = msg->front.iov_base;
   477          end = p + msg->front.iov_len;
   478  
   479          monmap = ceph_monmap_decode(p, end);
   480          if (IS_ERR(monmap)) {
   481                  pr_err("problem decoding monmap, %d\n",
   482                         (int)PTR_ERR(monmap));
   483                  ceph_msg_dump(msg);
   484                  goto out;
   485          }
   486  
   487          if (ceph_check_fsid(monc->client, &monmap->fsid) < 0) {
   488                  kfree(monmap);
   489                  goto out;
   490          }
   491  
   492          client->monc.monmap = monmap;
   493          kfree(old);
                      ^^^
Frees monc->monmap.

   494  
   495          __ceph_monc_got_map(monc, CEPH_SUB_MONMAP, monc->monmap->epoch);
                                                           ^^^^^^^^^^^^
Should this be "client->monc.monmap" or maybe just "monmap"?

   496          client->have_fsid = true;
   497  
   498  out:
   499          mutex_unlock(&monc->mutex);
   500          wake_up_all(&client->auth_wq);
   501  }

regards,
dan carpenter
