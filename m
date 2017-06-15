From: Haomai Wang <haomai@xsky.com>
Subject: Re: question on asyncmessenger::wait()
Date: Thu, 15 Jun 2017 16:52:43 +0800
Message-ID: <CACJqLyYtwoyMxmkRxCTu23Fgyp8cs4wXJptjJYvJ7HK0khg41Q@mail.gmail.com>
References: <CALi+v182tnn88LCFUs5zu44-2Upv_z0ZAUPVsxLtmL-Tr106VQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-hk2apc01on0135.outbound.protection.outlook.com ([104.47.124.135]:6762
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750923AbdFOIwx (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 15 Jun 2017 04:52:53 -0400
Received: by mail-oi0-f45.google.com with SMTP id s3so4326428oia.0
        for <ceph-devel@vger.kernel.org>; Thu, 15 Jun 2017 01:52:48 -0700 (PDT)
In-Reply-To: <CALi+v182tnn88LCFUs5zu44-2Upv_z0ZAUPVsxLtmL-Tr106VQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: zengran zhang <z13121369189@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Jun 15, 2017 at 4:12 PM, zengran zhang <z13121369189@gmail.com> wrote:
> Hi Haomai:
>
>     in current implement why do not call stack->stop() in
> asyncmsg::wait(), if so we could join the works. but now the works
> will be joined in ~CephContext, and when _associated_objs be
> deleted...

because we want to delay the deconstruct

>     we find that map_cache may leak some osdmapref, maybe because the
> works still work when OSD destruct...

we will cleanup all related resources in messenger layer, Stack won't
maintain any resource except it owns

>
>     regards!
