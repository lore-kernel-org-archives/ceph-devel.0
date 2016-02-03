From: Loic Dachary <loic@dachary.org>
Subject: CephFS and the next hammer release v0.94.6
Date: Wed, 3 Feb 2016 11:52:03 +0700
Message-ID: <56B18773.6000304@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:34907 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755468AbcBCEwM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Feb 2016 23:52:12 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Nathan Cutler <ncutler@suse.cz>

Hi Greg,

The next hammer release as found at https://github.com/ceph/ceph/tree/h=
ammer passed the fs suite (http://tracker.ceph.com/issues/13356#note-25=
). A more recent run showed 3 failures and I'm not sure how to interpre=
t them ( http://pulpito.ceph.com/loic-2016-01-29_03:02:05-fs-hammer---b=
asic-multi/ ).

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
