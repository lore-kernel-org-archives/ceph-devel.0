From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: Mons network
Date: Wed, 7 Nov 2012 13:31:43 +0100
Message-ID: <CAJH6TXiqRbuX=8gKL9hkVd=9X3vZew5jFHwM8xe=wjpu7_+5-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:57610 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750942Ab2KGMbo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Nov 2012 07:31:44 -0500
Received: by mail-ee0-f46.google.com with SMTP id b15so862455eek.19
        for <ceph-devel@vger.kernel.org>; Wed, 07 Nov 2012 04:31:43 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Which kind of network should I plain for 3 or 4 MONs nodes?
Are these node called by the ceph client (RBD, RGW, and so on) or only by OSD?

Can I use some virtual machines distributed across multiple Xen nodes
on a 100mbit/s netoworks reachable by the whole storage cluster
(client, server, ods, rbd, rgw) on should I put a gigabit network
reachable only by OSD (for performance and security purposes)
