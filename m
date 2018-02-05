From: yue longguang <yuelongguang@gmail.com>
Subject: Re: [PATCH] libradosstriper: correct the first parameter of rados_striper_trunc
Date: Mon, 5 Feb 2018 12:39:42 +0800
Message-ID: <CAPaK2r-Xv-_QsrzKjP6cFFeqy2+niSFpk2TpQ7ogmbNsLv9kqA@mail.gmail.com>
References: <1517475365-7732-1-git-send-email-yuelongguang@gmail.com>
 <CAPaK2r_iR1MY1d-9+F=APornMDboEcCvmWAiEAtXDsTVmL2FPw@mail.gmail.com> <CADRKj5QqAqqaLjVM9SGiBKwmsuLG0opFWxcVMEyyVid84YdJVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:44288 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752195AbeBEEjn (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 4 Feb 2018 23:39:43 -0500
Received: by mail-oi0-f47.google.com with SMTP id b3so17374918oib.11
        for <ceph-devel@vger.kernel.org>; Sun, 04 Feb 2018 20:39:42 -0800 (PST)
In-Reply-To: <CADRKj5QqAqqaLjVM9SGiBKwmsuLG0opFWxcVMEyyVid84YdJVA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

it is done. please look at https://github.com/ceph/ceph/pull/20301
thanks

On Sat, Feb 3, 2018 at 3:20 AM, Yehuda Sadeh-Weinraub <yehuda@redhat.com> wrote:
> Can you create a pull request for it on github?
>
> Yehuda
>
> On Fri, Feb 2, 2018 at 12:18 AM, yue longguang <yuelongguang@gmail.com> wrote:
>> yehuda, please review my patch. thanks
>>
>> On Thu, Feb 1, 2018 at 4:56 PM, yuelongguang <yuelongguang@gmail.com> wrote:
>>> change the type of first parameter from rados_ioctx_t to rados_striper_t
>>> ---
>>>  src/include/radosstriper/libradosstriper.h | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/src/include/radosstriper/libradosstriper.h b/src/include/radosstriper/libradosstriper.h
>>> index 5aa4a6b..4d552c6 100644
>>> --- a/src/include/radosstriper/libradosstriper.h
>>> +++ b/src/include/radosstriper/libradosstriper.h
>>> @@ -207,7 +207,8 @@ int rados_striper_remove(rados_striper_t striper,
>>>   * @param size the new size of the object in bytes
>>>   * @returns 0 on success, negative error code on failure
>>>   */
>>> -int rados_striper_trunc(rados_ioctx_t io, const char *soid, uint64_t size);
>>> +int rados_striper_trunc(rados_striper_t striper,
>>> +                        const char *soid, uint64_t size);
>>>
>>>  /** @} Synchronous I/O */
>>>
>>> --
>>> 1.8.3.1
>>>
