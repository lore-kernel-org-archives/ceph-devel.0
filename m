From: Dongsheng Yang <dongsheng.yang@easystack.cn>
Subject: Re: RBD volumes for bare-metal hosts
Date: Tue, 12 Jul 2016 15:46:15 +0800
Message-ID: <5784A047.20200@easystack.cn>
References: <CA+H5UW2-RKn6aDfpjT1+hFHyNx7-kX1PoXxSV_sbT9zaCbJ2+w@mail.gmail.com>
 <CAOi1vP_JFBXVEsQxTAkbtGR1WyXdoeev=--xT6gircBff5EAYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mr213139.mail.yeah.net ([223.252.213.139]:37307 "EHLO
	mr213139.mail.yeah.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750779AbcGLHqV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Jul 2016 03:46:21 -0400
In-Reply-To: <CAOi1vP_JFBXVEsQxTAkbtGR1WyXdoeev=--xT6gircBff5EAYw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>, Radoslaw Zarzynski <rzarzynski@mirantis.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "Yan, Zheng" <zyan@redhat.com>, Yunchuan Wen <yunchuan.wen@kylin-cloud.com>



On 07/06/2016 07:41 AM, Ilya Dryomov wrote:
> On Wed, Jul 6, 2016 at 12:16 AM, Radoslaw Zarzynski
> <rzarzynski@mirantis.com> wrote:
>> Hello Guys,
>>
>> I wonder about a method for providing bare-metal hosts with an access
>> to RBD volumes.
>>
>> The most obvious solution is krbd. Unfortunately, it has a substantial
>> feature gap in comparison to librbd [1][2]. exclusive-lock seems to be
>> the basic dependency that should be satisfied to even start thinking
>> about the rest. Is someone working on this feature? What are the plans
>> in general?
> The code for exclusive-lock, object-map and fast-diff is pretty much
> ready.

Hi Ilya,
     Sounds great! But where can I read these code, I did not find it
in https://github.com/ceph/ceph-client. could you give a reference
for it. thanx a lot.

Yang
>   We had a large prerequisite that had to go in before any of
> these and it's been merged into 4.7, so it's now a matter of review and
> more comprehensive testing.  deep-flatten isn't ready, but should
> follow shortly after.
>
> Note that you can disable all of these features dynamically and that
> the image is perfectly usable with none of them enabled.  Unless you
> have clones or discard a lot, in which case object-map can help, the
> I/O path is the same.
>
> No concrete plans for mirroring support yet.
>
> Thanks,
>
>                  Ilya
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

