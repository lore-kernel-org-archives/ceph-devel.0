From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: how to debug slow rbd block device
Date: Wed, 23 May 2012 12:54:52 -0700
Message-ID: <4FBD408C.5000504@inktank.com>
References: <4FBB8A5B.9010500@profihost.ag> <B141A2FBE87F4859AF931D71A339468E@inktank.com> <4FBBEBC8.1000205@profihost.ag> <1C70F3FB753C4AEC97247E04FAE3C733@inktank.com> <4FBBF74C.9020608@profihost.ag> <45F1742481D84E7A90951816DB23609F@inktank.com> <4FBBFE7B.4060406@profihost.ag> <65E9589544C4489F93761035433ADC01@inktank.com> <4FBC811F.5060004@profihost.ag> <4FBC83F3.7070400@inktank.com> <4FBC8B41.1020300@profihost.ag> <4FBC8F8F.6060004@inktank.com> <4FBC904A.7090407@profihost.ag> <4FBC92E2.5020807@inktank.com> <CABYiri8PXT9dpCGLE7dn=_PoW8CdLxqZF87OHe=dMXEWxogb_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:43173 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753061Ab2EWTyz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 May 2012 15:54:55 -0400
Received: by pbbrp8 with SMTP id rp8so10336408pbb.19
        for <ceph-devel@vger.kernel.org>; Wed, 23 May 2012 12:54:55 -0700 (PDT)
In-Reply-To: <CABYiri8PXT9dpCGLE7dn=_PoW8CdLxqZF87OHe=dMXEWxogb_w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Korolyov <andrey@xdel.ru>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 05/23/2012 02:03 AM, Andrey Korolyov wrote:
> Hi Josh,
>
> Can you please answer to list on this question? It is important when
> someone wants to build HA KVM cluster on the rbd backend and needs to
> wc cache. Thanks!
>
> On Wed, May 23, 2012 at 10:30 AM, Josh Durgin<josh.durgin@inktank.com=
>  wrote:
>> On 05/22/2012 11:18 PM, Stefan Priebe - Profihost AG wrote:
>>>
>>> Hi,
>>>
>>>>> So try enabling RBD writeback caching =E2=80=94 see http://marc.i=
nfo
>>>>> /?l=3Dceph-devel&m=3D133758599712768&w=3D2
>>>>> will test tomorrow. Thanks.
>>>
>>> Can we path this to the qemu-drive option?
>>
>>
>> Yup, see http://article.gmane.org/gmane.comp.file-systems.ceph.devel=
/6400
>>
>> The normal qemu cache=3Dwriteback/writethrough/none option will work=
 in qemu
>> 1.2.
>>
>> Josh
>
> By the way, is it possible to flush cache outside? I may need that fo=
r
> VM live migration and such hook will be helpful.

Qemu will do that for you in many cases, but it looks like we need to=20
implement bdrv_invalidate_cache to make live migration work.

http://tracker.newdream.net/issues/2467

librbd itself flushes the cache when a snapshot is created or the image=
=20
is closed, but there's no way to trigger it directly right now.

http://tracker.newdream.net/issues/2468
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
