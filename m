From: Libin Wu <hzwulibin@gmail.com>
Subject: why my cluster become unavailable
Date: Thu, 19 Nov 2015 23:26:49 +0800
Message-ID: <CAN4gH2NsnmOY8AcQaT245uwDh2fXmwnBTBKdP6_xKQ2M0PVeKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32844 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757850AbbKSP0u (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Nov 2015 10:26:50 -0500
Received: by wmuu63 with SMTP id u63so20579868wmu.0
        for <ceph-devel@vger.kernel.org>; Thu, 19 Nov 2015 07:26:49 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi, cepher

I have a cluster of 6 OSD server, every server has 8 OSDs.

I out 4 OSDs on every server, then my client io is blocking.

I reboot my client and then create a new rbd device, but the new
device also can't write io.

Yeah, i understand that some data may lost as threee replicas of some
object were lost, but why the cluster become unavailable?

There 80 incomplete pg and 4 down+incomplete pg.

Any solution i could solve the problem?

Thanks!
