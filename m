From: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/4] More RBD updates
Date: Mon, 19 Sep 2011 16:09:17 +0200
Message-ID: <4E774D0D.2010406@redhat.com>
References: <1316121071-7690-1-git-send-email-sage@newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:17273 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751328Ab1ISOGV (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 19 Sep 2011 10:06:21 -0400
In-Reply-To: <1316121071-7690-1-git-send-email-sage@newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: qemu-devel@nongnu.org, ceph-devel@vger.kernel.org

Am 15.09.2011 23:11, schrieb Sage Weil:
> Hi,
> 
> Here are a few more improvements to the qemu rbd support.  The first 
> patch makes the configuration file handling cleaner (do not error out if 
> /etc/ceph/ceph.conf doesn't exist).  One allows characters in the conf 
> string to be escaped, so you can (for example) specify an ip\:port (':' 
> is used as a delimiter).
> 
> The last patch implements flush when rbd_flush() is available.  This lets 
> us take advantage of write buffering in newer versions of librbd, which 
> improves performance significantly for many workloads (including the 
> trivial qemu-img convert).
> 
> Thanks!
> sage
> 
> 
> Sage Weil (4):
>   rbd: ignore failures when reading from default conf location
>   rbd: allow escaping in config string
>   rbd: update comment heading
>   rbd: call flush, if available
> 
>  block/rbd.c |   83 +++++++++++++++++++++++++++++++++++++++-------------------
>  1 files changed, 56 insertions(+), 27 deletions(-)
> 

Thanks, applied patches 1/3/4, commented on patch 2.

Kevin
