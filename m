From: Yuri Weinstein <yweinste@redhat.com>
Subject: Re: Jewel 10.2.8 -> QE
Date: Fri, 30 Jun 2017 12:54:03 -0700
Message-ID: <CAMMFjmH5coCEnnx79Jpr3U1fx56PMBGQTfZHsRO-i6iVP0t6dw@mail.gmail.com>
References: <078ac38a-9f3b-3d8a-ff8b-7764eb9c13c1@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f178.google.com ([209.85.128.178]:35797 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752486AbdF3TyF (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 30 Jun 2017 15:54:05 -0400
Received: by mail-wr0-f178.google.com with SMTP id k67so208430213wrc.2
        for <ceph-devel@vger.kernel.org>; Fri, 30 Jun 2017 12:54:05 -0700 (PDT)
In-Reply-To: <078ac38a-9f3b-3d8a-ff8b-7764eb9c13c1@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Nathan

This SHA1 build on trusty failed.
Can you do another pls ?

https://jenkins.ceph.com/job/ceph-dev-build/ARCH=x86_64,AVAILABLE_ARCH=x86_64,AVAILABLE_DIST=trusty,DIST=trusty,MACHINE_SIZE=huge/8736//consoleFull

Thx
YuriW

On Fri, Jun 30, 2017 at 7:49 AM, Nathan Cutler <ncutler@suse.cz> wrote:
> Hi Yuri:
>
> The last lead signed off on 10.2.8 today, so it's ready for QE to start
> testing. The SHA1 is 53a3be7261cfeb12445fbdba8238eefa40ed09f5 (tip of
> "jewel" branch).
>
> Nathan
