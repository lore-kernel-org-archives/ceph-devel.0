From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: rbd and the next jewel release v10.2.3
Date: Tue, 23 Aug 2016 09:32:00 -0400
Message-ID: <CA+aFP1Bfm3KpvGigaht=W=6yjBg0saBfLxMDv=BzB0KXMsEyjQ@mail.gmail.com>
References: <57BC0D5F.5050006@dachary.org> <CA+aFP1CzY1UFgzUcWnCDAhqKH+p95gkhSZ7k+XhsuStm_y0ZnQ@mail.gmail.com>
 <57BC4BB1.2090803@dachary.org>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:33284 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756416AbcHWNcZ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 23 Aug 2016 09:32:25 -0400
Received: by mail-pf0-f174.google.com with SMTP id y134so43910549pfg.0
        for <ceph-devel@vger.kernel.org>; Tue, 23 Aug 2016 06:32:01 -0700 (PDT)
In-Reply-To: <57BC4BB1.2090803@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Abhishek Varshney <abhishek.varshney@flipkart.com>

The PR is available now [1].  I can build a test branch, run the
tests, and email you with a +1 if that works better timezone-wise.

[1] https://github.com/ceph/ceph/pull/10827

On Tue, Aug 23, 2016 at 9:12 AM, Loic Dachary <loic@dachary.org> wrote:
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
> --
> Loïc Dachary, Artisan Logiciel Libre



-- 
Jason
