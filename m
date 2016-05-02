From: Zack Cerza <zack@redhat.com>
Subject: Re: jewel selinux failures
Date: Mon, 2 May 2016 15:23:27 -0600
Message-ID: <CACk6FjkeJ9zGtyA=ai2B6=xS=nAkEbWk-ceg2-_Sk+HRy5k-MA@mail.gmail.com>
References: <alpine.DEB.2.11.1604302131300.26967@cpach.fuggernut.com>
	<1462172597.13876.120.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f49.google.com ([209.85.215.49]:35174 "EHLO
	mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754953AbcEBVX3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 May 2016 17:23:29 -0400
Received: by mail-lf0-f49.google.com with SMTP id j8so957082lfd.2
        for <ceph-devel@vger.kernel.org>; Mon, 02 May 2016 14:23:28 -0700 (PDT)
In-Reply-To: <1462172597.13876.120.camel@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Boris Ranto <branto@redhat.com>
Cc: Sage Weil <sweil@redhat.com>, "Development, Ceph" <ceph-devel@vger.kernel.org>

Fixed here:
https://github.com/ceph/teuthology/pull/852

This was my fault. I'm adding pcp to our test infrastructure, and
didn't anticipate (or reveal in my testing) that there would be
selinux denials coming from it.

On Mon, May 2, 2016 at 1:03 AM, Boris Ranto <branto@redhat.com> wrote:
> On Sat, 2016-04-30 at 21:32 -0400, Sage Weil wrote:
>> Hi Boris,
>>
>> Do you know why these selinux failures are happening on the jewel
>> branch?
>> I don't see any obvious differences from master, which doesn't seem
>> to be
>> hitting these.
>>
>> http://pulpito.ceph.com/sage-2016-04-30_16:27:00-rados-jewel---basic-
>> smithi/159724
>>
>> Thanks!
>> sage
>>
>
> Hi Sage,
>
> all of these are related to PCP (Performance Co-Pilot), not Ceph
> directly. You can notice that source context (scontext) is always
>
> pcp_pmlogger_t (or pcp_pmcd_t in one occurrence)
>
> which refers to pmlogger (or pmcd daemon).
>
> Maybe, someone have set-up PCP to measure performance of Ceph clusters?
> I can't say much more as I'm not familiar with PCP. AFAIK, PCP is not a
> dependency of Ceph so removing it should also make the denials
> disappear.
>
> -boris
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
