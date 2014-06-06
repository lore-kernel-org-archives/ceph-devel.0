From: zou wonder <wonder.zou@gmail.com>
Subject: Re: What the ceph do when detecting one OSD overloaded?
Date: Fri, 6 Jun 2014 17:27:49 +0800
Message-ID: <CAOXjUBxO69M0dKU0kSx0i8Zp8pNR_XEhNWTsipRK2YC3L9NKTw@mail.gmail.com>
References: <CAOXjUBxhgB4L7PNdAcYhbFx8LCvW8eJ7Qj1vRbYn=aCfjGroBg@mail.gmail.com>
	<53917B8A.4000204@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:48974 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750910AbaFFJ1w (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Jun 2014 05:27:52 -0400
Received: by mail-lb0-f173.google.com with SMTP id 10so1359300lbg.32
        for <ceph-devel@vger.kernel.org>; Fri, 06 Jun 2014 02:27:50 -0700 (PDT)
In-Reply-To: <53917B8A.4000204@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: ceph-devel@vger.kernel.org

Hi Wido:

   Thanks for your kindness, i checked the codes just now, seems there
were no overload related thing in CRUSH codes. It is a little bit not
consistent with the CRUSH paper.
 So if the %100 utilized OSD is returned, the objects will still be
written on the underlined storage device?

How about the device failure case? All the objects on the failure
device will be replicated to the good ones? once the device is
recoverd, the data will be replicated back?

Best Regards
Zou

On Fri, Jun 6, 2014 at 4:27 PM, Wido den Hollander <wido@42on.com> wrote:
> On 06/06/2014 10:14 AM, zou wonder wrote:
>>
>> Hi buddies,
>>
>>    I am doing investigation on Ceph and Swift,and I am newbie to Ceph.
>>
>> I am unclear to the behaviour of the Ceph when there is overload
>> situation.
>> According to the doc, when Ceph do CRUSH, if it find the OSD is overload,
>> it will skip it to select the other OSD. It means if the OSD don't get
>> overloaded
>> the object should be put in this OSD. So how about the original on put on
>> this OSD when it is not get overloaded?
>> Can we read it ? When doing CRUSH , the OSD will be skip.
>>
>
> CRUSH will not take any performance characteristics into account. If a OSD
> is 100% utilized it will still be selected by CRUSH.
>
> Keep in mind however that Block Devices are striped in 4MB chunks and the
> same happens for Objects stored via the RADOS Gateway.
>
>> If my understanding is wrong, please correct me.
>>
>> Best Regards,
>> zou
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
>
> --
> Wido den Hollander
> 42on B.V.
> Ceph trainer and consultant
>
> Phone: +31 (0)20 700 9902
> Skype: contact42on
