From: Simon Tian <aixt2006@gmail.com>
Subject: Re: rbd create error with 0.26
Date: Mon, 15 Aug 2011 11:15:31 +0800
Message-ID: <CAFGK4N+idjJCmAPTLBvcGf2czQbbOAoQniHS=+wptsoFOd2ASw@mail.gmail.com>
References: <BANLkTim4GDuiVLaX2khWqRF310VJnSEG4Q@mail.gmail.com>
	<CAFGK4NK9d3egypFZt5qySY-3-RbEiOZBbtOX_MbCdiPB8k34MA@mail.gmail.com>
	<5fd6193b826df34670addab14a78b6c7@hq.newdream.net>
	<CAFGK4N+wDdK13o_Sy+fxRxwZ+mZT+TEUJt3+GhKW8CQRRSE7UQ@mail.gmail.com>
	<CAFGK4NKoNewHP2E76EJxWBSOTPgSKf=5SemjockSGTEj+1u4hA@mail.gmail.com>
	<4E456936.3020800@dreamhost.com>
	<4E456E60.6090808@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:37188 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751685Ab1HODPc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 14 Aug 2011 23:15:32 -0400
Received: by wwf5 with SMTP id 5so4455981wwf.1
        for <ceph-devel@vger.kernel.org>; Sun, 14 Aug 2011 20:15:31 -0700 (PDT)
In-Reply-To: <4E456E60.6090808@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@dreamhost.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Thx very much for your guidance, It's OK now!


2011/8/13 Josh Durgin <josh.durgin@dreamhost.com>:
> On 08/12/2011 10:56 AM, Josh Durgin wrote:
>>
>> (bringing back to the list)
>>
>> On 08/12/2011 12:33 AM, Simon Tian wrote:
>>>
>>> I have done all these:
>>> 1 cosd has permission to write /var/lib/ceph/tmp
>>> 2 The temp partition (/var/lib/ceph/tmp) has the execution permission
>>> ( no noexec mount option )
>>> 3 libcls_rbd.so is found in LD_LIBRARY_PATH or in the path specified
>>> in ceph.conf (osd class dir = /usr/lib64/rados-classes for distros
>>> like RHEL6)
>>>
>>> I am testing on RHEL5.4.
>>>
>>> The error didn't disappear....
>>
>> Could you add 'debug osd = 20' to your ceph.conf, restart your osds,
>> then try again? The osd log should tell us the cause of the error.
>>
>
> On further inspection, the wiki was wrong - LD_LIBRARY_PATH does not affect
> class loading. You probably just need to set 'osd class dir =
> /usr/lib64/rados-classes'.
>
>>> 2011/8/12 Simon Tian<aixt2006@gmail.com>:
>>>>
>>>> # rbd create foo --size 1024
>>>> 2011-08-12 10:13:13.180774 7f4c9a6656f0 librbd: failed to assign a
>>>> block name for image
>>>> create error: Input/output error
>>>>
>>>>
>>>> 2011/8/11 Josh Durgin<josh.durgin@dreamhost.com>:
>>>>>
>>>>> On Thu, 11 Aug 2011 22:49:11 +0800, Simon Tian<aixt2006@gmail.com>
>>>>> wrote:
>>>>>>
>>>>>> Hi folks,
>>>>>>
>>>>>> This assert failure appeared in ceph-0.31 when creating a pool,
>>>>>> could anyone help me?
>>>>>>
>>>>>> Thx
>>>>>> Simon
>>>>>
>>>>> What's the error?
>>>>>
>>>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>
>
