From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: Huge lookup when recursively mkdir
Date: Fri, 20 Oct 2017 10:55:24 +0800
Message-ID: <CAAM7YAk2+ekeYdJ_E4d5wB_SoiL_eGA0P9fGuxvEkz3r11ytTQ@mail.gmail.com>
References: <CAEYCsVLCS5aPC8M8PAU5UTS0pKzhp1aWBW6L72ZwvUEetbstpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51]:44495 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751017AbdJTCzZ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Oct 2017 22:55:25 -0400
Received: by mail-oi0-f51.google.com with SMTP id v132so18103612oie.1
        for <ceph-devel@vger.kernel.org>; Thu, 19 Oct 2017 19:55:25 -0700 (PDT)
In-Reply-To: <CAEYCsVLCS5aPC8M8PAU5UTS0pKzhp1aWBW6L72ZwvUEetbstpw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xiaoxi Chen <superdebuger@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, John Spray <jspray@redhat.com>

On Fri, Oct 20, 2017 at 12:49 AM, Xiaoxi Chen <superdebuger@gmail.com> wrote:
> Hi,
>
>       I am seeing a lot of lookup request when doing recursive mkdir.
>       The workload behavior is like:
>           mkdir DIR0
>           mkdir DIR0/DIR1
>           mkdir DIR0/DIR1/DIR2
>           ....
>           mkdir DIR0/DIR1/DIR2......./DIR7
>           create DIR0/DIR1/DIR2......./DIR7/FILE1
>
>       and concurrently run on 50+ clients, the dir name in different
> clients may or maynot be the same.
>
>        from the admin socket I was seeing ~50K create requests, but
> got 400K lookup requests. The lookup eat up most of the mds capability
> so file create is slow.
>
>        Where is the lookup comes from and can we have anyway to
> optimize it out ?
>

I don't see this behavior when running following commands in 4.13
kernel client and luminous version ceph-fuse. which client do you use?

mkdir d1
mkdir d1/d2
mkdir d1/d2/d3
mkdir d1/d2/d3/d4/
mkdir d1/d2/d3/d4/d5
touch d1/d2/d3/d4/d5/f

>      Xiaoxi
