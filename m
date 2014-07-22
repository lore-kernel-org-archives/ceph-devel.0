From: Wido den Hollander <wido@42on.com>
Subject: Adding a delay when restarting all OSDs on a host
Date: Tue, 22 Jul 2014 15:19:12 +0200
Message-ID: <53CE64D0.5050308@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:58735 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752259AbaGVNTQ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 22 Jul 2014 09:19:16 -0400
Received: from [IPv6:2a02:f6d:8008:0:f51f:d6bc:6338:fd9c] (unknown [IPv6:2a02:f6d:8008:0:f51f:d6bc:6338:fd9c])
	by websrv.42on.com (Postfix) with ESMTPSA id CFBF3BF464
	for <ceph-devel@vger.kernel.org>; Tue, 22 Jul 2014 15:19:12 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

Currently on Ubuntu with Upstart when you invoke a restart like this:

$ sudo restart ceph-osd-all

It will restart all OSDs at once, which can increase the load on the 
system a quite a bit.

It's better to restart all OSDs by restarting them one by one:

$ sudo ceph restart ceph-osd id=X

But you then have to figure out all the IDs by doing a find in 
/var/lib/ceph/osd and that's more manual work.

I'm thinking of patching the init scripts which allows something like this:

$ sudo restart ceph-osd-all delay=180

It then waits 180 seconds between each OSD restart making the proces 
even smoother.

I know there are currently sysvinit, upstart and systemd scripts, so it 
has to be implemented on various places, but how does the general idea 
sound?

-- 
Wido den Hollander
Ceph consultant and trainer
42on B.V.

Phone: +31 (0)20 700 9902
Skype: contact42on
