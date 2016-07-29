From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: [rgw multisite] sync thread hang
Date: Fri, 29 Jul 2016 13:06:53 -0600
Message-ID: <CALqRxCw9tzzwN5sMetg_6ZcueE1PF=RsjvLHc1CbMfGOf9uNCA@mail.gmail.com>
References: <7BD28126D6935A4498AE6DE60B5D4CAB314C2515@H3CMLB12-EX.srv.huawei-3com.com>
 <179158f3-3d51-343d-9013-1dd8caf3d48c@redhat.com> <b56fe263-756b-1fd2-7f0b-26fb25c8241e@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f44.google.com ([209.85.213.44]:35600 "EHLO
	mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750839AbcG2TG4 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Jul 2016 15:06:56 -0400
Received: by mail-vk0-f44.google.com with SMTP id w127so60886530vkh.2
        for <ceph-devel@vger.kernel.org>; Fri, 29 Jul 2016 12:06:55 -0700 (PDT)
In-Reply-To: <b56fe263-756b-1fd2-7f0b-26fb25c8241e@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Casey Bodley <cbodley@redhat.com>
Cc: Zhangzengran <zhangzengran@h3c.com>, "yehuda@redhat.com" <yehuda@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

By the way, since this won't be fixed in CentOS base's curl package
until RHEL 7.3 / CentOS 7.3 is GA, this is a great example of
something that could be fixed for Ceph users ahead of time within the
CentOS Storage SIG project! They are looking for volunteers.

- Ken

On Fri, Jul 29, 2016 at 12:27 PM, Casey Bodley <cbodley@redhat.com> wro=
te:
> I submitted a bug report: https://bugs.centos.org/view.php?id=3D11242
>
>
>
> On 07/29/2016 09:53 AM, Casey Bodley wrote:
>>
>> Hi, thanks for the details. We have seen that deadlock, and tracked =
it
>> down to a bug in curl_multi_wait() that wasn't fixed until curl v7.3=
1.
>>
>> You can read more about it here:
>> https://bugzilla.redhat.com/show_bug.cgi?id=3D1347904
>> https://bugzilla.redhat.com/show_bug.cgi?id=3D1327142
>>
>> Casey
>>
>> On 07/29/2016 03:17 AM, Zhangzengran wrote:
>>>
>>> Hi Casey:
>>>          My OS is CentOS Linux release 7.2.1511 (Core), libcurl ver=
sion
>>> is 7.29.0-25. (with HAVE_CURL_MULTI_WAIT is TRUE).
>>>
>>> -----------------------
>>> Hi Casey:
>>>          We are testing multisite on v10.2.2, and found that the me=
ta
>>> sync thread blocked when shards reading remote mdlog response(write=
 method
>>> in RGWHTTPManager::signal_thread()),  and the RGWHTTPManager::ReqsT=
hread
>>> also blocked on poll.Are there some kown bugs be fixed already? Tha=
nk you!
>>>
>>> [RGWCloneMetaLogCoroutine]
>>> (gdb) frame
>>> #0  0x00007f6d66abd1cd in write () from /lib64/libpthread.so.0
>>> (gdb) info frame
>>> Stack level 0, frame at 0x7f6c74fe6bb0:
>>>   rip =3D 0x7f6d66abd1cd in write; saved rip 0x7f6d67457b20 called =
by frame
>>> at 0x7f6c74fe6d10  Arglist at 0x7f6c74fe6b98, args:
>>>   Locals at 0x7f6c74fe6b98, Previous frame's sp is 0x7f6c74fe6bb0  =
Saved
>>> registers:
>>>    rip at 0x7f6c74fe6ba8
>>> (gdb) help frame
>>> Select and print a stack frame.
>>> With no argument, print the selected stack frame.  (See also "info
>>> frame").
>>> An argument specifies the frame to select.
>>> It can be a stack frame number or the address of the frame.
>>> With argument, nothing is printed if input is coming from a command=
 file
>>> or a user-defined command.
>>> (gdb) frame 0x7f6c74fe6d10
>>> #1  0x00007f6d67457b20 in RGWHTTPManager::signal_thread() () from
>>> /lib64/librgw.so.2
>>>
>>> [RGWHTTPManager::ReqsThread]
>>> (gdb) thread 153
>>> [Switching to thread 153 (Thread 0x7f6c757ea700 (LWP 10691))]
>>> #0  0x00007f6d660b769d in poll () from /lib64/libc.so.6
>>>
>>> -------------------------------------------------------------------=
------------------------------------------------------------------
>>> =E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=BB=B6=E5=90=
=AB=E6=9C=89=E6=9D=AD=E5=B7=9E=E5=8D=8E=E4=B8=89=E9=80=9A=E4=BF=A1=E6=8A=
=80=E6=9C=AF=E6=9C=89=E9=99=90=E5=85=AC=E5=8F=B8=E7=9A=84=E4=BF=9D=E5=AF=
=86=E4=BF=A1=E6=81=AF=EF=BC=8C=E4=BB=85=E9=99=90=E4=BA=8E=E5=8F=91=E9=80=
=81=E7=BB=99=E4=B8=8A=E9=9D=A2=E5=9C=B0=E5=9D=80=E4=B8=AD=E5=88=97=E5=87=
=BA
>>> =E7=9A=84=E4=B8=AA=E4=BA=BA=E6=88=96=E7=BE=A4=E7=BB=84=E3=80=82=E7=A6=
=81=E6=AD=A2=E4=BB=BB=E4=BD=95=E5=85=B6=E4=BB=96=E4=BA=BA=E4=BB=A5=E4=BB=
=BB=E4=BD=95=E5=BD=A2=E5=BC=8F=E4=BD=BF=E7=94=A8=EF=BC=88=E5=8C=85=E6=8B=
=AC=E4=BD=86=E4=B8=8D=E9=99=90=E4=BA=8E=E5=85=A8=E9=83=A8=E6=88=96=E9=83=
=A8=E5=88=86=E5=9C=B0=E6=B3=84=E9=9C=B2=E3=80=81=E5=A4=8D=E5=88=B6=E3=80=
=81
>>> =E6=88=96=E6=95=A3=E5=8F=91=EF=BC=89=E6=9C=AC=E9=82=AE=E4=BB=B6=E4=B8=
=AD=E7=9A=84=E4=BF=A1=E6=81=AF=E3=80=82=E5=A6=82=E6=9E=9C=E6=82=A8=E9=94=
=99=E6=94=B6=E4=BA=86=E6=9C=AC=E9=82=AE=E4=BB=B6=EF=BC=8C=E8=AF=B7=E6=82=
=A8=E7=AB=8B=E5=8D=B3=E7=94=B5=E8=AF=9D=E6=88=96=E9=82=AE=E4=BB=B6=E9=80=
=9A=E7=9F=A5=E5=8F=91=E4=BB=B6=E4=BA=BA=E5=B9=B6=E5=88=A0=E9=99=A4=E6=9C=
=AC
>>> =E9=82=AE=E4=BB=B6=EF=BC=81
>>> This e-mail and its attachments contain confidential information fr=
om
>>> H3C, which is
>>> intended only for the person or entity whose address is listed abov=
e. Any
>>> use of the
>>> information contained herein in any way (including, but not limited=
 to,
>>> total or partial
>>> disclosure, reproduction, or dissemination) by persons other than t=
he
>>> intended
>>> recipient(s) is prohibited. If you receive this e-mail in error, pl=
ease
>>> notify the sender
>>> by phone or email immediately and delete it!
>>
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
