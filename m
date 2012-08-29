From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: RBD Async request: When / How are the call back called ?
Date: Wed, 29 Aug 2012 16:57:39 +0200
Message-ID: <CAF6-1L5JfGW-cw45gTbOX7+igu9WnG7=fp75aoTg1HL4AtsF-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:42323 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753636Ab2H2O5l (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Aug 2012 10:57:41 -0400
Received: by vbbff1 with SMTP id ff1so690236vbb.19
        for <ceph-devel@vger.kernel.org>; Wed, 29 Aug 2012 07:57:40 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,


It might be obvious for people knowing the API but somehow I can't
figure it out:

How and when will the call back specified in a rbd_completion_t be called ?

Imagine I do a rbd_aio_write and then do while (1); ... I don't see
how the library could call my callback unless there is threads
involved (and then my cb would be called in another thread context
which is not great ...)

(Of course the 'while (1)' here is just a stub, in reality it's a call
to a library beyond my control)


My problem here is that I need to integrate inside the main loop of
another software and I can't block, but I still need to be able to
'notify' when the requests are over. I can ask the scheduler of that
main loop to call me on some even on a file descriptor (but I don't
see any fd here), or to call me periodically (but I don't see any call
to test for completion without waiting for it).


Cheers,

     Sylvain
