From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: KVM / Qemu  Images doesn't work with ceph-fs
Date: Thu, 5 May 2011 10:27:57 -0700
Message-ID: <20110505172757.GB13840@dreamer>
References: <4DC271B7.10406@science-computing.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:54338 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755412Ab1EER14 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 May 2011 13:27:56 -0400
Content-Disposition: inline
In-Reply-To: <4DC271B7.10406@science-computing.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christoph Raible <c.raible@science-computing.de>
Cc: ceph-devel@vger.kernel.org

On Thu, May 05, 2011 at 11:45:27AM +0200, Christoph Raible wrote:
> in an other mail (http://marc.info/?t=130442346600006&r=1&w=2)
> I explained my Config. And after two changes in the config file
> the ceph-fs works fine :)

Are you running an osd on the same machine that has the /ceph mount?
There's known memory management problems with loopback network
filesystems; even NFS is known to trigger that. Using the kernel ceph
client to mount a ceph filesystem hosted on the same machine is not
safe.

A simple dd might not trigger the problems, because the kernel will
recognize the streaming write pattern and discard the pages early from
the buffer cache, but a full VM install isn't a clean streaming write.

-- 
:(){ :|:&};:
