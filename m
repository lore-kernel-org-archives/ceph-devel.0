From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: Compiling for FreeBSD
Date: Thu, 3 Dec 2015 08:27:12 +0800
Message-ID: <CAAM7YA=Q6gbBbN92a9KigAXw4e_SrshQ6Q8mC1Xff+vxQQkrKw@mail.gmail.com>
References: <565B3999.3050302@digiware.nl>
	<CACJqLyaSTqKjAQf1Nb8UE00SrF0y1fskYhExmWd3vbCvNrFBkA@mail.gmail.com>
	<565B4A7F.60301@digiware.nl>
	<CAAM7YAmmOwfyiB1jFfGLz4fDxPxHRPQQNk80qEq2-RqFiHH-3g@mail.gmail.com>
	<20151130065812.GA20205@gmail.com>
	<alpine.DEB.2.00.1511300518210.19170@cobra.newdream.net>
	<565D7FA8.3010301@digiware.nl>
	<alpine.DEB.2.00.1512010529280.19170@cobra.newdream.net>
	<565DA3B5.1070608@digiware.nl>
	<alpine.DEB.2.00.1512010634510.19170@cobra.newdream.net>
	<565DC9D4.7060701@digiware.nl>
	<CAOtMX2jWDOLqmjY=S9PorKeaHDgTx5WyMo8jiV3LxOS4K67dMg@mail.gmail.com>
	<565DE234.6070505@digiware.nl>
	<CAOtMX2j5xJBnYoNdxTGGQFz-fTVX2xQka2NuyUZuOPpsft6HuA@mail.gmail.com>
	<alpine.DEB.2.00.1512011034550.19170@cobra.newdream.net>
	<565DEA60.7010608@digiware.nl>
	<CAAM7YAmzq3a_kqXE2ZgK_fp4i6QduY49aXqiWVNK3F59iZUFRA@mail.gmail.com>
	<565F5A03.7020401@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f47.google.com ([209.85.215.47]:35851 "EHLO
	mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756434AbbLCA1O (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Dec 2015 19:27:14 -0500
Received: by lfs39 with SMTP id 39so68852080lfs.3
        for <ceph-devel@vger.kernel.org>; Wed, 02 Dec 2015 16:27:13 -0800 (PST)
In-Reply-To: <565F5A03.7020401@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Sage Weil <sage@newdream.net>, Alan Somers <asomers@freebsd.org>, Mykola Golub <mgolub@mirantis.com>, Haomai Wang <haomai@xsky.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Dec 3, 2015 at 4:52 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
> On 2-12-2015 15:13, Yan, Zheng wrote:
>> see https://github.com/ceph/ceph/pull/6770. The code can be compiled
>> on FreeBSD/OSX, most client programs can connect to ceph servers on
>> Linux.
>
> Hi,
>
> I do like some of the inline compiler tests.
>
> I guess that the way the errno's are done like the other OS's have done
> as well?
> I'd normally solve this with a static array, and just index it.
> But perhaps the compiler is smart enough to do the same.
>
>
> I see that you have disabled uuid?
> Might I ask why?

not disable. Currently ceph uses boost uuid implementation. so no need
to link to libuuid.

>
> I Suggest you have a look at the issue Alan brought up.
> Which is a possible fix for doing it the other way around:
>         Linux clients on a FreeBSD "cluster"
> But as Sage suggest: Could be very well solved by fixed brougt in for AIX.
>
> --WjW
>
>> Regards
>> Yan. Zheng
>>
>> On Wed, Dec 2, 2015 at 2:43 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>>> On 1-12-2015 19:36, Sage Weil wrote:
>>>>
>>>> On Tue, 1 Dec 2015, Alan Somers wrote:
>>>>>
>>>>> On Tue, Dec 1, 2015 at 11:08 AM, Willem Jan Withagen <wjw@digiware.nl>
>>>>> wrote:
>>>>>>
>>>>>> On 1-12-2015 18:22, Alan Somers wrote:
>>>>>>>
>>>>>>>
>>>>>>> I did some work porting Ceph to FreeBSD, but got distracted and
>>>>>>> stopped about two years ago.  You may find this port useful, though it
>>>>>>> will probably need to be updated:
>>>>>>>
>>>>>>> https://people.freebsd.org/~asomers/ports/net/ceph/
>>>>>>
>>>>>>
>>>>>>
>>>>>> I'll chcek that one as well...
>>>>>>
>>>>>>> Also, there's one major outstanding issue that I know of.  It breaks
>>>>>>> interoperability between FreeBSD and Linux Ceph nodes.  I posted a
>>>>>>> patch to fix it, but it doesn't look like it's been merged yet.
>>>>>>> http://tracker.ceph.com/issues/6636
>>>>>>
>>>>>>
>>>>>>
>>>>>> In the issues I find:
>>>>>> ====
>>>>>> Updated by Sage Weil almost 2 years ago
>>>>>>
>>>>>>      Status changed from New to Verified
>>>>>> Updated by Sage Weil almost 2 years ago
>>>>>>
>>>>>>      Assignee set to Noah Watkins
>>>>>> ====
>>>>>>
>>>>>> Probably left at that point because there was no presure to actually
>>>>>> commit?
>>>>>>
>>>>>> --WjW
>>>>>
>>>>>
>>>>> It looks like Sage reviewed the change, but had some comments that
>>>>> were mostly style-related.  Neither Noah nor I actually got around to
>>>>> implementing Sage's suggestions.
>>>>>
>>>>> https://github.com/ceph/ceph/pull/828
>>>>
>>>>
>>>> The uuid transition to boost::uuid has happened since then (a few months
>>>> back) and I believe Rohan's AIX and Solaris ports for librados (that just
>>>> merged) included a fix for the sockaddr_storage issue:
>>>>
>>>>         https://github.com/ceph/ceph/blob/master/src/msg/msg_types.h#L180
>>>>
>>>> and also
>>>>
>>>>         https://github.com/ceph/ceph/blob/master/src/msg/msg_types.h#L160
>>>
>>>
>>>
>>> Would be nice to actually find that this works for FreeBSD as well.
>>> But I'm putting this on the watch-list, once I get there.
>>>
>>> --WjW
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
