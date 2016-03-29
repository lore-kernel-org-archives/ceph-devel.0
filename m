From: Loic Dachary <loic@dachary.org>
Subject: arm64 public OpenStack provider
Date: Tue, 29 Mar 2016 12:24:40 +0200
Message-ID: <56FA57E8.10705@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:49295 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750984AbcC2KYs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 Mar 2016 06:24:48 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Florian Haas <florian@hastexo.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Florian,

Do you happen to know if there exists a public OpenStack provider where=
 you can instantiate arm64 instances ? We're now able to run integratio=
n tests on such a cluster and people with access to http://cloudlab.us =
can benefit from that. I'm looking for an alternative so everyone can g=
ive it a try.

An experiment at https://www.runabove.com/armcloud.xml may eventually l=
ead to a publicly available service but the beta is currently closed (f=
ully booked). Although we've been granted access, it's not a solution r=
ight now.

http://www.datacentred.co.uk/ no longer provides arm64 instances.

A quick look at http://www.openstack.org/marketplace/public-clouds/ doe=
s not show which architectures are available. I could go to each of the=
m, one after the other, but I'm hoping you already know the answer :-)

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
