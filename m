From: Loic Dachary <loic@dachary.org>
Subject: Re: jewel 10.2.4 freeze
Date: Tue, 25 Oct 2016 12:34:15 +0200
Message-ID: <580F3527.9070803@dachary.org>
References: <580E1C53.6060503@dachary.org> <87funlerf5.fsf@suse.com>
 <CABo9giRJpEcMJjLeAHWivJGXYtpsTnN72Nwvej0CoMtRvGYkQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:48222 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S941505AbcJYKeU (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Oct 2016 06:34:20 -0400
In-Reply-To: <CABo9giRJpEcMJjLeAHWivJGXYtpsTnN72Nwvej0CoMtRvGYkQg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Orit Wasserman <owasserm@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Orit,

Created http://tracker.ceph.com/issues/17693 to track https://github.com/ceph/ceph/pull/11626 and marked it urgent. We'll wait for it to be merged.

Cheers

On 24/10/2016 22:21, Orit Wasserman wrote:
> Hi,
> Will it be possible to include https://github.com/ceph/ceph/pull/11626 ?
> 
> Orit
> 
> On Mon, Oct 24, 2016 at 4:46 PM, Abhishek L <abhishek@suse.com> wrote:
>>
>> Loic Dachary writes:
>>
>>> Hi Abhishek,
>>>
>>> If we were to freeze jewel 10.2.4 today it would have 115 backports[0]. Do you think it we should stop merging new backports and prepare for the release ? If so, I'll ask the lead of each component to make sure nothing is missing from their point of view.
>>
>> Yes, lets start getting the ack from the leads
>>>
>>> You can find the progress of the jewel 10.2.4 release in the ttp://tracker.ceph.com/issues/17487.
>>>
>>> Cheers
>>>
>>> [0] issues backported and merged in jewel 10.2.4 http://tracker.ceph.com/versions/524
>>>
>>> --
>>> Loïc Dachary, Artisan Logiciel Libre
>>
>>
>> Best,
>> Abhishek
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
