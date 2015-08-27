From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: async messenger
Date: Thu, 27 Aug 2015 21:22:34 +0800
Message-ID: <CACJqLyapdDqvL5W3j9fZyH6BY0tRw8xVWKrsrKTdm2+vh7Uarg@mail.gmail.com>
References: <alpine.DEB.2.00.1508241427170.13128@cobra.newdream.net>
	<CACJqLyZ_9AM+_9cPxdm-Ab7dFc-CKze5khZPQGBrDdjxRMSrdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yk0-f182.google.com ([209.85.160.182]:35576 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797AbbH0NWe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Aug 2015 09:22:34 -0400
Received: by ykbi184 with SMTP id i184so19078878ykb.2
        for <ceph-devel@vger.kernel.org>; Thu, 27 Aug 2015 06:22:34 -0700 (PDT)
In-Reply-To: <CACJqLyZ_9AM+_9cPxdm-Ab7dFc-CKze5khZPQGBrDdjxRMSrdQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I ran a random job(http://pulpito.ceph.com/haomai-2015-08-27_04:09:28-rados-master-distro-basic-multi/)
and the result seemed ok to me.

On Tue, Aug 25, 2015 at 9:22 AM, Haomai Wang <haomaiwang@gmail.com> wrote:
> On Tue, Aug 25, 2015 at 5:28 AM, Sage Weil <sweil@redhat.com> wrote:
>> Hi Haomai,
>>
>> How did your most recent async messenger run go?
>>
>> If there aren't major issues, we'd like to start mixing it in with the
>> regular rados suite by doing 'ms type = random'...
>
> From last run, we have no async related failed jobs. I would like to
> scheduler a "random" type by hand to see whether have terrible
> compatible problem.
>
>>
>> sage
>
>
>
> --
> Best Regards,
>
> Wheat



-- 
Best Regards,

Wheat
