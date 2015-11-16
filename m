From: Tamil Muthamizhan <tmuthami@redhat.com>
Subject: Re: v0.80.11 QE validation status
Date: Mon, 16 Nov 2015 17:05:39 -0500 (EST)
Message-ID: <1460602234.13742303.1447711539365.JavaMail.zimbra@redhat.com>
References: <CAMMFjmFP88goDtrMCmrwpkNOR6R45aOaJaa2t0cCKR+Lb_jTBw@mail.gmail.com> <CAMMFjmFsBQihi_YNmRQtfAAMzZeTgidH18Z5rKO0kU18oyFoWw@mail.gmail.com> <564A44D3.9020908@redhat.com> <CAMMFjmGtECP2wDP6R9GOHA2DoYuJWSgWJh7h+m5QQd_puiOATg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]:58113 "EHLO
	mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751151AbbKPWFm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Nov 2015 17:05:42 -0500
In-Reply-To: <CAMMFjmGtECP2wDP6R9GOHA2DoYuJWSgWJh7h+m5QQd_puiOATg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>, Loic Dachary <ldachary@redhat.com>
Cc: ceph-qa <ceph-qa@ceph.com>, Ceph Development <ceph-devel@vger.kernel.org>, Sage Weil <sage@redhat.com>, Alfredo Deza <adeza@redhat.com>

Hi Loic and Yuri,

issue 11104 can be resolved only after the stable epel[with Boris Fix] is out and tested in teuthology.

what Warren has currently done is to tweak the install task to work around this issue inorder to clear the test blocker for v0.80.11. It doesnt count as a "real" fix.

Regards,
Tamil

----- Original Message -----
From: "Yuri Weinstein" <yweinste@redhat.com>
To: "Loic Dachary" <ldachary@redhat.com>
Cc: "ceph-qa" <ceph-qa@ceph.com>, "Ceph Development" <ceph-devel@vger.kernel.org>, "Sage Weil" <sage@redhat.com>, "Alfredo Deza" <adeza@redhat.com>
Sent: Monday, November 16, 2015 2:01:42 PM
Subject: Re: v0.80.11 QE validation status

Loic,

I am not actually sure about resolving #11104.

Warren?

Thx
YuriW


On Mon, Nov 16, 2015 at 1:04 PM, Loic Dachary <ldachary@redhat.com> wrote:
> Hi Yuri,
>
> Thanks for the update :-) Should we mark #11104 as resolved ?
>
> Cheers
>
> On 16/11/2015 19:45, Yuri Weinstein wrote:
>> This release QE validation took longer time due to the #11104
>> additional fixing/testing and discovered related to it issues ##13794,
>> 13622
>>
>> We agreed to release v0.80.11 based on tests results.
>>
>> Thx
>> YuriW
>>
>> On Wed, Oct 28, 2015 at 9:04 AM, Yuri Weinstein <yweinste@redhat.com> wrote:
>>> Summary of suites executed for this release can be found in
>>> http://tracker.ceph.com/issues/11644
>>>
>>> rados - 1/7th passed
>>>
>>> rbd - http://tracker.ceph.com/issues/11104
>>>
>>> rgw - http://tracker.ceph.com/issues/11104
>>>
>>> fs - http://tracker.ceph.com/issues/11104, http://tracker.ceph.com/issues/13630
>>>
>>> krbd - http://tracker.ceph.com/issues/13631
>>>
>>> kcephfs - http://tracker.ceph.com/issues/13631,
>>> http://tracker.ceph.com/issues/13630
>>>
>>> samba - http://tracker.ceph.com/issues/6613 sama as in v0.80.10 was
>>> aprroved for release
>>>
>>> ceph-deploy(ubuntu_) - almost passed, 1 job is still running
>>>
>>> ceph-deploy(distros) - http://tracker.ceph.com/issues/13367
>>>
>>> upgrade/dumpling-x (to firefly)(distros) - passed
>>>
>>> upgrade/firefly(distros) - passed
>>>
>>> upgrades to giant - deprecated
>>>
>>> upgrade/firefly-x (to hammer)(distros) -
>>> http://tracker.ceph.com/issues/11104,
>>> http://tracker.ceph.com/issues/13632
>>>
>>> powercycle - http://tracker.ceph.com/issues/11104,
>>> http://tracker.ceph.com/issues/13631
>>>
>>> All found problems seem unrelated to the product, however they
>>> prevented some tests from running.  In particular #11104 is widespread
>>> and has to be fixed (see also http://tracker.ceph.com/issues/13622 as
>>> proposed workaround)
>>>
>>> I suggest we rerunning failed tests after addressing the issues above.
>>>
>>> Thx
>>> YuriW
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
