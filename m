From: Loic Dachary <loic@dachary.org>
Subject: Re: arm64 public OpenStack provider
Date: Tue, 29 Mar 2016 18:55:20 +0200
Message-ID: <56FAB378.2010607@dachary.org>
References: <56FA57E8.10705@dachary.org> <56FA9BE6.1020404@6wind.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:44334 "EHLO
	relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752809AbcC2QzZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 Mar 2016 12:55:25 -0400
In-Reply-To: <56FA9BE6.1020404@6wind.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Vincent JARDIN <vincent.jardin@6wind.com>, Florian Haas <florian@hastexo.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Vincent,

On 29/03/2016 17:14, Vincent JARDIN wrote:
> Loic,
>=20
> you can use:
>   https://www.scaleway.com/pricing/
>     4 Dedicated ARM Cores / 3=E2=82=AC/month
>=20

It's definitely the cheapest cloud I know. Last time I checked it did n=
ot support the OpenStack API though. Did that change recently ?

Cheers

> Le 29/03/2016 12:24, Loic Dachary a =C3=A9crit :
>> Hi Florian,
>>
>> Do you happen to know if there exists a public OpenStack provider wh=
ere you can instantiate arm64 instances ? We're now able to run integra=
tion tests on such a cluster and people with access to http://cloudlab.=
us can benefit from that. I'm looking for an alternative so everyone ca=
n give it a try.
>>
>> An experiment at https://www.runabove.com/armcloud.xml may eventuall=
y lead to a publicly available service but the beta is currently closed=
 (fully booked). Although we've been granted access, it's not a solutio=
n right now.
>>
>> http://www.datacentred.co.uk/ no longer provides arm64 instances.
>>
>> A quick look at http://www.openstack.org/marketplace/public-clouds/ =
does not show which architectures are available. I could go to each of =
them, one after the other, but I'm hoping you already know the answer :=
-)
>>
>> Cheers
>>
>=20
> --=20
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
