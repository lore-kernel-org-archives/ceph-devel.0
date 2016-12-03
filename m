From: Ning Yao <zay11022@gmail.com>
Subject: Re: Client Message Priority Optimazation
Date: Sat, 3 Dec 2016 17:50:24 +0800
Message-ID: <CALZt5jxFFvxw3QPYCQWsOcRZY_VHZAAbmmyLQ3RU6U5=gQ5pRw@mail.gmail.com>
References: <CALZt5jzdRA8obUCqGeSnS_ZEEY2C77=+i7kc1z_qXJ8MRVPZfA@mail.gmail.com>
 <CANE=7sWb9LNRhEgsoqoM2jwziTCStyyjE==W7nRZ-R=V2o8SNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f175.google.com ([209.85.223.175]:33824 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750828AbcLCJu0 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 3 Dec 2016 04:50:26 -0500
Received: by mail-io0-f175.google.com with SMTP id c21so478840630ioj.1
        for <ceph-devel@vger.kernel.org>; Sat, 03 Dec 2016 01:50:25 -0800 (PST)
In-Reply-To: <CANE=7sWb9LNRhEgsoqoM2jwziTCStyyjE==W7nRZ-R=V2o8SNw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?WGluemUgQ2hpICjkv6Hms70p?= <xmdxcxz@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Yeah, I think you mean different pools with using different osds. But
sometimes, we want to deal with different application in the same
architecture or hardwares because of the limitation of company's
budget.

I think we can shift the disscussion to Ceph QoS user stories proposed
by Sage. And consider it at the same time. I think it is quite
complicated based on the current op queue strategy.
Regards
Ning Yao


2016-12-03 17:41 GMT+08:00 Xinze Chi (=E4=BF=A1=E6=B3=BD) <xmdxcxz@gmail.co=
m>:
> Creating special pool for OLAP looks more simple to me.
>
> Because there are several queue in osd. It may be hard to process
> in-flight op based on priority.   I think it is hard to achieve what
> you need based on priority.
>
> 2016-12-03 17:21 GMT+08:00 Ning Yao <zay11022@gmail.com>:
>> Hi, all
>>
>> Currently,  we can modify osd_client_op_priority to assign different
>> clients' ops with different priority such like we can assign high
>> priority for OLTP and assign low priority for OLAP. However, there are
>> some consideration as below:
>>
>> 1) it seems OLTP's client op still can be blocked by OLAP's sub_ops
>> since sub_ops use the CEPH_MSG_PRIO_DEFAULT.  So should we consider
>> sub_op should inherit the message's priority from client Ops (if
>> client ops do not give priority  explicitly, use CEPH_MSG_PRIO_DEFAULT
>> by default), does this make sense?
>>
>> 2) secondly, reply message is assigned with
>> priority(CEPH_MSG_PRIO_HIGH), but there is no restriction for client
>> Ops' priority (use can set 210), which will lead to blocked for reply
>> message. So should we think change those kind of message to highest
>> priority(CEPH_MSG_PRIO_HIGHEST). Currently, it seems no ops use
>> CEPH_MSG_PRIO_HIGHEST.
>>
>> 3) I think the kick recovery ops should inherit the client ops priority
>>
>> 4) Is that possible to add test cases to verify whether it works
>> properly as expected in ceph-qa-suite as Sam mentioned before? Any
>> guidelines?
>>
>>
>> Regards
>> Ning Yao
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Regards,
> Xinze Chi
