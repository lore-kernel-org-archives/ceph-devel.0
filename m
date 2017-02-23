From: Sage Weil <sage@newdream.net>
Subject: Re: systemd and RDMA
Date: Thu, 23 Feb 2017 14:26:05 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1702231425150.7782@piezo.novalocal>
References: <VI1PR0501MB278205C007302409F70B10B2D7530@VI1PR0501MB2782.eurprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44947 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751070AbdBWOhR (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 23 Feb 2017 09:37:17 -0500
In-Reply-To: <VI1PR0501MB278205C007302409F70B10B2D7530@VI1PR0501MB2782.eurprd05.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Adir Lev <adirl@mellanox.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, kefu chai <tchaikov@gmail.com>

On Thu, 23 Feb 2017, Adir Lev wrote:
> Hi Cephers,
> 
> In order to use systemctl with RDMA messenger we need to make few changes to /etc/systemd/system/
> 1. Set PrivateDevices=no
> 2. Set LimitMEMLOCK=infinity
> see PR: https://github.com/ceph/ceph/pull/13305
> 
> I got few rejects suggesting to change those params only when actually using RDMA.
> Since systemd scripts are the first to run we cannot check it in ceph code.
> 
> Any suggestion on how to check messenger type and set PrivateDevices and 
> LimitMEMLOCK accordingly?

Hmm, is it possible to make them conditional on something in 
/etc/{sysconfig,default}/ceph?  Then an RDMA user would just need to 
comment in a line like ENABLE_RDMA=1 or something...

sage
