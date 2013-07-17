From: Kasper Dieter <dieter.kasper@ts.fujitsu.com>
Subject: Re: Any concern about Ceph on CentOS
Date: Wed, 17 Jul 2013 08:16:55 +0200
Message-ID: <20130717061655.GB13122@oder.mch.fsc.net>
References: <6F3FA899187F0043BA1827A69DA2F7CC01E43F83@SHSMSX102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from dgate20.ts.fujitsu.com ([80.70.172.51]:31699 "EHLO
	dgate20.ts.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751923Ab3GQGRM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Jul 2013 02:17:12 -0400
Content-Disposition: inline
In-Reply-To: <6F3FA899187F0043BA1827A69DA2F7CC01E43F83@SHSMSX102.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@ceph.com" <ceph-users@ceph.com>

Hi Xiaoxi,

we are really running Ceph on CentOS-6.4
(6 server nodes, 3 client nodes, 160 OSDs).

We put a 3.8.13 Kernel on top and installed the ceph-0.61.4 cluster with mkcephfs, 
because ceph-deploy seems to be still very buggy and has big dependencies to the newest python.

ceph.ko
rbd.ko
and ceph-fuse are running fast, well and stable (so far ;-) ).

Cheers,
-Dieter

On Wed, Jul 17, 2013 at 03:18:22AM +0200, Chen, Xiaoxi wrote:
> Hi list,
>    I would like to ask if anyone really run Ceph on CentOS/RHEL? 
>    Since the kernel version for Cent/RHEL is much older than that of Ubuntu, 
>    I am thinking about whether we have some known performance/functionality issue?
>    Thanks for everyone could share your insight for Ceph+CentOS.
> 																												Xiaoxi 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
