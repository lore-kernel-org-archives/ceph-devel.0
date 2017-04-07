From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: rbdmap.service - which package?
Date: Fri, 7 Apr 2017 08:30:56 +0200
Message-ID: <bd0e492b-0778-39a6-4b39-1c6f98355bc8@suse.cz>
References: <CAGbviv+T5k6U62D9H0BJLdFQohVkwO+1WrGSPrKJQ1FAtppfyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:48862 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752245AbdDGGbA (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 7 Apr 2017 02:31:00 -0400
In-Reply-To: <CAGbviv+T5k6U62D9H0BJLdFQohVkwO+1WrGSPrKJQ1FAtppfyg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>, Ceph Development <ceph-devel@vger.kernel.org>

Confirmed bug in jewel - http://tracker.ceph.com/issues/19547

Fix coming (hopefully) in 10.2.8

Thanks for reporting!

Nathan

On 04/06/2017 11:01 PM, Wyllys Ingersoll wrote:
> Which package is the systemd script for rbdmap ("rbdmap.service")
> supposed to be delivered in?
>
> I have 10.2.6 installed and that particular service script is not
> installed anywhere, the old sysv startup script (/etc/init.d/rbdmap)
> is present, but the proper rbdmap.service is not.
>
> Is this correct?
>
> - Wyllys Ingersoll
>   Keeper Technology
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
