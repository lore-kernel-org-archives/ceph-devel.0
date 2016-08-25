From: Thipparapu Vijaykumar <thipparapu.vijaykumar@gmail.com>
Subject: Re: Ceph Upgrade Issue
Date: Thu, 25 Aug 2016 18:09:40 +0530
Message-ID: <CAMDPVRE09wciBkknsuGmu+ePiXk-uo5tzmXC62aA-LpjWDdFFw@mail.gmail.com>
References: <CAMDPVREGpHRimVhFvZy8VcptZsS2AXdiXvJ9xFbtmyZ5Ca1uOg@mail.gmail.com>
 <1953555259.2912.1471977877142@ox.pcextreme.nl> <CAMDPVRGiW6DcBBkr2WBHJmMREcbNDfHc9PqBKUN0J0XsS5s+CQ@mail.gmail.com>
 <718776942.3031.1472047231643@ox.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:36180 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759017AbcHYMj4 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Aug 2016 08:39:56 -0400
Received: by mail-oi0-f65.google.com with SMTP id b22so4446783oii.3
        for <ceph-devel@vger.kernel.org>; Thu, 25 Aug 2016 05:39:41 -0700 (PDT)
In-Reply-To: <718776942.3031.1472047231643@ox.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: ceph-devel@vger.kernel.org

Thanks Wido for your help, Now I am able to see my debugs in log files.

Regards,
Vijay kumar.

On Wed, Aug 24, 2016 at 7:30 PM, Wido den Hollander <wido@42on.com> wrote:
>
>> Op 24 augustus 2016 om 15:06 schreef Thipparapu Vijaykumar <thipparapu.vijaykumar@gmail.com>:
>>
>>
>> Hi Wido,
>>
>>            Thanks for reply. After building DEB packages from the Ceph
>> source, could you please tell me  how  to install all those DEB
>> packages on entire cluster.
>>
>
> Just like you do with any other DEB. Copy it to the machines and install it with dpkg.
>
> Wido
>
>> Thanks & Regards,
>> Vijay Kumar.
>>
>> On Wed, Aug 24, 2016 at 12:14 AM, Wido den Hollander <wido@42on.com> wrote:
>> >
>> >> Op 23 augustus 2016 om 18:01 schreef Thipparapu Vijaykumar <thipparapu.vijaykumar@gmail.com>:
>> >>
>> >>
>> >> Hi All,
>> >>            I've a requirement where my existing ceph cluster need to
>> >> run with the newly build ceph source with instrumented additional
>> >> debugs.
>> >>  Could anyone help me to achieve the above requirement?
>> >>
>> >
>> > Why not build DEB or RPM packages from source and install them? That's usually a easy route to take in this case.
>> >
>> > For DEB it's just:
>> >
>> > $ dpkg-buildpackage
>> >
>> > Wido
>> >
>> >>
>> >> Thanks & Regards,
>> >> Vijay Kumar.
>> >> --
>> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> >> the body of a message to majordomo@vger.kernel.org
>> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
