From: Dongsheng Yang <dongsheng.yang@easystack.cn>
Subject: Re: [PATCH 0/2] rbd: compression_hint option
Date: Tue, 2 Jun 2020 10:34:28 +0800
Message-ID: <f5dc6344-a2eb-1991-7a91-de0b41f32ba8@easystack.cn>
References: <20200601195826.17159-1-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m9783.mail.qiye.163.com ([220.181.97.83]:58924 "EHLO
        m9783.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbgFBCmE (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 1 Jun 2020 22:42:04 -0400
In-Reply-To: <20200601195826.17159-1-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org
Cc: Jason Dillaman <jdillama@redhat.com>

Reviewed-by: Dongsheng Yang<dongsheng.yang@easystack.cn>


Thanx

Yang

ÔÚ 6/2/2020 3:58 AM, Ilya Dryomov Ð´µÀ:
> Hello,
>
> This adds support for RADOS compressible/incompressible allocation
> hints, available since Kraken.
>
> Thanks,
>
>                  Ilya
>
>
> Ilya Dryomov (2):
>    libceph: support for alloc hint flags
>    rbd: compression_hint option
>
>   drivers/block/rbd.c             | 44 ++++++++++++++++++++++++++++++++-
>   include/linux/ceph/osd_client.h |  4 ++-
>   include/linux/ceph/rados.h      | 14 +++++++++++
>   net/ceph/osd_client.c           |  8 +++++-
>   4 files changed, 67 insertions(+), 3 deletions(-)
>
