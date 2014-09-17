From: Cheng Wei-Chung <freeze.vicente.cheng@gmail.com>
Subject: Re: is function get_net_marked_down right?
Date: Wed, 17 Sep 2014 13:56:55 +0800
Message-ID: <CABF_e-G8oWjc0KV1M1Fts8aNzdpvhGsHjyLJ-7pS8Pi_BsM4YA@mail.gmail.com>
References: <CABF_e-H+qqq+ig7KDvwwgDbnuwVVwJ_K3hspaCWozaZC8jM9qg@mail.gmail.com>
	<alpine.DEB.2.00.1409162215310.20205@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f50.google.com ([209.85.219.50]:32910 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751205AbaIQF44 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Sep 2014 01:56:56 -0400
Received: by mail-oa0-f50.google.com with SMTP id jd19so723696oac.23
        for <ceph-devel@vger.kernel.org>; Tue, 16 Sep 2014 22:56:55 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1409162215310.20205@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

That will make sense to me.

I think I need trace so deep enough for know it really means next time.

anyway, Thanks!!!

2014-09-17 13:16 GMT+08:00 Sage Weil <sweil@redhat.com>:
> On Wed, 17 Sep 2014, Cheng Wei-Chung wrote:
>> Dear all:
>>
>> I have seen this function few days.
>> OSDMap::Incremental::get_net_marked_down
>>
>> There is something strange I don't know why.
>>
>> why we increase n when we got state and previous state is UP?
>> if (p->second & CEPH_OSD_UP) {
>>       if (previous->is_up(p->first))
>>         n++;  // marked down
>>       else
>>         n--;  // marked up
>> }
>>
>> This function aims to help check whether the osd can be mark down or not, right?
>>
>> For counting the osd that state is down, the above function is
>> counting the osd that state is up?
>>
>> I would like to know there is some minor error or something I don't
>> really understand.
>
> For lame historical reasons the CEPH_OSD_UP flag in the incremental
> *toggles* the up/down state ... it either means the OSD came up or that it
> went down.
>
> sage
>
