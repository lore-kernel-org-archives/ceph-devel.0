From: Loic Dachary <ldachary@redhat.com>
Subject: Re: v0.80.11 QE validation status
Date: Mon, 16 Nov 2015 22:04:19 +0100
Message-ID: <564A44D3.9020908@redhat.com>
References: <CAMMFjmFP88goDtrMCmrwpkNOR6R45aOaJaa2t0cCKR+Lb_jTBw@mail.gmail.com>
 <CAMMFjmFsBQihi_YNmRQtfAAMzZeTgidH18Z5rKO0kU18oyFoWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:32803 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751935AbbKPVEV (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 16 Nov 2015 16:04:21 -0500
In-Reply-To: <CAMMFjmFsBQihi_YNmRQtfAAMzZeTgidH18Z5rKO0kU18oyFoWw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>, ceph-qa <ceph-qa@ceph.com>, "Development, Ceph" <ceph-devel@vger.kernel.org>, "Weil, Sage" <sage@redhat.com>, "Deza, Alfredo" <adeza@redhat.com>

Hi Yuri,

Thanks for the update :-) Should we mark #11104 as resolved ?

Cheers

On 16/11/2015 19:45, Yuri Weinstein wrote:
> This release QE validation took longer time due to the #11104
> additional fixing/testing and discovered related to it issues ##13794,
> 13622
>
> We agreed to release v0.80.11 based on tests results.
>
> Thx
> YuriW
>
> On Wed, Oct 28, 2015 at 9:04 AM, Yuri Weinstein <yweinste@redhat.com> wrote:
>> Summary of suites executed for this release can be found in
>> http://tracker.ceph.com/issues/11644
>>
>> rados - 1/7th passed
>>
>> rbd - http://tracker.ceph.com/issues/11104
>>
>> rgw - http://tracker.ceph.com/issues/11104
>>
>> fs - http://tracker.ceph.com/issues/11104, http://tracker.ceph.com/issues/13630
>>
>> krbd - http://tracker.ceph.com/issues/13631
>>
>> kcephfs - http://tracker.ceph.com/issues/13631,
>> http://tracker.ceph.com/issues/13630
>>
>> samba - http://tracker.ceph.com/issues/6613 sama as in v0.80.10 was
>> aprroved for release
>>
>> ceph-deploy(ubuntu_) - almost passed, 1 job is still running
>>
>> ceph-deploy(distros) - http://tracker.ceph.com/issues/13367
>>
>> upgrade/dumpling-x (to firefly)(distros) - passed
>>
>> upgrade/firefly(distros) - passed
>>
>> upgrades to giant - deprecated
>>
>> upgrade/firefly-x (to hammer)(distros) -
>> http://tracker.ceph.com/issues/11104,
>> http://tracker.ceph.com/issues/13632
>>
>> powercycle - http://tracker.ceph.com/issues/11104,
>> http://tracker.ceph.com/issues/13631
>>
>> All found problems seem unrelated to the product, however they
>> prevented some tests from running.  In particular #11104 is widespread
>> and has to be fixed (see also http://tracker.ceph.com/issues/13622 as
>> proposed workaround)
>>
>> I suggest we rerunning failed tests after addressing the issues above.
>>
>> Thx
>> YuriW

