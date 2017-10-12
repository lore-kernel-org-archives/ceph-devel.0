From: Matt Benjamin <mbenjami@redhat.com>
Subject: Re: do we support building on rhel/centos 7.{0,1,2} ?
Date: Thu, 12 Oct 2017 11:19:39 -0400
Message-ID: <CAKOnar=uJ0PxGCG+jOBVrBdqaU_ki4mLzMMAzPBCAEa1_JYuxA@mail.gmail.com>
References: <CAJE9aOMu87QgwZ5jrRPSUa6E461mYAJnxurmGwV-DU_=CTFgvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f181.google.com ([209.85.223.181]:54633 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751441AbdJLPTk (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Oct 2017 11:19:40 -0400
Received: by mail-io0-f181.google.com with SMTP id h66so5840087ioh.11
        for <ceph-devel@vger.kernel.org>; Thu, 12 Oct 2017 08:19:40 -0700 (PDT)
In-Reply-To: <CAJE9aOMu87QgwZ5jrRPSUa6E461mYAJnxurmGwV-DU_=CTFgvg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kefu chai <tchaikov@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I'd love to find that we could avoid this...

regards,

Matt

On Thu, Oct 12, 2017 at 12:27 AM, kefu chai <tchaikov@gmail.com> wrote:
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



-- 

Matt Benjamin
Red Hat, Inc.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://www.redhat.com/en/technologies/storage

tel.  734-821-5101
fax.  734-769-8938
cel.  734-216-5309
