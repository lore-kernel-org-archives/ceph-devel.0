From: Xuehan Xu <xxhdx1985126@gmail.com>
Subject: Re: How to run ceph_test_rados_api_tier?
Date: Wed, 9 Aug 2017 22:06:33 +0800
Message-ID: <CAJACTufW9z454UXgR0C3yH1+bx8XgO3Y9QLrVsMbJh9=doLXEg@mail.gmail.com>
References: <CAJACTueQZG9mjF1OYD3D3MbM=gsjMDsvv8t+-EEA4aAahHw37A@mail.gmail.com>
 <alpine.DEB.2.11.1708091402290.20435@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:34668 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752916AbdHIOGf (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Aug 2017 10:06:35 -0400
Received: by mail-oi0-f47.google.com with SMTP id x3so62273767oia.1
        for <ceph-devel@vger.kernel.org>; Wed, 09 Aug 2017 07:06:34 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1708091402290.20435@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

OK, I got it, thank you:-)

On 9 August 2017 at 22:04, Sage Weil <sage@newdream.net> wrote:
> On Wed, 9 Aug 2017, Xuehan Xu wrote:
>> Hi, everyone.
>>
>> I'm trying to write a new test case in tier.cc. However, when I try to
>> test that test case by running "make check", it seems that "make
>> check" only run ceph_test_object_map, no other "ceph_test_XXX"
>> runnables are run including "ceph_test_rados_api_tier". Why? And how
>> to run other ceph_test_XXX runnables?
>
>  ../src/vstart.sh -d -n -x -l
>  bin/ceph_test_rados_api_tier
>
> or probably more like
>
>  CEPH_ARGS="--log-file c --no-log-to-stderr --debug-ms=1 ..." bin/ceph_test_rados_api_tier
>
> It's also run as part of qa/workunits/rados/test.sh by teuthology.  You
> can run that fully battery of tests with
>
>  PATH=$PATH:bin ../qa/workunits/rados/test.sh
>
> sage
>
