From: kefu chai <tchaikov@gmail.com>
Subject: Re: Build failed in Jenkins: ceph-master #1758
Date: Fri, 9 Feb 2018 11:36:13 +0800
Message-ID: <CAJE9aONEDL0GBJMD+pA4GHQf9-Kjc8D9A0n5o4G3bCKLU3U2QA@mail.gmail.com>
References: <1275455898.55.1518102782484.JavaMail.jenkins@cephdev.digiware.nl> <dfc202fa-e5d3-1d3f-99be-86eb87a20dd9@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f174.google.com ([209.85.216.174]:37530 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752392AbeBIDgP (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Feb 2018 22:36:15 -0500
Received: by mail-qt0-f174.google.com with SMTP id s27so8988427qts.4
        for <ceph-devel@vger.kernel.org>; Thu, 08 Feb 2018 19:36:14 -0800 (PST)
In-Reply-To: <dfc202fa-e5d3-1d3f-99be-86eb87a20dd9@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Feb 8, 2018 at 11:19 PM, Willem Jan Withagen <wjw@digiware.nl> wrote:
> Hi Kefu,
>
> Clang complains since your commit:
> https://github.com/ceph/ceph/commit/0e0d0cd8d1adee998109c2714ed04f43b3212d7e
>
> about:
> /home/jenkins/workspace/ceph-master/src/test/librados/lock.cc:24:33:
> error: no template named 'invoke_result_t' in namespace 'std'
>          typename Return = std::invoke_result_t<Func, Args...>>
>                            ~~~~~^
> 1 error generated.
> gmake[2]: ***
> [src/test/librados/CMakeFiles/ceph_test_rados_api_lock.dir/build.make:63:
> src/test/librados/CMakeFiles/ceph_test_rados_api_lock.dir/lock.cc.o] Error 1
>
> Suggestions on how to fix this?
>

could you give a spin of https://github.com/ceph/ceph/pull/20379 ?
sorry for the inconvenience.

-- 
Regards
Kefu Chai
