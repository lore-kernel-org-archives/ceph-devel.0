From: Loic Dachary <loic@dachary.org>
Subject: getting ready for jewel 10.2.1
Date: Wed, 30 Mar 2016 12:30:55 +0200
Message-ID: <56FBAADF.3020407@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:54882 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105AbcC3KbE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Mar 2016 06:31:04 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek Varshney <abhishek.varshney@flipkart.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

Now is a good time to get ready for jewel 10.2.1 and I created http://t=
racker.ceph.com/issues/15317 for that purpose. The goal is to be able t=
o run as many suites as possible on OpenStack, so that we do not have t=
o wait days (sometime a week) for runs to complete on Sepia. Best case =
scenario, all OpenStack specific problems are fixed by the time 10.2.1 =
is being prepared. Worst case scenario there is no time to fix issues a=
nd we keep using the sepia lab. I guess we'll end up somewhere in the m=
iddle : some suites will run fine on Openstack and we'll use sepia for =
others.

In a previous mail I voiced my concerns regarding the lack of interest =
of developers regarding teuthology job failures that are cause by varia=
tions in the infrastructure. I still have no clue how to convey my beli=
ef that it is important for teuthology jobs to succeed despite infrastr=
ucture variations. But instead of just giving up and do nothing, I will=
 work on that for the rados suite and hope things will evolve in a good=
 way. To be honest, figuring out http://tracker.ceph.com/issues/15236 a=
nd seeing a good run of the rados suite on jewel as a result renewed my=
 motivation in that area :-)

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
