From: Ravi Pinjala <pstatic@gmail.com>
Subject: cluster upgrade question
Date: Wed, 12 Jan 2011 22:15:26 -0800
Message-ID: <AANLkTinS2=iMMJ+JNxdD-oeRUE5OCuLwvgFNr1R7+Lfn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:33492 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750912Ab1AMGP2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Jan 2011 01:15:28 -0500
Received: by bwz15 with SMTP id 15so1239102bwz.19
        for <ceph-devel@vger.kernel.org>; Wed, 12 Jan 2011 22:15:27 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Quick question about cluster upgrades. Are the Ceph protocols nailed
down enough that it's safe to upgrade a cluster incrementally and mix
versions of the software, or do I have to take the cluster offline and
upgrade everything at once?

--Ravi
