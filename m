From: Loic Dachary <loic@dachary.org>
Subject: rbd and the next hammer release v0.94.7
Date: Mon, 11 Apr 2016 13:35:16 +0200
Message-ID: <570B8BF4.8080900@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:48277 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754377AbcDKLfv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Apr 2016 07:35:51 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <jdurgin@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Nathan Cutler <ncutler@suse.cz>, Jason Dillaman <dillaman@redhat.com>

Hi Josh,

The next hammer release as found at https://github.com/ceph/ceph/tree/h=
ammer passed the rbd suite (http://tracker.ceph.com/issues/14692#note-4=
9 and http://pulpito.ceph.com/teuthology-2015-10-12_17:29:20-rbd-hammer=
-distro-basic-multi/ which has 3 failures). Do you think the hammer bra=
nch is ready for QE to start their own round of testing ?

Cheers

P.S. Jason, please let us know when the time comes to ask you for this =
kind of executive decision ;-)

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
