From: Loic Dachary <loic@dachary.org>
Subject: Re: rbd and the next jewel release v10.2.3
Date: Tue, 23 Aug 2016 15:32:20 +0200
Message-ID: <57BC5064.1030109@dachary.org>
References: <57BC0D5F.5050006@dachary.org>
 <CA+aFP1CzY1UFgzUcWnCDAhqKH+p95gkhSZ7k+XhsuStm_y0ZnQ@mail.gmail.com>
 <57BC4BB1.2090803@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:59607 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754577AbcHWNc1 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 23 Aug 2016 09:32:27 -0400
In-Reply-To: <57BC4BB1.2090803@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: dillaman@redhat.com
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Abhishek Varshney <abhishek.varshney@flipkart.com>

The jewel-backport branch is in gitbuilder with the http://tracker.ceph.com/issues/16950 backport https://github.com/ceph/ceph/pull/10827 . I'll wait to hear from you before scheduling a run however.

On 23/08/2016 15:12, Loic Dachary wrote:
> Ok. Let me know when the backport of http://tracker.ceph.com/issues/16950 is ready and I'll schedule tests. If you'd rather do the test yourself, that's also fine with me :-)
> 
> Cheers
> 
> On 23/08/2016 15:06, Jason Dillaman wrote:
>> If at all possible, I would definitely like to see the following
>> included in 10.2.3 since users are hitting it in the field:
>>
>> http://tracker.ceph.com/issues/16950
>>
>> ... and given that would require another RBD test run prior to merge,
>> I would also like to include the following which already have open
>> PRs:
>>
>> https://github.com/ceph/ceph/pull/10791
>> https://github.com/ceph/ceph/pull/10790
>> https://github.com/ceph/ceph/pull/10792
>> https://github.com/ceph/ceph/pull/10646
>> https://github.com/ceph/ceph/pull/10647
>> https://github.com/ceph/ceph/pull/10786
>>
>> I can create a PR for the high priority issue this morning.
>>
>> On Tue, Aug 23, 2016 at 4:46 AM, Loic Dachary <loic@dachary.org> wrote:
>>> Hi Jason,
>>>
>>> The next jewel release as found at https://github.com/ceph/ceph/tree/jewel received (I think :-) enough rbd backports to cut the release. It was more challenging than usual and I'd like to thank you and Mykola for helping with the tricky parts.
>>>
>>> Do you think the jewel branch is ready for QE to start their own round of testing ?
>>>
>>> Cheers
>>>
>>> --
>>> Loïc Dachary, Artisan Logiciel Libre
>>>
>>
>>
>>
> 

-- 
Loïc Dachary, Artisan Logiciel Libre
