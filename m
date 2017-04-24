From: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>
Subject: Re: cephfs issue, get_reply data > preallocated
Date: Mon, 24 Apr 2017 14:57:26 -0400
Message-ID: <CAGbviv+9PPFFYC+7k-r-WVt-dPRSHbbu+E7fS28Q9L_oEMfjgQ@mail.gmail.com>
References: <CAGbvivLexKgh7L5hhLXjWSJiPj-nEwuxC4O3Hefxt5WGWjHpgw@mail.gmail.com>
 <CAOi1vP9LUyuXgj1gOQNLxNsvuQbKqpkGaaZvWU=EnfMVkks8xQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f41.google.com ([209.85.214.41]:35935 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1173860AbdDXS52 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Apr 2017 14:57:28 -0400
Received: by mail-it0-f41.google.com with SMTP id g66so4607404ite.1
        for <ceph-devel@vger.kernel.org>; Mon, 24 Apr 2017 11:57:27 -0700 (PDT)
In-Reply-To: <CAOi1vP9LUyuXgj1gOQNLxNsvuQbKqpkGaaZvWU=EnfMVkks8xQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

We have a directory of debian package files under cephfs and over the
past week or so we've noticed this issue when trying to read some of
the packages from that directory.

Here are some messages from the system logs, they all look like they
come from the same place in the code.

[Thu Apr 20 17:22:34 2017] libceph: get_reply osd11 tid 31399 data
2441216 > preallocated 1720320, skipping
[Mon Apr 24 11:54:09 2017] libceph: get_reply osd42 tid 150169 data
2083124 > preallocated 1048576, skipping


(Also, its Ubuntu 14.04.4, not 16.04.1, but the kernel is 4.9.10 and
ceph is 10.2.5)



On Mon, Apr 24, 2017 at 2:48 PM, Ilya Dryomov <idryomov@gmail.com> wrote:
> On Mon, Apr 24, 2017 at 5:51 PM, Wyllys Ingersoll
> <wyllys.ingersoll@keepertech.com> wrote:
>> Ubuntu 16.04.1
>> Ceph 10.2.5
>> Linux 4.9.10 kernel
>>
>> We are having problems accessing some files in cephfs, the process
>> reading the files become hung when trying to read them (md5sum, for
>> example).  When these hangups occur, there are messages in the system
>> logs that look like this:
>>
>> "libceph: get_reply osd6 tid 55 data 1305852 > preallocated 1048576, skipping"
>>
>> The cluster shows healthy status and all OSD are reporting as up/up.
>>
>> Wondering if our hanging read issues are related to the messages being
>> reported, they seem to be since we only see the messages once we
>> encounter the issue reading the files.
>
> Definitely -- this message is printed when the reply is dropped on the
> floor.  Can you tell us more about these files and/or provide a sample
> of these messages?
>
> Thanks,
>
>                 Ilya
