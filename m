From: Damien Churchill <damoxc@gmail.com>
Subject: collectd plugin with cuttlefish
Date: Fri, 30 Aug 2013 13:04:45 +0100
Message-ID: <CAFtEh-fCrPCx19BkG-CN7KP=ag3czMbZ=xQuHKOecMsUF2Z36g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:54235 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754951Ab3H3MEp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 30 Aug 2013 08:04:45 -0400
Received: by mail-pa0-f51.google.com with SMTP id lf1so2238951pab.24
        for <ceph-devel@vger.kernel.org>; Fri, 30 Aug 2013 05:04:45 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

Has anything changed with the admin socket that would prevent the
collectd plugin (compiled against 5.3.1 using the patches submitted to
the collectd ML) from gathering stats? I've recompiled collectd with
--enable-debug and receive the following output in the log:

ceph_init
name=mon_ceph1, asok_path=/var/run/ceph/ceph-mon.ceph1.asok
entering cconn_main_loop(request_type = 0)
did cconn_prepare(name=mon_ceph1,i=0,st=1)
cconn_handle_event(name=mon_ceph1,state=1,amt=0,ret=4)
did cconn_prepare(name=mon_ceph1,i=0,st=2)
did cconn_prepare(name=mon_ceph1,i=0,st=2)
ERROR: cconn_main_loop: timed out.
cconn_main_loop: reached all Ceph daemons :)
Initialization of plugin `ceph' failed with status -110. Plugin will
be unloaded.
plugin_unregister_read: Marked `ceph' for removal.

Thanks in advance!
