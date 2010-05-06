From: Sage Weil <sage@newdream.net>
Subject: Re: rados_aio_get_return_value returning 0 on writes
Date: Thu, 6 May 2010 14:14:45 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1005061412380.18563@cobra.newdream.net>
References: <20100506210801.GA57874@ncolin.muc.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51163 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751094Ab0EFVLy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 6 May 2010 17:11:54 -0400
In-Reply-To: <20100506210801.GA57874@ncolin.muc.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christian Brunner <chb@muc.de>
Cc: ceph-devel@vger.kernel.org

On Thu, 6 May 2010, Christian Brunner wrote:

> Almost forgot to write this: When calling rados_aio_get_return_value
> on the callback of a write it is always returning 0.
> 
> I would have expected the number of bytes written (or a value <0 on error).

The OSD always writes the number of bytes you gave it, or nothing at all.  
Since there are no "short" writes, and an osd op can be something much 
more complicated than a write (write this here + write that there + set 
this xattr + remove that xattr) there isn't necessarily a byte count, so 
it returns a simple 0 for success.

> Qemu doesn't seem to care, so this isn't really a problem for me.

You can also just return the size you sent to the OSD when you get a 0 
back.

sage
