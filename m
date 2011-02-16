From: Upendra Moturi <upendra.m@hexagrid.com>
Subject: problem with ceph init scripts
Date: Wed, 16 Feb 2011 20:14:27 +0530
Message-ID: <AANLkTi=kvS=Oxou=1ZKeN+NW-0jMcYOtTQS-rzTZf2-9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:48143 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751032Ab1BPOo2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Feb 2011 09:44:28 -0500
Received: by wyb28 with SMTP id 28so1402653wyb.19
        for <ceph-devel@vger.kernel.org>; Wed, 16 Feb 2011 06:44:27 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sage@newdream.net, ceph-devel@vger.kernel.org, Suresh Mandava <suresh@hexagrid.com>

Hi,

With ceph 0.24.2 and linux 2.6.38-2-generic(ubuntu) ,i face problems
with ceph init scripts

/etc/init.d/ceph -a start   ----works fine
But if we want to start a particular osd or mon or mds ,its not
working and there is no error
eg:/etc/init.d/ceph start osd1  does not start osd1 and don't get any error

/etc/init.d/ceph -a stop also does not stop ceph on all nodes.It stops
on current node only
where as
/etc/init.d/ceph -a killall works fine.


--
Thanks and Regards,
Upendra.M
