From: tsk <aixt2006@gmail.com>
Subject: Re: Document and example for libceph, librbd and librados
Date: Thu, 5 May 2011 11:09:34 +0800
Message-ID: <BANLkTi=i6so2XwLUBceHQfakY5qaJDfpSA@mail.gmail.com>
References: <BANLkTinSe6i7TVY7gsncqxJQ_+p_yTz13A@mail.gmail.com>
	<1304514803.4036.104.camel@wido-laptop.pcextreme.nl>
	<BANLkTi=2kquZH-+SxsPy8MEGAk0nynP5mA@mail.gmail.com>
	<1304523657.4036.110.camel@wido-laptop.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:54459 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752755Ab1EEDJf convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 May 2011 23:09:35 -0400
Received: by wwa36 with SMTP id 36so1882607wwa.1
        for <ceph-devel@vger.kernel.org>; Wed, 04 May 2011 20:09:34 -0700 (PDT)
In-Reply-To: <1304523657.4036.110.camel@wido-laptop.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: ceph-devel@vger.kernel.org

2011/5/4 Wido den Hollander <wido@widodh.nl>:
> Hi,
>
> On Wed, 2011-05-04 at 22:22 +0800, tsk wrote:
>> 2011/5/4 Wido den Hollander <wido@widodh.nl>:
>> > Hi,
>> >
>> > On Wed, 2011-05-04 at 20:36 +0800, tsk wrote:
>> >> Hi folks,
>> >>
>> >> =C2=A0 =C2=A0 =C2=A0Is there any document for libceph, librbd and=
 librados, and where
>> >> could I get some example for them?
>> >
>> > What kind of examples are you looking for? In the Ceph git reposit=
ory
>> > there is:
>> >
>> > * rados.cc (The rados tool)
>> > * testradospp.cpp
>> > * testrbdpp.cpp
>>
>> Thx!
>> I have run over these test code yet, =C2=A0I think they are useful f=
or me.
>>
>> Hmm, Is there any simple application example for these library?
>
> What kind of example are you looking for? I think everything you are
> searching for is in the testradospp/testrbdpp files, those really sho=
w
> what you can do.
>
> Could you explain what you are trying to achieve/write?
>
> Wido

I have an application which is decided to be achieved by ceph, which
is the most suitable. But there are some requirements I don't know how
to satisfy with the ceph libs:

There will be almost 10000 big file, each may be 10G~500G. Kernel
client will not be used, instead, a user space process will handle
read and write requests for each file via using the libs of ceph.
Because this will bypass the kernel VFS, and should get better
performance.

Problem I want to issue:
1.   I need to set size of replicas for each file. e.g 1 replica for A
file, 2 for B file, 3 for C file.etc.
I think I should create several pools, each with a different replica
size. File for different replica size should be drop into the
corresponding pool. Is that workable?

2.   Snapshot should be able to create, delete, list, rollback for each=
 file.
Which APIs should I use in libceph, librbd and librados?

3.   The user space process and the cosd process will run on the same
host. To lower the network utilization, force-feeding will be used. I
guess reading performance may be better when do this, is it right? I
need to confirm this.  How to configure the force-feeding option=EF=BC=9F=
 In
the libs or the CRUSH map?


Thanks very much!
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
