From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: do we support building on rhel/centos 7.{0,1,2} ?
Date: Thu, 12 Oct 2017 10:19:15 -0600
Message-ID: <CALqRxCyRKZ+nLF9BOvLQnWXhxngFoQxhhkZqNuhNvx_H0W6h9Q@mail.gmail.com>
References: <CAJE9aOMu87QgwZ5jrRPSUa6E461mYAJnxurmGwV-DU_=CTFgvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f174.google.com ([209.85.217.174]:50325 "EHLO
        mail-ua0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752849AbdJLQTU (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Oct 2017 12:19:20 -0400
Received: by mail-ua0-f174.google.com with SMTP id v27so3401675uav.7
        for <ceph-devel@vger.kernel.org>; Thu, 12 Oct 2017 09:19:20 -0700 (PDT)
In-Reply-To: <CAJE9aOMu87QgwZ5jrRPSUa6E461mYAJnxurmGwV-DU_=CTFgvg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kefu chai <tchaikov@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

cmake 2.8.12.2-2.el7 is in CentOS 7.4.

https://access.redhat.com/errata/RHBA-2016:2175

I don't think it's reasonable for Ceph upstream to support older
CentOS versions that the CentOS community itself does not support.

- Ken

On Wed, Oct 11, 2017 at 10:27 PM, kefu chai <tchaikov@gmail.com> wrote:
> hi all,
>
>
> rocksdb's cmake script is using features[0] introduced by cmake
> 2.8.12[1]. as install()[2] on 2.8.11 does not support "INCLUDES"
> argument. hence, the build on el 7.{0,1,2} is broken now. but
> http://docs.ceph.com/docs/master/start/os-recommendations/#luminous-12-2-z
> claims that we support centos7..
>
> the reason why we are not trouble now is that we are not
> building/testing build on them now.
>
> so the question is, shall we support build on centos 7.{0,1,2} on
> which cmake 2.8.11? if the answer is yes, we need to maintain the
> patched rocksdb submodule in our fork.
>
> --
> [0] https://github.com/facebook/rocksdb/pull/2998
> [1] https://cmake.org/cmake/help/v2.8.12/cmake.html#command:install
> [2] https://cmake.org/cmake/help/v2.8.11/cmake.html#command:install
>
> --
> Regards
> Kefu Chai
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
