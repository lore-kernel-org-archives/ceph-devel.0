From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: [RFC v5] RBD: Add support readv,writev for rbd
Date: Thu, 16 Feb 2017 10:26:13 -0500
Message-ID: <CA+aFP1BuRC73WuWo=cS1XRAM=K+in6ac8WFPU26LVN+zdHWq=g@mail.gmail.com>
References: <20170216084318.11122-1-jazeltq@gmail.com> <20170216090002.12511-1-jazeltq@gmail.com>
 <D7075812-8210-4092-8ED4-BB6FAC4E612C@gmail.com> <CAKZcxgfA6YvAOZfngyf0QC5iF1WwGK86DcXPJPwBOr_XFfzMuA@mail.gmail.com>
 <887093105.8854266.1487258021988.JavaMail.zimbra@oxygem.tv>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f49.google.com ([209.85.215.49]:33027 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754231AbdBPP0Q (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Feb 2017 10:26:16 -0500
Received: by mail-lf0-f49.google.com with SMTP id x1so9832890lff.0
        for <ceph-devel@vger.kernel.org>; Thu, 16 Feb 2017 07:26:15 -0800 (PST)
In-Reply-To: <887093105.8854266.1487258021988.JavaMail.zimbra@oxygem.tv>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: jazeltq <jazeltq@gmail.com>, Tiger Hu <hufh2004@gmail.com>, Josh Durgin <jdurgin@redhat.com>, Jeff Cody <jcody@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, qemu-devel <qemu-devel@nongnu.org>, ceph-devel <ceph-devel@vger.kernel.org>, tianqing <tianqing@unitedstack.com>

On Thu, Feb 16, 2017 at 10:13 AM, Alexandre DERUMIER
<aderumier@odiso.com> wrote:
> Hi, I would like to bench it with small 4k read/write.
>
> On the ceph side,do we need this PR ? :
> https://github.com/ceph/ceph/pull/13447

Yes, that is the correct PR for the client-side librbd changes. You
should be able to test it against Hammer/Jewel-release clusters.

-- 
Jason
