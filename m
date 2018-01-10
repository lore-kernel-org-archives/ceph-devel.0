From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Luminous - replace old target-weight tree from osdmap with mgr
 balancer
Date: Wed, 10 Jan 2018 22:22:31 +0100
Message-ID: <602f839b-6927-2c53-dbb5-baee02569105@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cloud1-vm154.de-nserver.de ([178.250.10.56]:56752 "EHLO
        cloud1-vm154.de-nserver.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751834AbeAJVWe (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 10 Jan 2018 16:22:34 -0500
Content-Language: de-DE
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

k,

in the past we used the python crush optimize tool to reweight the osd
usage - it inserted a 2nd tree with $hostname-target-weight as hostnames.

Now the quesions are:
1.) can we remove the tree? How?
2.) Can we do this now or only after all clients are running Luminous?
3.) is it enought to enable the mgr balancer module?

Thanks!

Greets,
Stefan
