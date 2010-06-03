From: Sage Weil <sage@newdream.net>
Subject: Re: Snapshot in subdirectory lost when removing parent directory
Date: Thu, 3 Jun 2010 07:32:18 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1006030731160.18396@cobra.newdream.net>
References: <1275558004.14588.106.camel@wido-laptop.pcextreme.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:39868 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754061Ab0FCOcB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Jun 2010 10:32:01 -0400
In-Reply-To: <1275558004.14588.106.camel@wido-laptop.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@pcextreme.nl>
Cc: ceph-devel@vger.kernel.org

On Thu, 3 Jun 2010, Wido den Hollander wrote:
> Hi,
> 
> When creating a snapshot in a subdirectory, this gets lost when the
> parent directory is removed, see the following command sequence:
> http://www.pastebin.org/302447
> 
> Now, i had a snapshot of the directory "beta" holding my really
> important file "randomfile.txt".
> 
> Since creating a snapshot of the root directory is not possible i could
> loose all my data when someone hacks a box and does a "rm -rf /".
> 
> What would you advice in this scenario?
> 
> 1. Create snapshots of the RADOS pools?
> 2. Never mount the root directory, but a subdir (mount x.x.x.x:/subdir)
> 3. Prevent your box from being hacked ;-)

Hmm.  What about returning ENOTEMPTY when you try to rmdir(2) a directory 
that contains snapshots?

sage
