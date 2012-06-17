From: Martin Mailand <martin@tuxadero.com>
Subject: Re: Unmountable btrfs filesystems
Date: Sun, 17 Jun 2012 15:55:42 +0200
Message-ID: <4FDDE1DE.5030709@tuxadero.com>
References: <4FDCD484.50706@widodh.nl>
Reply-To: martin@tuxadero.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from einhorn.in-berlin.de ([192.109.42.8]:60145 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757275Ab2FQNzo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 17 Jun 2012 09:55:44 -0400
In-Reply-To: <4FDCD484.50706@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Wido,
until recently there were still a few bugs in btrfs which could be hit 
quite easily with ceph. The last big one was fixed here 
http://www.spinics.net/lists/ceph-devel/msg06270.html

I am running a ceph cluster with btrfs on a 3.5-rc2 without a problem, 
even under heavy test load.

Hope that's helped.

-martin


Am 16.06.2012 20:46, schrieb Wido den Hollander:
> I tried various kernels, the most recent 3.3.0 from kernel.ubuntu.com,
> but I'm still seeing this.
>
> Is anyone seeing the same or did everybody migrate away to ext4 or XFS?
>
> I still prefer btrfs due to the snapshotting, but loosing all these
> OSD's all the time is getting kind of frustrating.
>
> Any thoughts or comments?
