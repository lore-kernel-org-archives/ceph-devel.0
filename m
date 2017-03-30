From: David Casier <david.casier@aevoo.fr>
Subject: Re: Idea for optimize an OSD rebuild
Date: Thu, 30 Mar 2017 11:56:18 +0200
Message-ID: <CA+gn+zmdct4LKiMLH=PPs_2Kc5MEyAUN7r-d-j9WDpGv0WoyrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f54.google.com ([209.85.218.54]:34962 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932302AbdC3J4Z (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Mar 2017 05:56:25 -0400
Received: by mail-oi0-f54.google.com with SMTP id f193so25917447oib.2
        for <ceph-devel@vger.kernel.org>; Thu, 30 Mar 2017 02:56:24 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Vincent Godin <vince.mlist@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Vincent,

You can define the affinity on the osd :

ceph osd primary-affinity osd.<ID> 0


________________________________________________________

Cordialement,

David CASIER

________________________________________________________


2017-03-30 11:47 GMT+02:00 Vincent Godin <vince.mlist@gmail.com>:
>
> When you replace a failed osd, it has to recover all of its pgs and so
> it is pretty busy. Is it possible to tell this OSD to not become
> primary for any of its already synchronized pgs till every pgs (of the
> OSD) have recovered ? It should accelerate the rebuild process because
> this OSD won't have to serve client's read requests but just sync the
> writes request from the OSDs owning the primary pgs and recover. Is
> there something wrong with this idea ?
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
