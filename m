From: Constantinos Venetsanopoulos <cven@grnet.gr>
Subject: rbd tool changed format? (breaks compatibility)
Date: Fri, 16 Nov 2012 16:36:26 +0200
Message-ID: <50A64F6A.8010505@grnet.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from averel.grnet-hq.admin.grnet.gr ([195.251.29.3]:15445 "EHLO
	averel.grnet-hq.admin.grnet.gr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751666Ab2KPOvk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Fri, 16 Nov 2012 09:51:40 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: synnefo-devel@googlegroups.com

Hello ceph team,

As you may already know, our team in GRNET is building a complete open
source cloud platform called Synnefo [1], which already powers our
production public cloud service ~okeanos [2].

Synnefo is using Google Ganeti for the low level VM management part [3].
As of Jan 2012, we have merged to upstream Ganeti support for VM disks
on RADOS [4].

Today we received some feedback, that other people trying to run Ganeti
with RADOS get an error because probably the output of the 'rbd
showmapped' command has changed.

I'd like to ask if indeed the output format of the rbd tool has changed.
More specifically:

1. Does the 'rbd showmapped' command still returns just the headers if
no device is mapped?
2. Has the separator between the 'rbd showmapped' columns changed
from \t to ""?

I don't have the latest rbd tool setup (but rather
ceph-common=0.48.1argonaut-1~bpo60+1), so I can't test it right now,
but I see this commit:

https://github.com/ceph/ceph/commit/bed55369a96c2651f513b8c9b1a7bb92fb87550a

How stable can we consider rbd tool's output format?
This is something we want to run in production environment. Using the
tool rather than the library makes things much simpler.


Kind Regards,
Constantinos Venetsanopoulos

[1] http://synnefo.org
[2] http://okeanos.io
[3] http://code.google.com/p/ganeti/
[4] 
http://git.ganeti.org/?p=ganeti.git;a=commit;h=7181fba0662246b5f02764a5b3b0d500f6934dd0
