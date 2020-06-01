From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: [PATCH 0/2] rbd: compression_hint option
Date: Mon, 1 Jun 2020 17:23:09 -0400
Message-ID: <CA+aFP1Ddw+jWpw187qgOvZRjKfqNGYO6cCwV0pwcqd4BQytY0w@mail.gmail.com>
References: <20200601195826.17159-1-idryomov@gmail.com>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30007 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728182AbgFAVXZ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 1 Jun 2020 17:23:25 -0400
Received: by mail-wr1-f69.google.com with SMTP id h92so461918wrh.23
        for <ceph-devel@vger.kernel.org>; Mon, 01 Jun 2020 14:23:21 -0700 (PDT)
In-Reply-To: <20200601195826.17159-1-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Jun 1, 2020 at 3:58 PM Ilya Dryomov <idryomov@gmail.com> wrote:
>
> Hello,
>
> This adds support for RADOS compressible/incompressible allocation
> hints, available since Kraken.
>
> Thanks,
>
>                 Ilya
>
>
> Ilya Dryomov (2):
>   libceph: support for alloc hint flags
>   rbd: compression_hint option
>
>  drivers/block/rbd.c             | 44 ++++++++++++++++++++++++++++++++-
>  include/linux/ceph/osd_client.h |  4 ++-
>  include/linux/ceph/rados.h      | 14 +++++++++++
>  net/ceph/osd_client.c           |  8 +++++-
>  4 files changed, 67 insertions(+), 3 deletions(-)
>
> --
> 2.19.2
>

lgtm

Reviewed-by: Jason Dillaman <dillaman@redhat.com>


-- 
Jason
