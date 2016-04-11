From: Loic Dachary <loic@dachary.org>
Subject: rados and the next hammer release v0.94.7
Date: Mon, 11 Apr 2016 13:25:23 +0200
Message-ID: <570B89A3.3030006@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:56761 "EHLO
	relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754156AbcDKLZm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Apr 2016 07:25:42 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sjust@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Nathan Cutler <ncutler@suse.cz>

Hi Sam,

The next hammer release as found at https://github.com/ceph/ceph/tree/h=
ammer passed the rados suite (http://tracker.ceph.com/issues/14692#note=
-51 and failed one test because of OpenStack specific issues but the te=
st passed in another suite with the same branch http://tracker.ceph.com=
/issues/14692#note-45) and the upgrade suite (http://tracker.ceph.com/i=
ssues/14692#note-52). Do you think the hammer branch is ready for QE to=
 start their own round of testing ?

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
