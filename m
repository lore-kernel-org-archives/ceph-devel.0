From: Marco Aroldi <marco.aroldi@gmail.com>
Subject: Re: Failed HD, automate procedure?
Date: Mon, 2 Apr 2012 22:33:17 +0200
Message-ID: <CAHzdKULs2P1Rfju+ESYFv3_jB=ob9_gBZxueDjRTgiBV6NrHAg@mail.gmail.com>
References: <CAHzdKU+85+aKqr2aQqCcrnzjo4kou3FVQxCLAZpa=OKN_ZNfOw@mail.gmail.com>
	<CAORUGqAoX1XR_TfqQ0i37ji3Wzm2Ab4YexsFJrX-dw6+p6DaXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:42878 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751887Ab2DBUdT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Apr 2012 16:33:19 -0400
Received: by bkcik5 with SMTP id ik5so2944052bkc.19
        for <ceph-devel@vger.kernel.org>; Mon, 02 Apr 2012 13:33:18 -0700 (PDT)
In-Reply-To: <CAORUGqAoX1XR_TfqQ0i37ji3Wzm2Ab4YexsFJrX-dw6+p6DaXw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Wido, Tommi, thanks

It would be great!

> Somehow that new disk has to be formatted and linked to the new OSD.
Yes, of course.
But in theory, the cluster's osd informations could be stored on the
mon or the mds, so they know the size, the filesystem, the partitions
of the failed osd and so, once replaced the hd, can recreate a new
"twin" osd

Il 02 aprile 2012 18:23, Tommi Virtanen <tommi.virtanen@dreamhost.com>
ha scritto:
> To echo what Wido said, this is definitely in the plan

Great news Tommi!

Marco
