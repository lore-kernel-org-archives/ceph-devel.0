From: Dongsheng Yang <dongsheng.yang@easystack.cn>
Subject: Re: RBD volumes for bare-metal hosts
Date: Tue, 12 Jul 2016 16:03:04 +0800
Message-ID: <5784A438.2030108@easystack.cn>
References: <CA+H5UW2-RKn6aDfpjT1+hFHyNx7-kX1PoXxSV_sbT9zaCbJ2+w@mail.gmail.com>
 <CAOi1vP_JFBXVEsQxTAkbtGR1WyXdoeev=--xT6gircBff5EAYw@mail.gmail.com>
 <5784A047.20200@easystack.cn>
 <CAOi1vP8Kv+m4Yza5P7iyjBG+SpcV82koai1HJpui+ULy5Op9qA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m199-177.yeah.net ([123.58.177.199]:11322 "EHLO
	m199-177.yeah.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750853AbcGLIFC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Jul 2016 04:05:02 -0400
In-Reply-To: <CAOi1vP8Kv+m4Yza5P7iyjBG+SpcV82koai1HJpui+ULy5Op9qA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Radoslaw Zarzynski <rzarzynski@mirantis.com>, Ceph Development <ceph-devel@vger.kernel.org>, "Yan, Zheng" <zyan@redhat.com>, Yunchuan Wen <yunchuan.wen@kylin-cloud.com>



On 07/12/2016 04:00 PM, Ilya Dryomov wrote:
> On Tue, Jul 12, 2016 at 9:46 AM, Dongsheng Yang
> <dongsheng.yang@easystack.cn> wrote:
>>
>> On 07/06/2016 07:41 AM, Ilya Dryomov wrote:
>>> On Wed, Jul 6, 2016 at 12:16 AM, Radoslaw Zarzynski
>>> <rzarzynski@mirantis.com> wrote:
>>>> Hello Guys,
>>>>
>>>> I wonder about a method for providing bare-metal hosts with an access
>>>> to RBD volumes.
>>>>
>>>> The most obvious solution is krbd. Unfortunately, it has a substantial
>>>> feature gap in comparison to librbd [1][2]. exclusive-lock seems to be
>>>> the basic dependency that should be satisfied to even start thinking
>>>> about the rest. Is someone working on this feature? What are the plans
>>>> in general?
>>> The code for exclusive-lock, object-map and fast-diff is pretty much
>>> ready.
>>
>> Hi Ilya,
>>      Sounds great! But where can I read these code, I did not find it
>> in https://github.com/ceph/ceph-client. could you give a reference
>> for it. thanx a lot.
> It's not a final version - there are some bugs and sharp edges in
> there.  But if you just want to take look:
>
>      https://github.com/fullerdj/ceph-client/commits/wip-djf-osdc

Got it. Thanx
>
> Thanks,
>
>                  Ilya
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

