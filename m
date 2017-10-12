From: kefu chai <tchaikov@gmail.com>
Subject: Re: do we support building on rhel/centos 7.{0,1,2} ?
Date: Fri, 13 Oct 2017 00:37:29 +0800
Message-ID: <CAJE9aOO-x2Su07NMGuTG5wVFSYELC215RztZ2WozEGxT=O9NQw@mail.gmail.com>
References: <CAJE9aOMu87QgwZ5jrRPSUa6E461mYAJnxurmGwV-DU_=CTFgvg@mail.gmail.com>
 <CALqRxCyRKZ+nLF9BOvLQnWXhxngFoQxhhkZqNuhNvx_H0W6h9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:48291 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754644AbdJLQhd (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Oct 2017 12:37:33 -0400
Received: by mail-oi0-f48.google.com with SMTP id m198so9406699oig.5
        for <ceph-devel@vger.kernel.org>; Thu, 12 Oct 2017 09:37:33 -0700 (PDT)
In-Reply-To: <CALqRxCyRKZ+nLF9BOvLQnWXhxngFoQxhhkZqNuhNvx_H0W6h9Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>, amaredia@redhat.com
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

thanks for your valuable inputs guys! so we can start requiring cmake 2.8.12.

On Fri, Oct 13, 2017 at 12:19 AM, Ken Dreyer <kdreyer@redhat.com> wrote:
> cmake 2.8.12.2-2.el7 is in CentOS 7.4.
>
> https://access.redhat.com/errata/RHBA-2016:2175
>
> I don't think it's reasonable for Ceph upstream to support older
> CentOS versions that the CentOS community itself does not support.
>
> - Ken
>
> On Wed, Oct 11, 2017 at 10:27 PM, kefu chai <tchaikov@gmail.com> wrote:
>> hi all,
>>
>>
>> rocksdb's cmake script is using features[0] introduced by cmake
>> 2.8.12[1]. as install()[2] on 2.8.11 does not support "INCLUDES"
>> argument. hence, the build on el 7.{0,1,2} is broken now. but
>> http://docs.ceph.com/docs/master/start/os-recommendations/#luminous-12-2-z
>> claims that we support centos7..
>>
>> the reason why we are not trouble now is that we are not
>> building/testing build on them now.
>>
>> so the question is, shall we support build on centos 7.{0,1,2} on
>> which cmake 2.8.11? if the answer is yes, we need to maintain the
>> patched rocksdb submodule in our fork.
>>
>> --
>> [0] https://github.com/facebook/rocksdb/pull/2998
>> [1] https://cmake.org/cmake/help/v2.8.12/cmake.html#command:install
>> [2] https://cmake.org/cmake/help/v2.8.11/cmake.html#command:install
>>
>> --
>> Regards
>> Kefu Chai
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Regards
Kefu Chai
