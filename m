From: Loic Dachary <loic@dachary.org>
Subject: rbd jewel backports related to mirroring
Date: Wed, 29 Jun 2016 11:07:51 +0200
Message-ID: <57738FE7.4060309@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:57902 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751670AbcF2JIR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Jun 2016 05:08:17 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jason Dillaman <dillaman@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Jason,

While working on jewel backports I noticed that there are a number of r=
bd backports ( http://tracker.ceph.com/projects/ceph/issues?per_page=3D=
100&query_id=3D96 ) related to mirroring. At least three of them do not=
 apply cleanly and I suspect they are interdependant. Is there a way to=
 figure out the order in which they should be applied ? If not I'll sor=
t it out anyway, no worries ;-)

Cheers
--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
