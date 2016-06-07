From: M Ranga Swami Reddy <swamireddy@gmail.com>
Subject: Re: un-even data filled on OSDs
Date: Tue, 7 Jun 2016 18:41:32 +0530
Message-ID: <CANA9Uk7aQrom4HEWJHSUjJeY7ywK8KZ0pmdsoY6dwHf4HhPBWg@mail.gmail.com>
References: <CANA9Uk4NH7H4kQjEzeNp26bvar5DRWvnNdPff-wCJDRfb1be_A@mail.gmail.com>
 <alpine.DEB.2.11.1606070830160.6221@cpach.fuggernut.com> <CANA9Uk6YXFpAyp+jUgq7Cc9nRwR4Ha=UO-0nPrEAxy8A_GxGNA@mail.gmail.com>
 <alpine.DEB.2.11.1606070905590.6221@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:36739 "EHLO
	mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932646AbcFGNLd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Jun 2016 09:11:33 -0400
Received: by mail-oi0-f52.google.com with SMTP id p204so79834560oih.3
        for <ceph-devel@vger.kernel.org>; Tue, 07 Jun 2016 06:11:33 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1606070905590.6221@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@lists.ceph.com>

OK, understood...
To fix the nearfull warn, I am reducing the weight of a specific OSD,
which filled >85%..
Is this work-around advisable?

Thanks
Swami

On Tue, Jun 7, 2016 at 6:37 PM, Sage Weil <sage@newdream.net> wrote:
> On Tue, 7 Jun 2016, M Ranga Swami Reddy wrote:
>> Hi Sage,
>> >Jewel and the latest hammer point release have an improved
>> >reweight-by-utilization (ceph osd test-reweight-by-utilization ... to dry
>> > run) to correct this.
>>
>> Thank you....But not planning to upgrade the cluster soon.
>> So, in this case - are there any tunable options will help? like
>> "crush tunable optimal" or so?
>> OR any other configuration options change will help?
>
> Firefly also has reweight-by-utilization... it's just a bit less friendly
> than the newer versions.  CRUSH tunables don't generally help here unless
> you have lots of OSDs that are down+out.
>
> Note that firefly is no longer supported.
>
> sage
>
>
>>
>>
>> Thanks
>> Swami
>>
>>
>> On Tue, Jun 7, 2016 at 6:00 PM, Sage Weil <sage@newdream.net> wrote:
>> > On Tue, 7 Jun 2016, M Ranga Swami Reddy wrote:
>> >> Hello,
>> >> I have aorund 100 OSDs in my ceph cluster. In this a few OSDs filled
>> >> with >85% of data and few OSDs filled with ~60%-70% of data.
>> >>
>> >> Any reason why the unevenly OSDs filling happned? do I need to any
>> >> tweaks on configuration to fix the above? Please advise.
>> >>
>> >> PS: Ceph version is - 0.80.7
>> >
>> > Jewel and the latest hammer point release have an improved
>> > reweight-by-utilization (ceph osd test-reweight-by-utilization ... to dry
>> > run) to correct this.
>> >
>> > sage
>> >
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
