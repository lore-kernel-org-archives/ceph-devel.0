From: Ilya Dryomov <idryomov@gmail.com>
Subject: MonClient hunt interval
Date: Mon, 25 Jan 2016 14:14:08 +0100
Message-ID: <CAOi1vP8PzDg6Hcf2Nck4_qXO1FHvJnqpE=uwF3jwp36FRLY6rQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:37930 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756089AbcAYNOJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Jan 2016 08:14:09 -0500
Received: by mail-wm0-f50.google.com with SMTP id b14so79253438wmb.1
        for <ceph-devel@vger.kernel.org>; Mon, 25 Jan 2016 05:14:08 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Greg,

With 794c86fd289b ("monc: backoff the timeout period when
reconnecting") you made it so that the backoff is applied to the hunt
interval.  When the session is established, the multiplier is reduced
by 50% and that's it - I don't see any per-tick reduction or anything
like that.

If a client had some bad luck and couldn't establish the session for
a while (so that the multiplier went all the way up to 10), its initial
timeout upon the next connection break is going to be 15 seconds no
matter how much time has passed in the interim.  Was that your intent?

Thanks,

                Ilya
