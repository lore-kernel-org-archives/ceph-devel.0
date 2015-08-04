From: Wido den Hollander <wido@42on.com>
Subject: Re: C++11 and librados C++
Date: Tue, 04 Aug 2015 12:46:42 +0200
Message-ID: <55C09812.8000704@42on.com>
References: <CAN=+7FX9Va+rxRr87E6bn6djjHSvXtVZTd+f576g=n01TJ5cRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:41186 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932150AbbHDKqo (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 4 Aug 2015 06:46:44 -0400
In-Reply-To: <CAN=+7FX9Va+rxRr87E6bn6djjHSvXtVZTd+f576g=n01TJ5cRA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sjust@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>
Cc: "Weil, Sage" <sweil@redhat.com>, "Durgin, Josh" <jdurgin@redhat.com>, Casey Bodley <cbodley@redhat.com>



On 03-08-15 22:25, Samuel Just wrote:
> It seems like it's about time for us to make the jump to C++11.  This
> is probably going to have an impact on users of the librados C++
> bindings.  It seems like such users would have to recompile code using
> the librados C++ libraries after upgrading the librados library
> version.  Is that reasonable?  What do people expect here?

Well, some people use Qemu build by their distro, but they use librados
/ librbd from ceph.com

So if they suddenly have to rebuild Qemu that would hurt them I think.

Wido

> -Sam
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
