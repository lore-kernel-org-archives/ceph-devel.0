From: Rutger ter Borg <rutger@terborg.net>
Subject: Re: Rados and user-provided buffers
Date: Thu, 19 Sep 2013 14:39:14 +0200
Message-ID: <l1er9a$vsu$1@ger.gmane.org>
References: <l1d0jr$jqa$1@ger.gmane.org> <alpine.DEB.2.00.1309181259060.30792@cobra.newdream.net> <l1d2ib$hnd$1@ger.gmane.org> <alpine.DEB.2.00.1309181347570.30792@cobra.newdream.net> <l1eg4e$uom$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:47990 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753205Ab3ISMj3 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 19 Sep 2013 08:39:29 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1VMdW3-00081H-8N
	for ceph-devel@vger.kernel.org; Thu, 19 Sep 2013 14:39:27 +0200
Received: from gl-95017.prolocation.net ([62.204.95.17])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 19 Sep 2013 14:39:27 +0200
Received: from rutger by gl-95017.prolocation.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 19 Sep 2013 14:39:27 +0200
In-Reply-To: <l1eg4e$uom$1@ger.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On 2013-09-19 11:28, Rutger ter Borg wrote:
>
>
> Hey Sage,
>
> thanks for the hints. You're citing the synchronous version of
> rados_read, not rados_aio_read. The difference between rados_read and
> rados_aio_read (the C-versions) is that rados_read uses a bufferlist,
> and rados_aio_read uses an overload with a char* buf. Both are delegated
> to IoCtxImpl. IoCtxImpl has two overloads for aio_read, one accepting a
> bufferlist and a char*, but only one overload for read, accepting a
> bufferlist only.
>
> IoCtxImpl's overloads for aio_read are almost identical, the difference
> is that the buflist overload sets a bufferlist on AioCompletionImpl* c,
>
> c->pbl = pbl;
>
> and the char* buffer-overload sets a buffer
>
> c->buf = buf;
>
> AioCompletionImpl contains multiple data members: a bufferlist (bl), a
> pointer to a bufferlist (pbl), and a pointer to a character array buf.
> The following calls (in IoCtxImpl's aio_read overloads) to the objecter
> are identical:
>
> objecter->read(oid, oloc,
>           off, len, snapid, &c->bl, 0,
>           onack, &c->objver);
>
> Looking at the Objecter read and deeper in the call chain, it seems that
> information about data member pbl in AioCompletionImpl* is lost. The
> objecter only knows about a Context, not about AioCompletionImpl. The
> user-provided buffer is not passed on.
>
> My preliminary conclusion is that my problem is caused by information
> lost in IoCtxImpl's aio_read overloads. Maybe it can be solved by
> modifying IoCtxImpl.cc:
>
>   * removing line 615. Not sure why the AioCompletionImpl needs to know
> anything about buffers?
>   * replacing '&c->bl' with 'pbl' on line 619 of IoCtxImpl.cc, making
> the call to the objecter
>
> objecter->read(oid, oloc,
>           off, len, snapid, pbl, 0,
>           onack, &c->objver);
>
> In that way, the bufferlist is passed through, and not thrown away.
>
> Thanks,
>
> Rutger
>

FWIW, it works for me.

Cheers,

Rutger





