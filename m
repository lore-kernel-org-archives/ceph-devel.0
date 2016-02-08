From: Gaurav Bafna <bafnag@gmail.com>
Subject: Re: PG States Diagram on Ceph Website is unreadable due to very less resolution
Date: Mon, 8 Feb 2016 12:27:57 +0530
Message-ID: <CAPg135amULGFt84v3fE5ULYk4jPZgHCpt3oN7KVt-ddsZfSmuA@mail.gmail.com>
References: <CAPg135YZaPxaWHVw0hLGuTc-crdPubR76WjTg2Q7sKQU2oi0TA@mail.gmail.com>
	<56B50A50.7040805@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:33980 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751402AbcBHG57 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 8 Feb 2016 01:57:59 -0500
Received: by mail-wm0-f46.google.com with SMTP id 128so141971838wmz.1
        for <ceph-devel@vger.kernel.org>; Sun, 07 Feb 2016 22:57:58 -0800 (PST)
In-Reply-To: <56B50A50.7040805@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Zafman <dzafman@redhat.com>
Cc: ceph-devel@vger.kernel.org

Hi David,

Yeah , it worked :) .

Thanks a lot for your help.

Thanks
Gaurav

On Sat, Feb 6, 2016 at 2:17 AM, David Zafman <dzafman@redhat.com> wrote:
>
> Gaurav,
>
> From git checkout of hammer
>
> cat src/osd/PG.h src/osd/PG.cc | doc/scripts/gen_state_diagram.py >
> /tmp/hammer.dot
>
> I installed "xdot" on my Linux box to view it.
>
> David
>
>
>
> On 2/5/16 5:00 AM, Gaurav Bafna wrote:
>>
>> Hi Cephers,
>>
>> The PG State Diagram on Ceph website is of very low resolution (33
>> KB). It is not at all clear . Does anybody has a higher resolution
>> picture of PG States ?
>>
>> Link :
>> http://docs.ceph.com/docs/hammer/_images/graphviz-4358d0071ed1241baaed0a5450debde6eb61e0e3.png
>>
>>
>>
>> Thanks & Regards
>> Gaurav Bafna
>> 9540631400
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>



-- 
Gaurav Bafna
9540631400
