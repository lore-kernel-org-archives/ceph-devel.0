From: Loic Dachary <loic@dachary.org>
Subject: rgw and the next hammer release v0.94.7
Date: Mon, 11 Apr 2016 13:43:42 +0200
Message-ID: <570B8DEE.2020804@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:51144 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085AbcDKLnq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Apr 2016 07:43:46 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Nathan Cutler <ncutler@suse.cz>

Hi Yehuda,

The next hammer release as found at https://github.com/ceph/ceph/tree/h=
ammer passed most the rgw suite (http://tracker.ceph.com/issues/14692#n=
ote-46).=20

One failure is http://tracker.ceph.com/issues/15316 when seems related =
to how ansible installs Amazon::S3
The other is a valgrind issue which seems new http://pulpito.ceph.com/l=
oic-2016-04-06_01:32:41-rgw-hammer-backports---basic-smithi/110829/

There are runs of the rgw hammer branch on http://pulpito.ovh.sepia.cep=
h.com:8081/?branch=3Dhammer&suite=3Drgw as well but they are tainted by=
 http://tracker.ceph.com/issues/13885 which will hopefully be fixed by =
https://github.com/ceph/s3-tests/pull/104 for the next round of jewel/h=
ammer backports.

Do you think the hammer branch is ready for QE to start their own round=
 of testing ?

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
