From: Libin Wu <hzwulibin@gmail.com>
Subject: values of "ceph daemon osd.x perf dump objecters " are zero
Date: Wed, 28 Oct 2015 23:41:40 +0800
Message-ID: <CAN4gH2NKLL=EeTT9axTjCN8dpqRzt2JBEUTfhbQFLYS8+c8DrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f195.google.com ([209.85.212.195]:36846 "EHLO
	mail-wi0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932537AbbJ1Pll (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 28 Oct 2015 11:41:41 -0400
Received: by wibvt6 with SMTP id vt6so2918247wib.3
        for <ceph-devel@vger.kernel.org>; Wed, 28 Oct 2015 08:41:40 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>

Hi, all

As my understand, command "ceph daemon osd.x perf dump objecters" should
output the perf data of osdc(librados). But when i use this command,
why all those values are zero expcept map_epoch and map_inc. Follow is
the result(It has fio test with rbd ioengine on the cluster):


$ sudo ceph daemon osd.10 perf dump objecter

{

    "objecter": {

        "op_active": 0,

        "op_laggy": 0,

        "op_send": 0,

        "op_send_bytes": 0,

        "op_resend": 0,

        "op_ack": 0,

        "op_commit": 0,

        "op": 0,

        "op_r": 0,

        "op_w": 0,

        "op_rmw": 0,

        "op_pg": 0,

        "osdop_stat": 0,

        "osdop_create": 0,

        "osdop_read": 0,

        "osdop_write": 0,

        "osdop_writefull": 0,

        "osdop_append": 0,

        "osdop_zero": 0,

        "osdop_truncate": 0,

        "osdop_delete": 0,

        "osdop_mapext": 0,

        "osdop_sparse_read": 0,

        "osdop_clonerange": 0,

        "osdop_getxattr": 0,

        "osdop_setxattr": 0,

        "osdop_cmpxattr": 0,

        "osdop_rmxattr": 0,

        "osdop_resetxattrs": 0,

        "osdop_tmap_up": 0,

        "osdop_tmap_put": 0,

        "osdop_tmap_get": 0,

        "osdop_call": 0,

        "osdop_watch": 0,

        "osdop_notify": 0,

        "osdop_src_cmpxattr": 0,

        "osdop_pgls": 0,

        "osdop_pgls_filter": 0,

        "osdop_other": 0,

        "linger_active": 0,

        "linger_send": 0,

        "linger_resend": 0,

        "linger_ping": 0,

        "poolop_active": 0,

        "poolop_send": 0,

        "poolop_resend": 0,

        "poolstat_active": 0,

        "poolstat_send": 0,

        "poolstat_resend": 0,

        "statfs_active": 0,

        "statfs_send": 0,

        "statfs_resend": 0,

        "command_active": 0,

        "command_send": 0,

        "command_resend": 0,

        "map_epoch": 2180,

        "map_full": 0,

        "map_inc": 83,

        "osd_sessions": 0,

        "osd_session_open": 0,

        "osd_session_close": 0,

        "osd_laggy": 0

    }

}

Anyone could tell why?

Thanks!
