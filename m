From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: cleanup: add override where possible when implementing an
 interface
Date: Fri, 3 Mar 2017 13:10:59 +0100
Message-ID: <d3be8639-a822-f71c-ea85-7d13c6062edb@digiware.nl>
References: <CACKY0b8Xy5JNC-5Y8BcQEW8QDrHq85Qa7=nC9DjB3H+VmbarNQ@mail.gmail.com>
 <alpine.DEB.2.11.1702141410190.7782@piezo.novalocal>
 <CACKY0b_8RB8-SssyRJJ40TjEQ7tyQ4Np0BmXvs8jd-=7Mbhntw@mail.gmail.com>
 <CACKY0b_rTw7ug2K+WD0W-SabpTGc-nudgm9aR6AV8RjMXzrD1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:16541 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751445AbdCCMMg (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 3 Mar 2017 07:12:36 -0500
In-Reply-To: <CACKY0b_rTw7ug2K+WD0W-SabpTGc-nudgm9aR6AV8RjMXzrD1A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: liuchang0812 <liuchang0812@gmail.com>, Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 3-3-2017 12:56, liuchang0812 wrote:
> After long time work, I have finished all jobs. There are a lot of PR,
> please take a look. I guess Willem will be happy after all PR merged,
> a lot of clang warns will be remove.

Looks like relaxed weekend work to go over them, and run the tests.
But already greatly appreciated.

--WjW

> RGW:             [1] https://github.com/ceph/ceph/pull/13586
> MDS:              [2] https://github.com/ceph/ceph/pull/13691
> common/msg: [3] https://github.com/ceph/ceph/pull/13771
> common:        [4] https://github.com/ceph/ceph/pull/13774
> MGR:             [5] https://github.com/ceph/ceph/pull/13772
> test:               [6] https://github.com/ceph/ceph/pull/13773
> librados:         [7] https://github.com/ceph/ceph/pull/13775
> tools:             [8] https://github.com/ceph/ceph/pull/13776
> 
> Thanks
> Chang Liu
> 
> 2017-02-14 22:24 GMT+08:00 liuchang0812 <liuchang0812@gmail.com>:
>> Hi, Sage
>>
>> I have issued a PR: https://github.com/ceph/ceph/pull/13414
>>
>>
>> 2017-02-14 22:11 GMT+08:00 Sage Weil <sage@newdream.net>:
>>> On Tue, 14 Feb 2017, liuchang0812 wrote:
>>>> Hi, Sage and Cephers:
>>>>
>>>> I saw a issue "add override where possible when implementing an
>>>> interface". So I used a LLVM tool called clang-tidy to do it
>>>> automatically. .
>>>>
>>>> I have made a big changes:
>>>>
>>>>       246 files changed, 1305 insertions(+), 1305 deletions(-)
>>>>
>>>> I could build it successfully, should I make a Pull-Request?
>>>
>>> Yeah sure!  If you could break it up by subsystem (rgw, osd, rbd, mds,
>>> everything else) that would help.  Thanks!
>>>
>>>> BTW, I am pleasure to write a simple documentation about this tool if
>>>> we need this.
>>>
>>> Sure!  Something in doc/dev, or even just an email to the list?
>>>
>>> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

