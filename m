From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH 2/8] ceph: update MAINTAINERS file
Date: Mon, 30 Jul 2012 18:09:56 -0500
Message-ID: <50171444.2070502@inktank.com>
References: <1343663971-3221-1-git-send-email-sage@inktank.com> <1343663971-3221-3-git-send-email-sage@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:52972 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754929Ab2G3XJ4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Jul 2012 19:09:56 -0400
Received: by gglu4 with SMTP id u4so5465117ggl.19
        for <ceph-devel@vger.kernel.org>; Mon, 30 Jul 2012 16:09:56 -0700 (PDT)
In-Reply-To: <1343663971-3221-3-git-send-email-sage@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 07/30/2012 10:59 AM, Sage Weil wrote:
>  * shiny new inktank.com email addresses
>  * add include/linux/crush directory (previous oversight)
> 
> Signed-off-by: Sage Weil <sage@inktank.com>

If you implement my suggestions below, then:

Reviewed-by: Alex Elder <elder@inktank.com>

> ---
>  MAINTAINERS |    9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fe643e7..b8af81a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1761,15 +1761,16 @@ F:	arch/powerpc/oprofile/*cell*
>  F:	arch/powerpc/platforms/cell/
>  
>  CEPH DISTRIBUTED FILE SYSTEM CLIENT
> -M:	Sage Weil <sage@newdream.net>
> +M:	Sage Weil <sage@inktank.com>
>  L:	ceph-devel@vger.kernel.org
> -W:	http://ceph.newdream.net/
> +W:	http://ceph.ceph/

        http://ceph.com/   ?


>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git
>  S:	Supported
>  F:	Documentation/filesystems/ceph.txt
>  F:	fs/ceph
>  F:	net/ceph
>  F:	include/linux/ceph
> +F:	include/linux/crush
>  
>  CERTIFIED WIRELESS USB (WUSB) SUBSYSTEM:
>  L:	linux-usb@vger.kernel.org
> @@ -5596,8 +5597,8 @@ F:	arch/hexagon/
>  
>  RADOS BLOCK DEVICE (RBD)
>  F:	include/linux/qnxtypes.h

Delete this ^^^.

> -M:	Yehuda Sadeh <yehuda@hq.newdream.net>
> -M:	Sage Weil <sage@newdream.net>
> +M:	Yehuda Sadeh <yehuda@inktank.com>
> +M:	Sage Weil <sage@inktank.com>
>  M:	ceph-devel@vger.kernel.org

Add this:
T:	git git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git

>  S:	Supported
>  F:	drivers/block/rbd.c

Add this:
F:     drivers/block/rbd_types.h

> 

