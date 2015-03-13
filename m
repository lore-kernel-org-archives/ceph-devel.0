From: "Charles 'Boyo" <charlesboyo@gmail.com>
Subject: Localized reads (RADOS/RBD)
Date: Fri, 13 Mar 2015 22:38:48 +0000
Message-ID: <531034849-1426286330-cardhu_decombobulator_blackberry.rim.net-1702012346-@b15.c5.bise7.blackberry>
Reply-To: charlesboyo@gmail.com
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f172.google.com ([74.125.82.172]:36505 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751869AbbCMWix (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 13 Mar 2015 18:38:53 -0400
Received: by wetk59 with SMTP id k59so547025wet.3
        for <ceph-devel@vger.kernel.org>; Fri, 13 Mar 2015 15:38:52 -0700 (PDT)
Received: from 172.18.198.183 (bda-178-239-84-151.bis7.eu.blackberry.com. [178.239.84.151])
        by mx.google.com with ESMTPSA id bx3sm4613087wjc.21.2015.03.13.15.38.52
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 13 Mar 2015 15:38:52 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello all.

When, if ever, will Ceph clients have the ability to prefer certain OSDs/hosts over others?

I am running 3 replica pools across 3 data centers connected by relatively narrow links. Writes have to travel out anyway but I'd prefer to keep reads local.

The thinking is that since all writes are synchronous across all replicas, it should be okay to read from a secondary that is nearer, faster or lightly loaded instead of reaching out to the primary at all times.

Can this be done with a CRUSH tweak?
Any ideas?

Charles

