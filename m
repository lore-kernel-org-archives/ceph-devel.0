From: Vincent JARDIN <vincent.jardin@6wind.com>
Subject: Re: arm64 public OpenStack provider
Date: Tue, 29 Mar 2016 17:14:46 +0200
Message-ID: <56FA9BE6.1020404@6wind.com>
References: <56FA57E8.10705@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:37155 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752746AbcC2PQf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 Mar 2016 11:16:35 -0400
Received: by mail-wm0-f47.google.com with SMTP id p65so31198944wmp.0
        for <ceph-devel@vger.kernel.org>; Tue, 29 Mar 2016 08:16:33 -0700 (PDT)
In-Reply-To: <56FA57E8.10705@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, Florian Haas <florian@hastexo.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Loic,

you can use:
   https://www.scaleway.com/pricing/
     4 Dedicated ARM Cores / 3=E2=82=AC/month

Le 29/03/2016 12:24, Loic Dachary a =C3=A9crit :
> Hi Florian,
>
> Do you happen to know if there exists a public OpenStack provider whe=
re you can instantiate arm64 instances ? We're now able to run integrat=
ion tests on such a cluster and people with access to http://cloudlab.u=
s can benefit from that. I'm looking for an alternative so everyone can=
 give it a try.
>
> An experiment at https://www.runabove.com/armcloud.xml may eventually=
 lead to a publicly available service but the beta is currently closed =
(fully booked). Although we've been granted access, it's not a solution=
 right now.
>
> http://www.datacentred.co.uk/ no longer provides arm64 instances.
>
> A quick look at http://www.openstack.org/marketplace/public-clouds/ d=
oes not show which architectures are available. I could go to each of t=
hem, one after the other, but I'm hoping you already know the answer :-=
)
>
> Cheers
>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
