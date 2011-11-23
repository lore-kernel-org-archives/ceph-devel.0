From: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
Subject: Re: Recommended btrfs mount options
Date: Wed, 23 Nov 2011 09:38:18 -0200
Message-ID: <or39dful05.fsf@livre.localdomain>
References: <CAO47_-_V4d=3abABvqrV+muJ3cF-J-=-RQ748Vr+U=_ZdffZfw@mail.gmail.com>
	<Pine.LNX.4.64.1111221415280.11288@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lsd-gw.ic.unicamp.br ([143.106.7.165]:33663 "EHLO
	boneca.lsd.ic.unicamp.br" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751985Ab1KWLiu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Wed, 23 Nov 2011 06:38:50 -0500
In-Reply-To: <Pine.LNX.4.64.1111221415280.11288@cobra.newdream.net> (Sage
	Weil's message of "Tue, 22 Nov 2011 14:18:42 -0800 (PST)")
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Christian Brunner <chb@muc.de>, ceph-devel@vger.kernel.org

On Nov 22, 2011, Sage Weil <sage@newdream.net> wrote:

> On Tue, 22 Nov 2011, Christian Brunner wrote:

>> - compression: I'm using lzo compression right now, as my CPUs in the
>> OSD nodes where idle most of the time and it is improving throughput
>> quite a bit.

> The caveat here is that there is a corner case with inline extents and the 
> clone ioctl that isn't implemented.

What happens when you trigger that case?  Crash or corruption?

I ask because I've been running with zlib compression, and I haven't
noticed any problems along these lines, though I haven't got to a point
in which I'm doing more than rsyncing whole trees into the filesystem
yet.

>> - nocluster (requires an additional btrfs patch from Alexandre): I was
>> reading that he was able to reduce the excessive metadata overhead,
>> but it is slower. Does anyone know more about it?

> We haven't tried this.

I've used it occasionally and temporarily, to rebalance metadata and
bring btrfs (even with clustered allocation) back to a faster pace
without umount.

-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist      Red Hat Brazil Compiler Engineer
