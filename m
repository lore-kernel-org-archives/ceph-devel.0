From: Kyle Bader <kyle@inktank.com>
Subject: Pyramid erasure codes and replica hinted recovery
Date: Fri, 10 Jan 2014 15:40:08 -0800
Message-ID: <CAHxYaFMa_peMz8StZpJ=if0W4LmHBDO71vNnYnmgcNMab0-3aQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:46963 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758087AbaAJXkK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Jan 2014 18:40:10 -0500
Received: by mail-ob0-f172.google.com with SMTP id gq1so5551760obb.3
        for <ceph-devel@vger.kernel.org>; Fri, 10 Jan 2014 15:40:09 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I've been researching what features might be necessary in Ceph to
build multi-site RADOS clusters, whether for purposes of scale or to
meet SLA requirements more stringent than is achievable with a single
datacenter. According to [1], "typical [datacenter] availability
estimates used in the industry range from 99.7% for tier II to 99.98
and 99.995% for tiers II and IV respectively". Combine the possibility
of border and/or core networking meltdown and it's all but impossible
to achieve a Ceph service SLA that requires 3-5 nines of availability
in a single facility.

When we start looking at multi-site network configurations we need to
make sure there is sufficient cluster level bandwidth for the
following activities:

1. Write fan-out from replication on ingest
2. Backfills from OSD recovery
3. Backfills from OSD remapping

Number 1 can be estimated based on historical usage with some
additional padding for traffic spikes. Recovery backfills can be
roughly estimated based on the size of the disk population in each
facility and the OSD annualized failure rate. Number 3 makes
multi-site configurations extremely challenging unless the
organization building the cluster is willing to pay 7 zeros for 5
nines.

Consider the following:

1x 16x40GbE switch with 8x used for access ports, 8x used for
inter-site (x4 10GbE breakout per port)
32x Ceph OSD nodes with a 10GbE cluster link (working out to ~3PB raw)

Topology:

[A]-----[B]
  \       /
   \     /
    [C]

Since 40GbE is likely only an option if running over dark fiber,
non-blocking multi-site would require a total of 12 leased 10GbE
lines, 6 for 2:1, and 3 for 4:1. These lines will be extremely
stressed each and every time capacity is added to the cluster due to
the fact that pgs will be remapped and the OSD that is new to the PG
needing to be backfilled by the primary at another site (for 3x
replication). Erasure coding with regular MDS codes or even pyramid
codes will exhibit similar issues, as described in [2] and [3]. It
would be fantastic to see Ceph have a facility similar to what I
describe in this bug for replication:

http://tracker.ceph.com/issues/7114

For erasure coding, something similar to Facebook's LRC as described
in [2] would be advantageous. For example:

RS(8:4:2)

[k][k][k][k][k][k][k][k] -> [k][k][k][k][k][k][k][k][m][m][m][m]

Split over 3 sites

[k][k][k][k]      [k][k][k][k]      [k][k][k][k]

Generate 2 more parity units

[k][k][k][k][m][m]  [k][k][k][k][m][m]   [k][k][k][k][m][m]

Now if each *set* of units could be placed such that they share a
common ancestor in the CRUSH hierarchy then local unit sets from the
lower level of the pyramid could be remapped/recovered without
consuming inter-site bandwidth (maybe treat each set as a "replica"
instead of treating each individual unit as a "replica").

Thoughts?

[1] http://www.morganclaypool.com/doi/abs/10.2200/S00516ED2V01Y201306CAC024
[2] http://arxiv.org/pdf/1301.3791.pdf
[3] https://static.googleusercontent.com/media/research.google.com/en/us/pubs/archive/36737.pdf

-- 
Kyle Bader - Inktank
Senior Solution Architect
