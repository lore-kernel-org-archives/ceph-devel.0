From: Michal Jarzabek <stiopa@gmail.com>
Subject: Re: make check, src/test/ceph-disk.sh fails on Mint
Date: Sun, 17 May 2015 10:51:52 +0100
Message-ID: <CAEFDAA7KvNs-kvh950WFu4V6=_EVy81WZLD5PLCqz5Hi+ur1DA@mail.gmail.com>
References: <CAEFDAA6rAJeS80+Qrg=orzug++YWmGee31KYu1=pLy2s3HDYiQ@mail.gmail.com>
	<5557B713.70905@redhat.com>
	<CAEFDAA57-DJXu6Co5yLb=rienFbc6wm9HmachwGu5wpO=eo70A@mail.gmail.com>
	<55585164.20500@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:38192 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752596AbbEQJvx convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 17 May 2015 05:51:53 -0400
Received: by wicnf17 with SMTP id nf17so38572125wic.1
        for <ceph-devel@vger.kernel.org>; Sun, 17 May 2015 02:51:52 -0700 (PDT)
In-Reply-To: <55585164.20500@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: ceph-devel@vger.kernel.org

Thanks Loic, I'll try to add it to ceph_detect_init.

Thanks,
Michal

On Sun, May 17, 2015 at 9:29 AM, Loic Dachary <loic@dachary.org> wrote:
> Hi,
>
> On 17/05/2015 00:07, Michal Jarzabek wrote:
>> Well, I do run it on Linux Mint, but rest of the tests passes withou=
t
>> any problems. So I was wondering if there was any simple way to fix
>> this one as well.
>
> Yes, there is :-) A few weeks ago ceph-disk would blindly assume sysv=
init when a platform is unknown. Now you can add Linux Mint at https://=
github.com/ceph/ceph/tree/master/src/ceph-detect-init/ceph_detect_init =
so that the proper init system is detected.
>
> If you want Linux Mint to be treated the same as another distribution=
 you can do that at:
>
> https://github.com/ceph/ceph/blob/master/src/ceph-detect-init/ceph_de=
tect_init/__init__.py#L69
>
> which is probably the simplest.
>
> Cheers
>
>>
>> On Sat, May 16, 2015 at 10:30 PM, David Zafman <dzafman@redhat.com> =
wrote:
>>>
>>> Is something really broken?  Or are you just on an unsupported plat=
form?
>>>
>>> David
>>>
>>>
>>> On 5/16/15 8:49 AM, Michal Jarzabek wrote:
>>>>
>>>> ceph_detect_init.exc.UnsupportedPlatform: Platform is not supporte=
d.:
>>>
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
