From: Dan Mick <dan.mick@inktank.com>
Subject: Re: collectd plugin with cuttlefish
Date: Fri, 30 Aug 2013 17:38:44 -0700
Message-ID: <52213B14.4030604@inktank.com>
References: <CAFtEh-fCrPCx19BkG-CN7KP=ag3czMbZ=xQuHKOecMsUF2Z36g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:50963 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752725Ab3HaAir (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 30 Aug 2013 20:38:47 -0400
Received: by mail-pd0-f170.google.com with SMTP id x10so2488803pdj.15
        for <ceph-devel@vger.kernel.org>; Fri, 30 Aug 2013 17:38:47 -0700 (PDT)
In-Reply-To: <CAFtEh-fCrPCx19BkG-CN7KP=ag3czMbZ=xQuHKOecMsUF2Z36g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Damien Churchill <damoxc@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

It's a bit surprising that it broke with cuttlefish; something might 
have happened in dumpling, but we wouldn't expect changes in cuttlefish.
It looks like collectd just couldn't talk to the monitor properly.
Maybe look at the mon's log and see what it thinks it saw?

On 08/30/2013 05:04 AM, Damien Churchill wrote:
> Hi,
>
> Has anything changed with the admin socket that would prevent the
> collectd plugin (compiled against 5.3.1 using the patches submitted to
> the collectd ML) from gathering stats? I've recompiled collectd with
> --enable-debug and receive the following output in the log:
>
> ceph_init
> name=mon_ceph1, asok_path=/var/run/ceph/ceph-mon.ceph1.asok
> entering cconn_main_loop(request_type = 0)
> did cconn_prepare(name=mon_ceph1,i=0,st=1)
> cconn_handle_event(name=mon_ceph1,state=1,amt=0,ret=4)
> did cconn_prepare(name=mon_ceph1,i=0,st=2)
> did cconn_prepare(name=mon_ceph1,i=0,st=2)
> ERROR: cconn_main_loop: timed out.
> cconn_main_loop: reached all Ceph daemons :)
> Initialization of plugin `ceph' failed with status -110. Plugin will
> be unloaded.
> plugin_unregister_read: Marked `ceph' for removal.
>
> Thanks in advance!
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
