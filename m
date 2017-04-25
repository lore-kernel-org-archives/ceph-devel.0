From: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>
Subject: Re: cephfs issue, get_reply data > preallocated
Date: Mon, 24 Apr 2017 23:19:16 -0400
Message-ID: <CAGbvivK1VPoVCFNZALpdON+RxvMwpd_G8uFU3wWDs9k1wpCirw@mail.gmail.com>
References: <CAGbvivLexKgh7L5hhLXjWSJiPj-nEwuxC4O3Hefxt5WGWjHpgw@mail.gmail.com>
 <CAAM7YAkdQzoX9=KodrGfcyCZFxbefw741XoPCKp_mhPFcE82jA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f174.google.com ([209.85.223.174]:33367 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S980306AbdDYDTS (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Apr 2017 23:19:18 -0400
Received: by mail-io0-f174.google.com with SMTP id k87so208910182ioi.0
        for <ceph-devel@vger.kernel.org>; Mon, 24 Apr 2017 20:19:17 -0700 (PDT)
In-Reply-To: <CAAM7YAkdQzoX9=KodrGfcyCZFxbefw741XoPCKp_mhPFcE82jA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <ukernel@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Thanks!  We updated to a 4.9.21 kernel earlier and the problem has not
been seen since then.


On Mon, Apr 24, 2017 at 9:51 PM, Yan, Zheng <ukernel@gmail.com> wrote:
> On Mon, Apr 24, 2017 at 11:51 PM, Wyllys Ingersoll
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
> http://tracker.ceph.com/issues/19189. the fix has been merged into 4.9.14 kernel
>
> Regards
> Yan, Zheng
>
>>
>> Wyllys Ingersoll
>> Keeper Technology, LLC
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
