From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: how to debug slow rbd block device
Date: Wed, 23 May 2012 06:47:11 -0500
Message-ID: <4FBCCE3F.5080304@inktank.com>
References: <4FBB8A5B.9010500@profihost.ag> <B141A2FBE87F4859AF931D71A339468E@inktank.com> <4FBBEBC8.1000205@profihost.ag> <1C70F3FB753C4AEC97247E04FAE3C733@inktank.com> <4FBBF74C.9020608@profihost.ag> <45F1742481D84E7A90951816DB23609F@inktank.com> <4FBBFE7B.4060406@profihost.ag> <65E9589544C4489F93761035433ADC01@inktank.com> <4FBC811F.5060004@profihost.ag> <4FBC83F3.7070400@inktank.com> <CABYiri8LESPay495HX2s03nL0drOKqWgnXDQW3K71CQJ4MzuzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:63997 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933479Ab2EWLrN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 May 2012 07:47:13 -0400
Received: by yhmm54 with SMTP id m54so6434590yhm.19
        for <ceph-devel@vger.kernel.org>; Wed, 23 May 2012 04:47:13 -0700 (PDT)
In-Reply-To: <CABYiri8LESPay495HX2s03nL0drOKqWgnXDQW3K71CQJ4MzuzQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Korolyov <andrey@xdel.ru>
Cc: ceph-devel@vger.kernel.org

On 5/23/12 2:22 AM, Andrey Korolyov wrote:
> Hi,
>
> For Stefan:
>
> Increasing socket memory gave me about some percents on fio tests
> inside VM(I have measured
> 'max-iops-until-ceph-throws-message-about-delayed-write' parameter).
> What is more important, osd process, if possible, should be pinned to
> dedicated core or two, and all other processes should not use this
> core(you may do it via cg or manually), because even one four-core
> non-pinned VM process during test causes a drop of osd` throughput
> almost twice, same for any other heavy process on the host.
Very interesting!  Thanks for sharing.

> net.core.rmem_max =3D 16777216
> net.core.wmem_max =3D 16777216
> net.ipv4.tcp_rmem =3D 4096 87380 16777216
> net.ipv4.tcp_wmem =3D 4096 65536 16777216
>
>
>
> On Wed, May 23, 2012 at 10:30 AM, Josh Durgin<josh.durgin@inktank.com=
>  wrote:
>> On 05/22/2012 11:18 PM, Stefan Priebe - Profihost AG wrote:
>>> Hi,
>>>
>>>>> So try enabling RBD writeback caching =E2=80=94 see http://marc.i=
nfo
>>>>> /?l=3Dceph-devel&m=3D133758599712768&w=3D2
>>>>> will test tomorrow. Thanks.
>>> Can we path this to the qemu-drive option?
>>
>> Yup, see http://article.gmane.org/gmane.comp.file-systems.ceph.devel=
/6400
>>
>> The normal qemu cache=3Dwriteback/writethrough/none option will work=
 in qemu
>> 1.2.
>>
>> Josh
> By the way, is it possible to flush cache outside? I may need that fo=
r
> VM live migration and such hook will be helpful.
>
>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
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
