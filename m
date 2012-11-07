From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: Re: What would a good OSD node hardware configuration look like?
Date: Wed, 7 Nov 2012 09:29:14 +0100
Message-ID: <CAJH6TXg9z0QYQSgwkh-O8QsY_oZXPy_ckR_iDnTs2vfr_xjmzA@mail.gmail.com>
References: <5097F3BD.2000904@conversis.de>
	<50985677.6090708@inktank.com>
	<50987AB9.9030905@conversis.de>
	<50996548.1030602@inktank.com>
	<5099BAEB.3060905@conversis.de>
	<509A0F35.2000801@widodh.nl>
	<CAJH6TXgRUUZ5h9gB_Zi-31aMj0r00HCjZ8jRZZCGd8_LSXaBqw@mail.gmail.com>
	<509A1A27.9090303@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:60975 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751762Ab2KGI3P (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Nov 2012 03:29:15 -0500
Received: by mail-ee0-f46.google.com with SMTP id b15so739609eek.19
        for <ceph-devel@vger.kernel.org>; Wed, 07 Nov 2012 00:29:14 -0800 (PST)
In-Reply-To: <509A1A27.9090303@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: ceph-devel@vger.kernel.org

2012/11/7 Wido den Hollander <wido@widodh.nl>:
> True. You might want to use a small internal USB stick like those from
> Transcend for installing your OS. They are available in 4GB and 8GB.
>
> Let syslog handle your logging to an external device and you have almost no
> write I/O on that thing.

Ok, but in this case instead of a RAID between 2 SSD will be better to
use one SSD for journal and one SATA disks for OS.

DELL R515 has 12 front disks and 2 internal 2.5'' disks. I'm planning
to use these internal disks as journal and OS and the external disks
as OSD.

> Still, I think that in the distributed nature it shouldn't matter if you
> loose a node. If loosing a node is a to big impact to your cluster, go with
> smaller nodes.

This is true.
