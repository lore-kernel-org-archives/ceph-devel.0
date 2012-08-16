From: Tommi Virtanen <tv@inktank.com>
Subject: Re: host settings in ceph.conf when ipaddress != hostname
Date: Thu, 16 Aug 2012 13:12:55 -0700
Message-ID: <CADvuQRF5RmstmedjnxW7LOn-5zqSntsWxc6Kd0xuK+n3_aKPDQ@mail.gmail.com>
References: <CACkq2moqr-VpwLpG2xcTvUfJ4Xm0EKazis4pW_M4FLuATqOHVg@mail.gmail.com>
 <CADvuQRFZRwL4oBvJW2H25VFME3pTk4rDZxr4WzwMT=sp-K8h6g@mail.gmail.com> <502D51D4.5010606@smart-weblications.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:49791 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030304Ab2HPUNR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Thu, 16 Aug 2012 16:13:17 -0400
Received: by lagy9 with SMTP id y9so1698467lag.19
        for <ceph-devel@vger.kernel.org>; Thu, 16 Aug 2012 13:13:15 -0700 (PDT)
In-Reply-To: <502D51D4.5010606@smart-weblications.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Smart Weblications GmbH <info@smart-weblications.de>
Cc: Travis Rhoden <trhoden@gmail.com>, ceph-devel@vger.kernel.org

2012/8/16 Smart Weblications GmbH <info@smart-weblications.de>:
>> It sounds like you want to set set public_network and cluster_network
>> in [global] both to 10.30.0.0/8.
>
> 10.0.0.0/8 or 10.30.0.0/16, nor? ;-)

Yeah /16 probably. He only gave example IPs from the two networks, so
not completely sure.
