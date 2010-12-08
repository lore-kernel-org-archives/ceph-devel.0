From: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH] ceph/rbd block driver for qemu-kvm (v9)
Date: Wed, 08 Dec 2010 11:36:35 +0100
Message-ID: <4CFF5FB3.1070704@redhat.com>
References: <20101206195301.GA26029@sir.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:19472 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751232Ab0LHKfc (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 8 Dec 2010 05:35:32 -0500
In-Reply-To: <20101206195301.GA26029@sir.home>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christian Brunner <chb@muc.de>
Cc: qemu-devel@nongnu.org, ceph-devel@vger.kernel.org, kvm@vger.kernel.org, Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>

Am 06.12.2010 20:53, schrieb Christian Brunner:
> This is a new version of the rbd driver. The only difference from v8 is
> a check for a recent librados version in configure. If the librados version
> is too old, rbd support will be disabled.
> 
> RBD is an block driver for the distributed file system Ceph 
> (http://ceph.newdream.net/). This driver uses librados (which is part 
> of the Ceph server) for direct access to the Ceph object store and is 
> running entirely in userspace (Yehuda also wrote a driver for the 
> linux kernel, that can be used to access rbd volumes as a block 
> device).
> 
> Regards,
> Christian
> 
> Signed-off-by: Yehuda Sadeh <yehuda@hq.newdream.net>
> Signed-off-by: Christian Brunner <chb@muc.de>

Thanks. I still haven't managed to actually test it, but I've applied
this to the block branch now based on your testing and Stefan's review
(and the fact that it doesn't break my build any more).

Kevin
