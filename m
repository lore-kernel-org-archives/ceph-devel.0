From: Wido den Hollander <wido@widodh.nl>
Subject: Re: enabling cephx by default
Date: Tue, 18 Sep 2012 17:12:06 +0200
Message-ID: <50588F46.7010907@widodh.nl>
References: <alpine.DEB.2.00.1209111722100.2433@cobra.newdream.net> <2205765.G9jEemHyT3@pc10> <CABYiri-FQfFR9rsJs4o_gbr0N7LWa4_SVGJo_4e5dLuGAXehhA@mail.gmail.com> <CABYiri8-hYEw4aBjB+GbEYDj2btt-qTCeYxU6_DVHWC-tVTNGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:44761 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754489Ab2IRPMJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 18 Sep 2012 11:12:09 -0400
In-Reply-To: <CABYiri8-hYEw4aBjB+GbEYDj2btt-qTCeYxU6_DVHWC-tVTNGQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Korolyov <andrey@xdel.ru>
Cc: Guido Winkelmann <guido-ceph@thisisnotatest.de>, ceph-devel@vger.kernel.org



On 18-09-12 15:54, Andrey Korolyov wrote:
> On Tue, Sep 18, 2012 at 5:34 PM, Andrey Korolyov <andrey@xdel.ru> wrote:
>> On Tue, Sep 18, 2012 at 4:37 PM, Guido Winkelmann
>> <guido-ceph@thisisnotatest.de> wrote:
>>> Am Dienstag, 11. September 2012, 17:25:49 schrieben Sie:
>>>> The next stable release will have cephx authentication enabled by default.
>>>
>>> Hm, that could be a problem for me. I have tried multiple times to get cephx
>>> working in the past, without lasting success. (I cannot recall at the moment
>>> what the problem was the last time around, but it was probably qemu/libvirt.)
>>
>> BTW, libvirt 0.10.x has a broken cephx support somehow. It forms same
>> string for -drive as 0.9x(at least in a log) but failing to pass
>> authentication same moment.
>>
> Please nevermind, I have build incorrect regex for log parsing previously.
> https://www.redhat.com/archives/libvirt-users/2012-September/msg00082.html
>>>

Hmmm, did I break that? With this commit: 
http://www.libvirt.org/git/?p=libvirt.git;a=commitdiff;h=ccb94785007d33365d49dd566e194eb0a022148d

The full code can be found here: 
http://www.libvirt.org/git/?p=libvirt.git;a=blob;f=src/qemu/qemu_command.c;h=94b2919f52d52c14e364aac44fe130e9dbaf97ae;hb=ccb94785007d33365d49dd566e194eb0a022148d#l1733

The commit above only adds a else statement where it adds 
auth_supported=none when disk->username was not set.

Wido

>>> IMHO, the documentation badly needs a high-level overview for cephx (or maybe
>>> I just haven't found it yet); what it does, what dangers it protects you from
>>> and how it achieves that.
>>>
>>>          Guido
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
