From: kefu chai <tchaikov@gmail.com>
Subject: Re: Sudden Bluestore includes
Date: Thu, 23 Mar 2017 16:02:05 +0800
Message-ID: <CAJE9aOMM3a4Gr7kUC-FqpJuu0eGjP_17pnknNa63ZVtBcb7phA@mail.gmail.com>
References: <49d0042f-350e-91a6-dedf-ee7abad98a2e@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f179.google.com ([209.85.217.179]:33814 "EHLO
        mail-ua0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932117AbdCWICH (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 23 Mar 2017 04:02:07 -0400
Received: by mail-ua0-f179.google.com with SMTP id v22so4316955uaa.1
        for <ceph-devel@vger.kernel.org>; Thu, 23 Mar 2017 01:02:06 -0700 (PDT)
In-Reply-To: <49d0042f-350e-91a6-dedf-ee7abad98a2e@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

+ ceph-devel

On Wed, Mar 22, 2017 at 8:17 PM, Willem Jan Withagen <wjw@digiware.nl> wrote:
> Hi Kefu,
>
> Any idea why I all of a sudden get these bluestore errors from includes??
> I tried blaming all files I could think of, but that all seems rather
> stable and only changed long ago..
>
> In file included from
> /home/jenkins/workspace/ceph-master/src/test/objectstore/store_test_fixture.cc:8:
> In file included from
> /home/jenkins/workspace/ceph-master/src/os/bluestore/BlueStore.h:42:
> /home/jenkins/workspace/ceph-master/src/os/bluestore/BlockDevice.h:41:12:
> error: no member named 'aio_t' in 'FS'
>   list<FS::aio_t> pending_aios;    ///< not yet submitted
>        ~~~~^
> /home/jenkins/workspace/ceph-master/src/os/bluestore/BlockDevice.h:42:12:
> error: no member named 'aio_t' in 'FS'
>   list<FS::aio_t> running_aios;    ///< submitting or submitted
>        ~~~~^
>
> thanx for any ideas...


see https://github.com/ceph/ceph/commit/52c93f5b71e34625969660e7d47e733aee8ea98b



-- 
Regards
Kefu Chai
