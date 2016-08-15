From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: Sequential write performance on cloning images
Date: Mon, 15 Aug 2016 08:16:44 -0400
Message-ID: <CA+aFP1D+gBbTK=JiJSG=nevZoxxTAq=OgU6GGFQ=uO0smLsCKw@mail.gmail.com>
References: <CAOb-7EzSpjYp9dZB4j2UoTgB6H0WZM5SeC2rJ=EYMc9R9a6x3Q@mail.gmail.com>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:34130 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752707AbcHOMQq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Aug 2016 08:16:46 -0400
Received: by mail-pf0-f179.google.com with SMTP id p64so16757240pfb.1
        for <ceph-devel@vger.kernel.org>; Mon, 15 Aug 2016 05:16:45 -0700 (PDT)
In-Reply-To: <CAOb-7EzSpjYp9dZB4j2UoTgB6H0WZM5SeC2rJ=EYMc9R9a6x3Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ridge Chen <ridge.chen@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Sun, Aug 14, 2016 at 10:41 PM, Ridge Chen <ridge.chen@gmail.com> wrote:
> I have tested on hammer and jewel, the results are similar. Is it expected?

In this case, there actually would not be an extra copy-up since you
already performed the necessary copy-ups during the "dd" against
"clone-vol1". The only difference, on the librbd side, is that the
write operation would have an additional "assert object exists"
operation before the write operation.

Do you see similar differences with the librbd cache disabled and the
object map disabled?



-- 
Jason
