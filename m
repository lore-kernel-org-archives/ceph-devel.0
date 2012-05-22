From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: how to debug slow rbd block device
Date: Tue, 22 May 2012 14:45:15 +0200
Message-ID: <4FBB8A5B.9010500@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:53966 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756808Ab2EVMpL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 May 2012 08:45:11 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi list,

my ceph block testcluster is now running fine.

Setup:
4x ceph servers
  - 3x mon with /mon on local os SATA disk
  - 4x OSD with /journal on tmpfs and /srv on intel ssd

all of them use 2x 1Gbit/s lacp trunk.

1x KVM Host system (2x 1Gbit/s lacp trunk)

With one KVM i do not get more than 40MB/s and my network link is just
at 40% of 1Gbit/s.

Is this expected? If not where can i start searching / debugging?

Thanks,
Stefan
