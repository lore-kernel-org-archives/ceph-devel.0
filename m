From: Loic Dachary <loic@dachary.org>
Subject: Re: rgw and the next jewel release v10.2.4
Date: Thu, 27 Oct 2016 21:44:11 +0200
Message-ID: <5812590B.8050801@dachary.org>
References: <5811C853.1070706@dachary.org>
 <CABo9giSD3B=83d7yRyJLX7zg1NTrELFM4jK+uNLNzZ0sgMmSOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:51744 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751152AbcJ0ToR (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Oct 2016 15:44:17 -0400
In-Reply-To: <CABo9giSD3B=83d7yRyJLX7zg1NTrELFM4jK+uNLNzZ0sgMmSOQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Orit Wasserman <owasserm@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>



On 27/10/2016 20:33, Orit Wasserman wrote:
> Hi Loic,
> We still need :
> https://github.com/ceph/ceph/pull/11472

Merged.

> https://github.com/ceph/ceph/pull/11669 (needs teuthology run)

Will run it first thing tomorrow morning.
> 
> Nice to have:
> http://tracker.ceph.com/issues/17372
> http://tracker.ceph.com/issues/17571

Thanks for the quick feedback !

Cheers

> 
> Thanks,
> Orit
> 
> On Thu, Oct 27, 2016 at 11:26 AM, Loic Dachary <loic@dachary.org> wrote:
>> Hi Yehuda,
>>
>> The next jewel release as found at https://github.com/ceph/ceph/tree/jewel passed the rgw suite (http://tracker.ceph.com/issues/17487#note-18). Do you think the jewel branch is ready for QE to start their own round of testing ?
>>
>> Cheers
>>
>> --
>> Loïc Dachary, Artisan Logiciel Libre
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
Loïc Dachary, Artisan Logiciel Libre
