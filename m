From: Mike Ryan <mike.ryan@inktank.com>
Subject: Re: RBD Async request: When / How are the call back called ?
Date: Wed, 29 Aug 2012 09:47:49 -0700
Message-ID: <20120829164748.GA2142@splice>
References: <CAF6-1L5JfGW-cw45gTbOX7+igu9WnG7=fp75aoTg1HL4AtsF-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:32995 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149Ab2H2Qrz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Aug 2012 12:47:55 -0400
Received: by dady13 with SMTP id y13so543802dad.19
        for <ceph-devel@vger.kernel.org>; Wed, 29 Aug 2012 09:47:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAF6-1L5JfGW-cw45gTbOX7+igu9WnG7=fp75aoTg1HL4AtsF-Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sylvain Munaut <s.munaut@whatever-company.com>
Cc: ceph-devel@vger.kernel.org

On Wed, Aug 29, 2012 at 04:57:39PM +0200, Sylvain Munaut wrote:
> How and when will the call back specified in a rbd_completion_t be called ?
> 
> Imagine I do a rbd_aio_write and then do while (1); ... I don't see
> how the library could call my callback unless there is threads
> involved (and then my cb would be called in another thread context
> which is not great ...)

I believe it's called from another thread.

> My problem here is that I need to integrate inside the main loop of
> another software and I can't block, but I still need to be able to
> 'notify' when the requests are over. I can ask the scheduler of that
> main loop to call me on some even on a file descriptor (but I don't
> see any fd here), or to call me periodically (but I don't see any call
> to test for completion without waiting for it).

from include/rados/librados.hpp:

  struct AioCompletion {
    ...
    bool is_complete();
    ...
  };

Is that sufficient?
