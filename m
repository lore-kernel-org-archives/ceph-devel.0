From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: Correct usage of rbd_aio_release
Date: Mon, 12 Aug 2013 15:36:28 +0200
Message-ID: <CAF6-1L5nrco6oLq8xwnpymP+jLh8gi4O1WgvcOZimmCw4gFHiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:43393 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756166Ab3HLNg3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Aug 2013 09:36:29 -0400
Received: by mail-pa0-f46.google.com with SMTP id fa1so7524228pad.19
        for <ceph-devel@vger.kernel.org>; Mon, 12 Aug 2013 06:36:28 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,


When should / can rbd_aio_release be called exactly ?

For example if I create a rbd_aio_create_completion then do a
rbd_aio_XXX that fails, should I call rbd_aio_release ?
I would think yes, but when looking at the qemu rbd code, it doesn't
and I'm not sure if it's by design.

Cheers,

    Sylvain
