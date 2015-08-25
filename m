From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: async messenger
Date: Tue, 25 Aug 2015 09:22:14 +0800
Message-ID: <CACJqLyZ_9AM+_9cPxdm-Ab7dFc-CKze5khZPQGBrDdjxRMSrdQ@mail.gmail.com>
References: <alpine.DEB.2.00.1508241427170.13128@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yk0-f182.google.com ([209.85.160.182]:34739 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753979AbbHYBWP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Aug 2015 21:22:15 -0400
Received: by ykdt205 with SMTP id t205so141630777ykd.1
        for <ceph-devel@vger.kernel.org>; Mon, 24 Aug 2015 18:22:15 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1508241427170.13128@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Aug 25, 2015 at 5:28 AM, Sage Weil <sweil@redhat.com> wrote:
> Hi Haomai,
>
> How did your most recent async messenger run go?
>
> If there aren't major issues, we'd like to start mixing it in with the
> regular rados suite by doing 'ms type = random'...

From last run, we have no async related failed jobs. I would like to
scheduler a "random" type by hand to see whether have terrible
compatible problem.

>
> sage



-- 
Best Regards,

Wheat
