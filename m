From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: bluestore, and how to handle buggy kernels
Date: Mon, 7 Nov 2016 12:46:40 -0700
Message-ID: <CALqRxCw1z3-HAh1iQTROmmjTGosZ-upFjnrYd5hr1Y37r3tYww@mail.gmail.com>
References: <alpine.DEB.2.11.1611061550170.18089@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f51.google.com ([209.85.213.51]:34064 "EHLO
        mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751736AbcKGTxz (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Nov 2016 14:53:55 -0500
Received: by mail-vk0-f51.google.com with SMTP id x186so130683018vkd.1
        for <ceph-devel@vger.kernel.org>; Mon, 07 Nov 2016 11:53:54 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1611061550170.18089@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, "sepia@ceph.com" <sepia@ceph.com>, Zack Cerza <zcerza@redhat.com>

On Sun, Nov 6, 2016 at 8:59 AM, Sage Weil <sweil@redhat.com> wrote:
> Under load BlueStore triggers this bug
>
>         http://www.gossamer-threads.com/lists/linux/kernel/1993181
>
> in 3.13.0-100-generic, the original trusty 14.04 kernel.  We currently do
> most of the Ceph testing on trusty, xenial, and centos 7.x, and we use the
> default/original distro kernels (vs the latest ones) exactly so that we
> notice when kernel bugs like this rear their heads.
>
> (We had an embarassing problem with firefly where a bug in the old precise
> 12.04 kernel affected users but we were testing with the latest ubuntu
> kernel.)

In this case with Precise, was the problem that we were testing
Ubuntu's HWE kernels [1], so we missed that the bug existed in their
GA kernel (kernel 3.2)?

Excluding Ubuntu's HWE situation, I think we'd always want to test
against "the newest", right? Users should be running whatever is the
newest, for security's sake.

- Ken

[1] https://wiki.ubuntu.com/Kernel/LTSEnablementStack#Kernel.2FSupport.A12.04.x_Ubuntu_Kernel_Support
