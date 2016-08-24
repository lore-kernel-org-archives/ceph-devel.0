From: Thipparapu Vijaykumar <thipparapu.vijaykumar@gmail.com>
Subject: Re: Ceph Upgrade Issue
Date: Wed, 24 Aug 2016 18:36:45 +0530
Message-ID: <CAMDPVRGiW6DcBBkr2WBHJmMREcbNDfHc9PqBKUN0J0XsS5s+CQ@mail.gmail.com>
References: <CAMDPVREGpHRimVhFvZy8VcptZsS2AXdiXvJ9xFbtmyZ5Ca1uOg@mail.gmail.com>
 <1953555259.2912.1471977877142@ox.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:35733 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751119AbcHXNIU (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Aug 2016 09:08:20 -0400
Received: by mail-oi0-f49.google.com with SMTP id 4so21235542oih.2
        for <ceph-devel@vger.kernel.org>; Wed, 24 Aug 2016 06:06:46 -0700 (PDT)
In-Reply-To: <1953555259.2912.1471977877142@ox.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: ceph-devel@vger.kernel.org

Hi Wido,

           Thanks for reply. After building DEB packages from the Ceph
source, could you please tell me  how  to install all those DEB
packages on entire cluster.

Thanks & Regards,
Vijay Kumar.

On Wed, Aug 24, 2016 at 12:14 AM, Wido den Hollander <wido@42on.com> wrote:
>
>> Op 23 augustus 2016 om 18:01 schreef Thipparapu Vijaykumar <thipparapu.vijaykumar@gmail.com>:
>>
>>
>> Hi All,
>>            I've a requirement where my existing ceph cluster need to
>> run with the newly build ceph source with instrumented additional
>> debugs.
>>  Could anyone help me to achieve the above requirement?
>>
>
> Why not build DEB or RPM packages from source and install them? That's usually a easy route to take in this case.
>
> For DEB it's just:
>
> $ dpkg-buildpackage
>
> Wido
>
>>
>> Thanks & Regards,
>> Vijay Kumar.
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
