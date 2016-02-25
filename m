From: Loic Dachary <loic@dachary.org>
Subject: Building packages from a SHA instead of the tip of a branch
Date: Thu, 25 Feb 2016 19:28:25 +0700
Message-ID: <56CEF369.7020403@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:47203 "EHLO
	relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759631AbcBYM2d (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Feb 2016 07:28:33 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Meno <gmeno@redhat.com>, Alfredo Deza <adeza@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Gregory and Alfredo,

The system in place to build packages uses the tip of the stable branch=
, which has been a recurring problem over the past years. It would make=
 a lot of sense to use a specific SHA1 instead of "whatever is at the t=
ip of the stable branch at the moment".

Is there already an issue in tracker.ceph.com for this ? If not, in whi=
ch tracker do you suggest I file this feature request ?

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
