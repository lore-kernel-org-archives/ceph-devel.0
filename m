From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: Document and example for libceph, librbd and librados
Date: Wed, 4 May 2011 10:04:42 -0700
Message-ID: <BANLkTing0jrg3PTQOApd0bNTj+EDZWRZAw@mail.gmail.com>
References: <BANLkTinSe6i7TVY7gsncqxJQ_+p_yTz13A@mail.gmail.com>
	<1304514803.4036.104.camel@wido-laptop.pcextreme.nl>
	<BANLkTi=2kquZH-+SxsPy8MEGAk0nynP5mA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:58469 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754529Ab1EDREn convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 May 2011 13:04:43 -0400
Received: by fxm17 with SMTP id 17so978887fxm.19
        for <ceph-devel@vger.kernel.org>; Wed, 04 May 2011 10:04:42 -0700 (PDT)
In-Reply-To: <BANLkTi=2kquZH-+SxsPy8MEGAk0nynP5mA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: tsk <aixt2006@gmail.com>
Cc: Wido den Hollander <wido@widodh.nl>, ceph-devel@vger.kernel.org

On Wed, May 4, 2011 at 7:22 AM, tsk <aixt2006@gmail.com> wrote:
> 2011/5/4 Wido den Hollander <wido@widodh.nl>:
>> Hi,
>>
>> On Wed, 2011-05-04 at 20:36 +0800, tsk wrote:
>>> Hi folks,
>>>
>>> =A0 =A0 =A0Is there any document for libceph, librbd and librados, =
and where
>>> could I get some example for them?
>>
>> What kind of examples are you looking for? In the Ceph git repositor=
y
>> there is:
>>
>> * rados.cc (The rados tool)
>> * testradospp.cpp
>> * testrbdpp.cpp
>
> Thx!
> I have run over these test code yet, =A0I think they are useful for m=
e.
>
> Hmm, Is there any simple application example for these library?

As Wido commented, testrados.c, client/testceph.c, and testlibrbd.c
are simple examples. All of these are built as standalone applications
and they are pretty simple.

Hope this helps.

Colin
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
