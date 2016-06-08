From: Blair Bethwaite <blair.bethwaite@gmail.com>
Subject: Re: un-even data filled on OSDs
Date: Wed, 8 Jun 2016 11:05:21 +1000
Message-ID: <CA+z5DsznXSZQ2TQ9y3D0rj-fU4Yi=8GNOW89ZmwvHkvQada4cg@mail.gmail.com>
References: <CANA9Uk4NH7H4kQjEzeNp26bvar5DRWvnNdPff-wCJDRfb1be_A@mail.gmail.com>
 <alpine.DEB.2.11.1606070830160.6221@cpach.fuggernut.com> <CANA9Uk6YXFpAyp+jUgq7Cc9nRwR4Ha=UO-0nPrEAxy8A_GxGNA@mail.gmail.com>
 <alpine.DEB.2.11.1606070905590.6221@cpach.fuggernut.com> <CANA9Uk7aQrom4HEWJHSUjJeY7ywK8KZ0pmdsoY6dwHf4HhPBWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f49.google.com ([209.85.213.49]:36035 "EHLO
	mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754055AbcFHBFm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Jun 2016 21:05:42 -0400
Received: by mail-vk0-f49.google.com with SMTP id g67so4984025vkb.3
        for <ceph-devel@vger.kernel.org>; Tue, 07 Jun 2016 18:05:42 -0700 (PDT)
In-Reply-To: <CANA9Uk7aQrom4HEWJHSUjJeY7ywK8KZ0pmdsoY6dwHf4HhPBWg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: M Ranga Swami Reddy <swamireddy@gmail.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@lists.ceph.com>

Swami,

Try https://github.com/cernceph/ceph-scripts/blob/master/tools/crush-reweight-by-utilization.py,
that'll work with Firefly and allow you to only tune down weight of a
specific number of overfull OSDs.

Cheers,

On 7 June 2016 at 23:11, M Ranga Swami Reddy <swamireddy@gmail.com> wrote:
> OK, understood...
> To fix the nearfull warn, I am reducing the weight of a specific OSD,
> which filled >85%..
> Is this work-around advisable?
>
> Thanks
> Swami
>
> On Tue, Jun 7, 2016 at 6:37 PM, Sage Weil <sage@newdream.net> wrote:
>> On Tue, 7 Jun 2016, M Ranga Swami Reddy wrote:
>>> Hi Sage,
>>> >Jewel and the latest hammer point release have an improved
>>> >reweight-by-utilization (ceph osd test-reweight-by-utilization ... to dry
>>> > run) to correct this.
>>>
>>> Thank you....But not planning to upgrade the cluster soon.
>>> So, in this case - are there any tunable options will help? like
>>> "crush tunable optimal" or so?
>>> OR any other configuration options change will help?
>>
>> Firefly also has reweight-by-utilization... it's just a bit less friendly
>> than the newer versions.  CRUSH tunables don't generally help here unless
>> you have lots of OSDs that are down+out.
>>
>> Note that firefly is no longer supported.
>>
>> sage
>>
>>
>>>
>>>
>>> Thanks
>>> Swami
>>>
>>>
>>> On Tue, Jun 7, 2016 at 6:00 PM, Sage Weil <sage@newdream.net> wrote:
>>> > On Tue, 7 Jun 2016, M Ranga Swami Reddy wrote:
>>> >> Hello,
>>> >> I have aorund 100 OSDs in my ceph cluster. In this a few OSDs filled
>>> >> with >85% of data and few OSDs filled with ~60%-70% of data.
>>> >>
>>> >> Any reason why the unevenly OSDs filling happned? do I need to any
>>> >> tweaks on configuration to fix the above? Please advise.
>>> >>
>>> >> PS: Ceph version is - 0.80.7
>>> >
>>> > Jewel and the latest hammer point release have an improved
>>> > reweight-by-utilization (ceph osd test-reweight-by-utilization ... to dry
>>> > run) to correct this.
>>> >
>>> > sage
>>> >
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Cheers,
~Blairo
