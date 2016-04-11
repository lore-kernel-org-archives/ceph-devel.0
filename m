From: Loic Dachary <loic@dachary.org>
Subject: CephFS and the next hammer release v0.94.7
Date: Mon, 11 Apr 2016 13:31:42 +0200
Message-ID: <570B8B1E.5060505@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:40866 "EHLO
	relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752802AbcDKLbv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Apr 2016 07:31:51 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Nathan Cutler <ncutler@suse.cz>

Hi Greg,

The next hammer release as found at https://github.com/ceph/ceph/tree/h=
ammer passed most of the fs suite (http://pulpito.ovh.sepia.ceph.com:80=
81/teuthology-2016-04-10_17:00:02-fs-hammer---basic-openstack/) failed =
2 and has 5 dead. There are no matching tests in on the sepia lab.

Do you think the hammer branch is ready for QE to start their own round=
 of testing ? Or should the above errors be investigated first ?

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
