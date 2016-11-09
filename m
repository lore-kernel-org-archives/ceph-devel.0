From: Haomai Wang <haomai@xsky.com>
Subject: Re: 25G RDMA networking thoughts???
Date: Wed, 9 Nov 2016 11:33:39 +0800
Message-ID: <CACJqLyb=fZEtqVpTtgidMQMocEEPt3XphreCN9U5rmRmqej0VA@mail.gmail.com>
References: <acbd757e-d360-4e37-bc26-60eb9d6ec162.james.liu@alibaba-inc.com>
 <16962d43-7f03-4e92-9eee-b3f4ab80408c.james.liu@alibaba-inc.com> <35adaeb1-25ff-4f16-be56-0589e483f054.james.liu@alibaba-inc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ty1jpn01on0090.outbound.protection.outlook.com ([104.47.93.90]:6602
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751282AbcKIDd4 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 8 Nov 2016 22:33:56 -0500
Received: by mail-ua0-f174.google.com with SMTP id b35so164003986uaa.3
        for <ceph-devel@vger.kernel.org>; Tue, 08 Nov 2016 19:33:47 -0800 (PST)
In-Reply-To: <35adaeb1-25ff-4f16-be56-0589e483f054.james.liu@alibaba-inc.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "LIU, Fei" <james.liu@alibaba-inc.com>
Cc: Sage Weil <sweil@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Nov 9, 2016 at 5:51 AM, LIU, Fei <james.liu@alibaba-inc.com> wrote:
> Hi Sage=EF=BC=8C
>    thanks=EF=BC=8CSorry for confusing you.  What i am trying to say is as=
ync with
> RDMA over ethernet.  I understand that async messenger support TCP based
> ethernet well.
> Secondly, would be possible to have data traffice among osds categorized
> into different service level to better provide QoS for the whole Ceph
> cluster service if we can within the 25G RDMA faclitiis?
> Thirdly, would be possible to provide unified network for both storage an=
d
> compute within QoS control? We don't expect the replication/recovery/refi=
ll
> to have bad impact to the latency of application.

Currently I only use rdma over ib to test. I don't have eth over ib
nic by hand. I don't know what need to do for eth rdma nic...

>
>
>    Regards,
>    James
>
> ------------------------------------------------------------------
> From:Sage Weil <sweil@redhat.com>
> Time:2016 Nov 8 (Tue) 13:45
> To:James <james.liu@alibaba-inc.com>
> Cc:Haomai Wang <haomai@xsky.com>; ceph-devel <ceph-devel@vger.kernel.org>
> Subject:Re: 25G RDMA networking thoughts???
>
> On Wed, 9 Nov 2016, LIU, Fei wrote:
>> Hi Sage=EF=BC=8C
>>    Yes, Totally understood.  25G RDMA network for Ceph cluster is built
>> for
>> interal test. Xio messenger and Async messenger(But it can only support
>> infiniband,right) are going to be two options. We are carefully evaluate
>> both of these two options. But the most important goal in the end is to
>> see
>> how bluestore works with rdma to bring down the total latency for worklo=
ad
>> like OLTP.
>>
>> Hi Haomai,
>>    Would you mind let us know when the async messenger is going to suppo=
rt
>> ethernet if not support yet?
>
> The default async backend is PosixStack which is all TCP-based.  (And
> async is now the default messenger in kraken.)
>
> sage
>
>>
>>    Regards,
>>    James
>>       ------------------------------------------------------------------
>> From:Sage Weil <sweil@redhat.com>
>> Time:2016 Nov 8 (Tue) 13:19
>> To:James <james.liu@alibaba-inc.com>
>> Subject:Re: 25G RDMA networking thoughts???
>>
>> [adding ceph-devel]
>>
>> On Wed, 9 Nov 2016, LIU, Fei wrote:
>> > Hi Sage,
>> >    I was wondering do you have any thoughts of 25G RDMA networking
>> > construction besides of xio-messenger/async?  Is there any guidance to
>> > bu
>> ild
>> > 25G RDMA netowrk to better control the whole Ceph cluster latency?
>>
>> The only RDMA options right now are XioMessenger and AsyncMessenger's ne=
w
>> RDMA backend. Both are experimental, but we'd be very interested in
>> hearing about your experience.
>>
>> I wouldn't assume that latency is network-related, though.  More often
>> than not we're finding it's the OSD backend or the OSD request internals
>> (e.g., request scheduling or peering) that's the culprit...
>>
>> sage
>>
>>
>>
>>
>
>
