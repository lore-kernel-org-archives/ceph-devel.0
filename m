From: Oliver Francke <Oliver.Francke@filoo.de>
Subject: RBD/qemu-1.7.0 memory leak with drive_mirror/live-migration
Date: Tue, 17 Dec 2013 13:45:22 +0100
Message-ID: <52B04762.50306@filoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-2.de-punkt.de ([93.190.64.238]:59466 "EHLO
	mail-2.de-punkt.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753476Ab3LQMvA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 17 Dec 2013 07:51:00 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail-2.de-punkt.de (Postfix) with ESMTP id 505883A310
	for <ceph-devel@vger.kernel.org>; Tue, 17 Dec 2013 13:45:23 +0100 (CET)
Received: from mail-2.de-punkt.de ([127.0.0.1])
	by localhost (mail-2.de-punkt.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QP8qoV0L-9iY for <ceph-devel@vger.kernel.org>;
	Tue, 17 Dec 2013 13:45:23 +0100 (CET)
Received: from [192.168.1.152] (p4FECECDE.dip0.t-ipconnect.de [79.236.236.222])
	(Authenticated sender: oliver.francke@filoo.de)
	by mail-2.de-punkt.de (Postfix) with ESMTPSA id 102F33A35D
	for <ceph-devel@vger.kernel.org>; Tue, 17 Dec 2013 13:45:23 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi *,

I just tried a feature for live-migration via:

drive_mirror -f virtio0 rbd:123123/virtio0 rbd

in a qemu-monitoring-session.
One immediately can see some memory consumption... never getting=20
released again. Additionally the block-job never ends, even after X/X=20
bytes completed.
You can cancel the job, memory still occupied, after another try more=20
RSS-memory gets filled.

Same procedure with qcow2 does not need any more memory, and the job=20
gets cleared after completion.

Possibly @Josh: any idea? Logfiles with debug_what=3D? needed? ;)

Thnx in @vance,

Oliver.

--=20

Oliver Francke

filoo GmbH
Moltkestra=DFe 25a
33330 G=FCtersloh
HRB4355 AG G=FCtersloh

Gesch=E4ftsf=FChrer: J.Rehp=F6hler | C.Kunz

=46olgen Sie uns auf Twitter: http://twitter.com/filoogmbh

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
