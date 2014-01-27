From: Filippos Giannakos <philipgian@grnet.gr>
Subject: RADOS + deep scrubbing performance issues in production environment
Date: Mon, 27 Jan 2014 17:13:21 +0200
Message-ID: <20140127151321.GD26390@philipgian-mac>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from averel.grnet-hq.admin.grnet.gr ([195.251.29.3]:52610 "EHLO
	averel.grnet-hq.admin.grnet.gr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753728AbaA0P1i (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Mon, 27 Jan 2014 10:27:38 -0500
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: synnefo-devel@googlegroups.com

Hello all,

We have been running RADOS in a large scale, production, public cloud
environment for a few months now and we are generally happy with it.

However, we experience performance problems when deep scrubbing is active.

We managed to reproduce them in our testing cluster running emperor, even while
it was idle.

We ran a simple rados bench test:

  rados -p bench bench -b 524288 120 write

and could easily reach 230MB/Sec consistently [1].

Then, we manually initiated a deep scrub and re-ran the test.

As you can see from the results [2], the performance dropped significantly and
even paused for a few seconds.

Now imagine that behavior in a loaded cluster with thousands of VMs on top of
it. The performance drop is unacceptable for our service.

Are there any tools we are not aware of for controlling, possibly pausing,
deep-scrub and/or getting some progress about the procedure ?
Also since I believe it would be a bad practice to disable deep-scrubbing do you
have any recommendations of how to work around (or even solve) this issue ?

[1] https://pithos.okeanos.grnet.gr/public/yzq5fHNkl5OnjgLOPlRTA3
[2] https://pithos.okeanos.grnet.gr/public/OjIGAQFBGwcsBNMHtA8ir5

Kind Regards,
-- 
Filippos
<philipgian@grnet.gr>
