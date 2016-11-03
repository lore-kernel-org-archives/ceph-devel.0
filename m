From: Dan van der Ster <dan@vanderster.com>
Subject: Re: mounting manila share with 4.8 kernel
Date: Thu, 3 Nov 2016 14:19:46 +0100
Message-ID: <CABZ+qqkXYYmSwwhekjTTYZFZCitE_FSWs37z=jmMk1xqtDHTcw@mail.gmail.com>
References: <CABZ+qqk8ucZodD=H=BAp4RySRLdNtD=+eneCWUO8xOYBYfupOg@mail.gmail.com>
 <CAOi1vP-N+5-5jFmqvbhY-VTfvG2=5ykiuEjD3EDGqnaPObrgsA@mail.gmail.com> <CABZ+qqmtGduKSRKeKzDUpn=Ct-MGFnnwVMz1Fx9x=Grd_Ukw7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:36945 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755228AbcKCNUa (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Nov 2016 09:20:30 -0400
Received: by mail-wm0-f52.google.com with SMTP id t79so100577211wmt.0
        for <ceph-devel@vger.kernel.org>; Thu, 03 Nov 2016 06:20:29 -0700 (PDT)
Received: from mail-wm0-f44.google.com (mail-wm0-f44.google.com. [74.125.82.44])
        by smtp.gmail.com with ESMTPSA id b184sm9061556wma.0.2016.11.03.06.20.26
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Nov 2016 06:20:27 -0700 (PDT)
Received: by mail-wm0-f44.google.com with SMTP id t79so100575624wmt.0
        for <ceph-devel@vger.kernel.org>; Thu, 03 Nov 2016 06:20:26 -0700 (PDT)
In-Reply-To: <CABZ+qqmtGduKSRKeKzDUpn=Ct-MGFnnwVMz1Fx9x=Grd_Ukw7g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "Yan, Zheng" <zyan@redhat.com>

On Thu, Nov 3, 2016 at 11:23 AM, Dan van der Ster <dan@vanderster.com> wrote:
> Actually we can reproduce this caps issue without using namespaces. It
> seems that the kernel will not mount at all if the client cap does not
> have 'allow r' on the mds.

Ahh I found this in the 4.9 PR:

      ceph: avoid accessing / when mounting a subpath

Cheers, Dan
