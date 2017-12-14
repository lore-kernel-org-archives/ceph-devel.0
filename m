From: =?UTF-8?Q?Piotr_Da=c5=82ek?= <piotr.dalek@corp.ovh.com>
Subject: Snap trim queue length issues
Date: Thu, 14 Dec 2017 15:36:35 +0100
Message-ID: <82009aab-6b20-ef21-9bbd-76fddf84e0a3@corp.ovh.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 1.mo301.mail-out.ovh.net ([137.74.110.64]:46533 "EHLO
        1.mo301.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752355AbdLNOgi (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Dec 2017 09:36:38 -0500
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@lists.ceph.com>

Hi,

We recently ran into low disk space issues on our clusters, and it wasn't 
because of actual data. On those affected clusters we're hosting VMs and 
volumes, so naturally there are snapshots involved. For some time, we 
observed increased disk space usage that we couldn't explain, as there was 
discrepancy between  what Ceph reported and actual space used on disks. We 
finally found out that snap trim queues were both long and not getting any 
shorter, and decreasing snap trim sleep and increasing max concurrent snap 
trims helped reversing the trend - we're safe now.
The problem is, we haven't been aware of this issue for some time, and 
there's no easy (and fast[1]) way to check this. I made a pull request[2] 
that makes snap trim queue lengths available to monitoring tools
and also generates health warning when things go out of control, so an admin 
can act before hell breaks loose.

My question is, how many Jewel users would be interested in a such feature? 
There's a lot of changes between Luminous and Jewel, and it's not going to 
be a straight backport, but it's not a big patch either, so I won't mind 
doing it myself. But having some support from users would be helpful in 
pushing this into next Jewel release.

Thanks!


[1] one of our guys hacked a bash oneliner that printed out snap trim queue 
lengths for all pgs, but full run takes over an hour to complete on a 
cluster with over 20k pgs...
[2] https://github.com/ceph/ceph/pull/19520

-- 
Piotr Dałek
piotr.dalek@corp.ovh.com
https://www.ovh.com/us/
