From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Question about write op processing of OSD
Date: Thu, 15 Dec 2016 16:35:15 -0800
Message-ID: <CAJ4mKGaQ0UYWOnLshUJob1rdjTc2f_K1_qagGp4mh0x_ZjgNDA@mail.gmail.com>
References: <1d497a83.c1b.15904fdf41e.Coremail.xxhdx1985126@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f182.google.com ([209.85.223.182]:33728 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755113AbcLPAl1 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Dec 2016 19:41:27 -0500
Received: by mail-io0-f182.google.com with SMTP id d9so84949124ioe.0
        for <ceph-devel@vger.kernel.org>; Thu, 15 Dec 2016 16:41:27 -0800 (PST)
In-Reply-To: <1d497a83.c1b.15904fdf41e.Coremail.xxhdx1985126@163.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: xxhdx1985126 <xxhdx1985126@163.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Dec 15, 2016 at 4:17 PM, xxhdx1985126 <xxhdx1985126@163.com> wrote:
>
> Hi, everyone.
>
>
> What will the OSD do in the following scenario?
>
>        Say, a MOSDRepop M that is initiated at client A is being processed on an OSD.X, during which the acting primary turn "down" due to some error and OSD.X is chosen to be the new acting primary. Since OSD.X is a replica OSD for MOSDRepOp M, how can client A be acked after OSD.X finished the processing of M? Or does A be acked at all in this kind of circumstances?

The client is not acked by OSD.X, but when the client sees the OSDMap
marking down the previous primary, it will resubmit MOSDOpM to OSD.X
(and increment the retry counter). OSD.X will notice that MOSDOpM has
already been completed and reply with the same answer it gave
previously.[1]
-Greg
[1]: Barring protocol or implementation bugs. There have historically
been some issues with things like (successful) deletes returning
ENOENT instead of 0; I don't remember if all the known ones have been
squashed or not.
