From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: systemd and RDMA
Date: Fri, 24 Feb 2017 05:50:37 +0100
Message-ID: <d09496ec-f575-e62a-5088-4865916100aa@suse.cz>
References: <VI1PR0501MB278205C007302409F70B10B2D7530@VI1PR0501MB2782.eurprd05.prod.outlook.com>
 <alpine.DEB.2.11.1702231425150.7782@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:33508 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750873AbdBXFXm (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 24 Feb 2017 00:23:42 -0500
In-Reply-To: <alpine.DEB.2.11.1702231425150.7782@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, Adir Lev <adirl@mellanox.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, kefu chai <tchaikov@gmail.com>

>> Any suggestion on how to check messenger type and set PrivateDevices and
>> LimitMEMLOCK accordingly?
>
> Hmm, is it possible to make them conditional on something in
> /etc/{sysconfig,default}/ceph?  Then an RDMA user would just need to
> comment in a line like ENABLE_RDMA=1 or something...

+1

Can you open a tracker issue for this request?

Nathan
