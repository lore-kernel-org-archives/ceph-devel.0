From: Sage Weil <sage@newdream.net>
Subject: Re: values of "ceph daemon osd.x perf dump objecters " are zero
Date: Wed, 28 Oct 2015 17:07:23 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1510281707090.1004@cobra.newdream.net>
References: <CAN4gH2NKLL=EeTT9axTjCN8dpqRzt2JBEUTfhbQFLYS8+c8DrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44441 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751175AbbJ2AHY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 28 Oct 2015 20:07:24 -0400
In-Reply-To: <CAN4gH2NKLL=EeTT9axTjCN8dpqRzt2JBEUTfhbQFLYS8+c8DrA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Libin Wu <hzwulibin@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>

Objecter is the client side, but you're dumping stats on the osd.  The 
only time it is used as a client there is with cache tiering.

sage

On Wed, 28 Oct 2015, Libin Wu wrote:

> Hi, all
> 
> As my understand, command "ceph daemon osd.x perf dump objecters" should
> output the perf data of osdc(librados). But when i use this command,
> why all those values are zero expcept map_epoch and map_inc. Follow is
> the result(It has fio test with rbd ioengine on the cluster):
> 
> 
> $ sudo ceph daemon osd.10 perf dump objecter
> 
> {
> 
>     "objecter": {
> 
>         "op_active": 0,
> 
>         "op_laggy": 0,
> 
>         "op_send": 0,
> 
>         "op_send_bytes": 0,
> 
>         "op_resend": 0,
> 
>         "op_ack": 0,
> 
>         "op_commit": 0,
> 
>         "op": 0,
> 
>         "op_r": 0,
> 
>         "op_w": 0,
> 
>         "op_rmw": 0,
> 
>         "op_pg": 0,
> 
>         "osdop_stat": 0,
> 
>         "osdop_create": 0,
> 
>         "osdop_read": 0,
> 
>         "osdop_write": 0,
> 
>         "osdop_writefull": 0,
> 
>         "osdop_append": 0,
> 
>         "osdop_zero": 0,
> 
>         "osdop_truncate": 0,
> 
>         "osdop_delete": 0,
> 
>         "osdop_mapext": 0,
> 
>         "osdop_sparse_read": 0,
> 
>         "osdop_clonerange": 0,
> 
>         "osdop_getxattr": 0,
> 
>         "osdop_setxattr": 0,
> 
>         "osdop_cmpxattr": 0,
> 
>         "osdop_rmxattr": 0,
> 
>         "osdop_resetxattrs": 0,
> 
>         "osdop_tmap_up": 0,
> 
>         "osdop_tmap_put": 0,
> 
>         "osdop_tmap_get": 0,
> 
>         "osdop_call": 0,
> 
>         "osdop_watch": 0,
> 
>         "osdop_notify": 0,
> 
>         "osdop_src_cmpxattr": 0,
> 
>         "osdop_pgls": 0,
> 
>         "osdop_pgls_filter": 0,
> 
>         "osdop_other": 0,
> 
>         "linger_active": 0,
> 
>         "linger_send": 0,
> 
>         "linger_resend": 0,
> 
>         "linger_ping": 0,
> 
>         "poolop_active": 0,
> 
>         "poolop_send": 0,
> 
>         "poolop_resend": 0,
> 
>         "poolstat_active": 0,
> 
>         "poolstat_send": 0,
> 
>         "poolstat_resend": 0,
> 
>         "statfs_active": 0,
> 
>         "statfs_send": 0,
> 
>         "statfs_resend": 0,
> 
>         "command_active": 0,
> 
>         "command_send": 0,
> 
>         "command_resend": 0,
> 
>         "map_epoch": 2180,
> 
>         "map_full": 0,
> 
>         "map_inc": 83,
> 
>         "osd_sessions": 0,
> 
>         "osd_session_open": 0,
> 
>         "osd_session_close": 0,
> 
>         "osd_laggy": 0
> 
>     }
> 
> }
> 
> Anyone could tell why?
> 
> Thanks!
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
