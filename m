From: Martin Wilderoth <martin.wilderoth@linserv.se>
Subject: HEALTH_WARNING
Date: Sat, 2 Apr 2011 05:59:39 +0200 (CEST)
Message-ID: <2118397089.13429.1301716779192.JavaMail.root@mail.linserv.se>
References: <835540127.13427.1301716690785.JavaMail.root@mail.linserv.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 194-17-14-101.customer.telia.com ([194.17.14.101]:35729 "EHLO
	mail.linserv.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709Ab1DBEGa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 2 Apr 2011 00:06:30 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.linserv.se (Postfix) with ESMTP id B49DA1204E1
	for <ceph-devel@vger.kernel.org>; Sat,  2 Apr 2011 05:59:43 +0200 (CEST)
Received: from mail.linserv.se ([127.0.0.1])
	by localhost (mail.linserv.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IZwBZ4Zw-ft6 for <ceph-devel@vger.kernel.org>;
	Sat,  2 Apr 2011 05:59:39 +0200 (CEST)
Received: from mail.linserv.se (mail.linserv.se [194.17.14.101])
	by mail.linserv.se (Postfix) with ESMTP id 5947B12002A
	for <ceph-devel@vger.kernel.org>; Sat,  2 Apr 2011 05:59:39 +0200 (CEST)
In-Reply-To: <835540127.13427.1301716690785.JavaMail.root@mail.linserv.se>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,

One of my hosts run out of diskspace on the root file system (logfiles)
So I restared ceph. Discoverd the low diskspace during the restart. osd2 and osd3

ceph health gives a message like this

HEALTH_WARN osdmonitor: num_osds = 6, num_up_osds = 4, num_in_osds = 4 Some PGs are: degraded,peering

now osd.1 is dead all the other are running

How do I get the running one up and in ? and how do I know which ods it is ?

how do I recover the dead one ?

 Regards Martin
