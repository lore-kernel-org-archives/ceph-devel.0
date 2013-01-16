From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: Re: flashcache
Date: Wed, 16 Jan 2013 23:04:01 +0100
Message-ID: <CAJH6TXgvk43Kowt1_e0KBD4TO--Z04vEpvA_qtR-49fiLq=u0w@mail.gmail.com>
References: <CAJH6TXiJjEq4C7k5p39Eo+pgwoq372r29RJriBee+irJPLvLpw@mail.gmail.com>
	<alpine.DEB.2.00.1301161325280.27925@cobra.newdream.net>
	<50F72150.7080002@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:53782 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756136Ab3APWEC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Jan 2013 17:04:02 -0500
Received: by mail-wg0-f44.google.com with SMTP id dr12so1212275wgb.35
        for <ceph-devel@vger.kernel.org>; Wed, 16 Jan 2013 14:04:01 -0800 (PST)
In-Reply-To: <50F72150.7080002@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org

2013/1/16 Mark Nelson <mark.nelson@inktank.com>:
> Looks like a fun configuration to test!  Having said that, I have no idea
> how stable flashcache is.  It's certainly not something we've used in
> production before!  Keep that in mind.

As wrote before, this should not be an issue, ceph should handle failures.
But is ceph able to detect a badly-wrote blocks?

> With only 2 SSDs for 12 spinning disks, you'll need to make sure the SSDs
> are really fast.  I use Intel 520s for testing which are great, but I
> wouldn't use them in  production.  The S3700 might be a good bet at larger
> sizes, but it looks like the 100GB version is a lot slower than the 200GB
> version, and that's still a bit slower than the 400GB version.  Assuming you
> have 10GbE, you'll probably be capped by the SSDs for large block sequential
> workloads.  Having said that, I still think this has potential to be a nice
> setup.  Just be aware that we usually don't stick that much stuff on the
> SSDs!

12 spinning disks will be the worse scenario.
When in production i'll start with 5 server, with 6 disks each (3+3
for each SSD)
Then i'll try to add hosts instead of adding disks.
I don't have 10GbE actually but only 2GbE bonded. I can evaluate 4GbE.

> It'd be amazing if supermicro could cram another 2 SSD slots in the back.
> Maybe by that time we'll all be using PCIE flash storage though. :)

How much a PCIE storage?
