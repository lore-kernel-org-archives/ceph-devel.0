From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: pg stuck in peering
Date: Thu, 21 Feb 2013 11:09:45 +0100
Message-ID: <CAJH6TXiVQ8cqyL5Z-XKz8PqjyuVyg=wM67eg5830sMSp546ReA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:63333 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751575Ab3BUKJq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Feb 2013 05:09:46 -0500
Received: by mail-wi0-f176.google.com with SMTP id hm14so7273051wib.9
        for <ceph-devel@vger.kernel.org>; Thu, 21 Feb 2013 02:09:45 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi
I have some trouble on a test cluster.
Many PGs are stuck in "peering" state from yesterday:

pg 1.2 is peering, acting [3,4]
pg 0.3 is peering, acting [3,4]
pg 2.1 is peering, acting [3,4]
pg 3.0 is peering, acting [3,4]
pg 1.3 is peering, acting [1,4]
pg 0.2 is peering, acting [3,4]
pg 2.0 is peering, acting [3,4]
pg 3.1 is peering, acting [1,4]
pg 4.6 is down+peering, acting [4,0]
pg 5.7 is peering, acting [3,1]
pg 6.4 is down+peering, acting [4,0]
pg 7.5 is peering, acting [3,1]
pg 0.1 is active+degraded, acting [4,0]
pg 2.3 is peering, acting [3,4]
pg 3.2 is peering, acting [3,4]
pg 4.5 is down+peering, acting [2,4]
pg 5.4 is down+peering, acting [2,4]
pg 6.7 is peering, acting [0,4]
pg 7.6 is peering, acting [0,4]
pg 1.1 is peering, acting [3,4]
pg 0.0 is active+degraded, acting [4,0]
pg 2.2 is peering, acting [1,4]
pg 3.3 is peering, acting [2,4]
pg 4.4 is peering, acting [1,4]
pg 5.5 is down+peering, acting [4,0]
pg 6.6 is peering, acting [3,1]
pg 7.7 is down+peering, acting [2,4]

HEALTH_WARN 332 pgs degraded; 316 pgs down; 316 pgs peering; 93 pgs
stale; 316 pgs stuck inactive; 93 pgs stuck stale; 764 pgs stuck
unclean



any advice ? I think that a not healthy cluster prevent me to run RGW
due to some timeout.
