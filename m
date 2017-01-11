From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [ceph-users] RBD v1 image format ...
Date: Wed, 11 Jan 2017 18:17:34 +0100
Message-ID: <CAOi1vP_K90CBOfMZ247QON+qCqk8wzRu+CiqukPvctAP=DBT-Q@mail.gmail.com>
References: <CA+aFP1C6Zc0Pry=bqjNBzqBMdd14zRzRMvy9yaQrM+F_SS9xBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:37346 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934785AbdAKRRh (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Jan 2017 12:17:37 -0500
Received: by mail-wm0-f54.google.com with SMTP id c206so117745052wme.0
        for <ceph-devel@vger.kernel.org>; Wed, 11 Jan 2017 09:17:36 -0800 (PST)
In-Reply-To: <CA+aFP1C6Zc0Pry=bqjNBzqBMdd14zRzRMvy9yaQrM+F_SS9xBQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jason Dillaman <dillaman@redhat.com>
Cc: ceph-users <ceph-users@lists.ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Jan 11, 2017 at 5:09 PM, Jason Dillaman <jdillama@redhat.com> wrote:
> I would like to propose that starting with the Luminous release of Ceph, RBD
> will no longer support the creation of v1 image format images via the rbd
> CLI and librbd.
>
> We previously made the v2 image format the default and deprecated the v1
> format under the Jewel release. It is important to note that we would still
> support the use of v1 images by the CLI, VMs, etc for Luminous.
>
> Any objections or concerns?

We need a way to create v1 images for testing purposes for as long as
the use is supported.  I'd vote for just making it harder - hide
--image-format 1 behind an additional (possibly undocumented) flag, if
the maintenance burden is acceptable.

Thanks,

                Ilya
