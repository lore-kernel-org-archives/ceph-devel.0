From: kefu chai <tchaikov@gmail.com>
Subject: Re: how to disable all complier optimizations
Date: Fri, 3 Feb 2017 03:03:57 +0800
Message-ID: <CAJE9aONHy3aJarTQY=Khyyc_cEhtgGu919BU7KcV-F74h3GHJw@mail.gmail.com>
References: <914C48E9796C6046B6424CA69C30AB3B03BBBA@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
 <CACKY0b95F8GJRqG=ZOgvY2Exh6jzJ4YENOO40wfWBBF=LC+VRA@mail.gmail.com> <2097727258.99392049.1486044021323.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f195.google.com ([209.85.217.195]:32795 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751038AbdBBTD6 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Feb 2017 14:03:58 -0500
Received: by mail-ua0-f195.google.com with SMTP id d5so2187418uag.0
        for <ceph-devel@vger.kernel.org>; Thu, 02 Feb 2017 11:03:58 -0800 (PST)
In-Reply-To: <2097727258.99392049.1486044021323.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matt Benjamin <mbenjamin@redhat.com>
Cc: liuchang0812 <liuchang0812@gmail.com>, Ramesh Chander <Ramesh.Chander@sandisk.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Feb 2, 2017 at 10:00 PM, Matt Benjamin <mbenjamin@redhat.com> wrote:
> Hi,
>
> FWIW, I use:
>
>   -DCMAKE_CXX_FLAGS="-O0 -g3 -gdwarf-4" -DCMAKE_C_FLAGS="-O0 -g3 -gdwarf-4"

we always include the ${CMAKE_C_FLAGS} in ${CMAKE_CXX_FLAGS}.

see https://github.com/ceph/ceph/blob/master/src/CMakeLists.txt#L52


>
> Matt
>
> ----- Original Message -----
>> From: "liuchang0812" <liuchang0812@gmail.com>
>> To: "Ramesh Chander" <Ramesh.Chander@sandisk.com>
>> Cc: "ceph-devel" <ceph-devel@vger.kernel.org>
>> Sent: Wednesday, February 1, 2017 12:02:34 PM
>> Subject: Re: how to disable all complier optimizations
>>
>> hi, try this
>>
>> cmake -DCMAKE_BUILD_TYPE=Debug ..
>>
>> 2017-02-01 19:48 GMT+08:00 Ramesh Chander <Ramesh.Chander@sandisk.com>:
>> > I am trying to compile ceph-osd and debug it but keep getting "optimized
>> > out " message for local variables.
>> >
>> > How to I disable compiler optimization for ceph-osd ?
>> >
>> > Thanks in advance.
>> >
>> > -Ramesh
>> >
>> > ________________________________
>> >
>> > PLEASE NOTE: The information contained in this electronic mail message is
>> > intended only for the use of the designated recipient(s) named above. If
>> > the reader of this message is not the intended recipient, you are hereby
>> > notified that you have received this message in error and that any review,
>> > dissemination, distribution, or copying of this message is strictly
>> > prohibited. If you have received this communication in error, please
>> > notify the sender by telephone or e-mail (as shown above) immediately and
>> > destroy any and all copies of this message in your possession (whether
>> > hard copies or electronically stored copies).
>> >
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> --
> Matt Benjamin
> Red Hat, Inc.
> 315 West Huron Street, Suite 140A
> Ann Arbor, Michigan 48103
>
> http://www.redhat.com/en/technologies/storage
>
> tel.  734-821-5101
> fax.  734-769-8938
> cel.  734-216-5309
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Regards
Kefu Chai
