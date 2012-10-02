From: Mike Ryan <mike.ryan@inktank.com>
Subject: PG recovery reservation state chart
Date: Tue, 2 Oct 2012 12:48:58 -0700
Message-ID: <20121002194858.GC8206@splice>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="iFRdW5/EC4oqxDHL"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:64531 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752155Ab2JBTtC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Oct 2012 15:49:02 -0400
Received: by pbbrr4 with SMTP id rr4so9090298pbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 02 Oct 2012 12:49:01 -0700 (PDT)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


--iFRdW5/EC4oqxDHL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Tried sending this earlier but it seems the list doesn't like PNGs.
dotty or dot -Tpng will make short work of the .dot file I've attached.


These are the changes to the Active state of the PG state chart in order
to support recovery reservations. This is Important Stuff, so please
criticize mercilessly.

Here's a prose version:

When the PG activates, it determines whether it needs to do recovery. If
it does, it grabs its local reservation, then grabs a remote reservation
from each replica in order of OSD ID (to prevent deadlock). Once all
remotes are reserved, it starts recovering.

After recovery, all remote reservations are dropped. If no backfill is
necessary, the local reservation is dropped and we jump to Clean.

If we need to backfill, we request a remote backfill reservation from
the replica. If this reservation is rejected (due to the OSD being too
full) we drop our local reservation and wait for a while in
NotBackfilling. We then grab our local reservation and try again on the
remote reservation. Once we have the remote reservation, we backfill.
After Backfilling we drop the local and remote backfill reservation and
jump to Clean.

--iFRdW5/EC4oqxDHL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="pg_recovery_reservation.dot"

digraph G {
    Activating -> Clean [label="AllReplicasClean"];
    Activating -> LocalReserving [label="DoRecovery"];
    LocalReserving -> WaitRemoteRecoveryReserved [label="LocalRecoveryReserved"];
    WaitRemoteRecoveryReserved -> WaitRemoteRecoveryReserved [label="RemoteReserved"];
    WaitRemoteRecoveryReserved -> Recovering [label="AllRemotesReserved"];
    Recovering -> Clean [label="AllReplicasClean"];
    Recovering -> WaitRemoteBackfillReserved [label="RequestBackfill"];
    WaitRemoteBackfillReserved -> NotBackfilling [label="RemoteReservationRejected"];
    NotBackfilling -> WaitLocalBackfillReservation [label="RequestBackfill"];
    WaitLocalBackfillReservation -> WaitRemoteBackfillReserved [label="LocalBackfillReserved"];
    WaitRemoteBackfillReserved -> Backfilling [label="RemoteBackfillReserved"];
    Backfilling -> Clean [label="Backfilled"];
}

--iFRdW5/EC4oqxDHL--
