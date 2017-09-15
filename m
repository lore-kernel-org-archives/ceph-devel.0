From: Abhishek Lekshmanan <abhishek@suse.com>
Subject: Re: Status of luminous v12.2.1 integration branch
Date: Fri, 15 Sep 2017 14:04:57 +0200
Message-ID: <877ex0f9qu.fsf@suse.com>
References: <CAMMFjmHk-YfW6-qnJmgQOWj-cdRO86ggHK-2y27GN1u-Ao8X-w@mail.gmail.com> <CA+2bHPZ9fjx2Z8uUc-Fo+TsO-m9+PspG2T=NStGdo51FyL-eAQ@mail.gmail.com> <CA+2bHPboXJXgzz-aHkWYFqB1EH-tzDHShXSwbkn8EAeogggUjg@mail.gmail.com> <87inglfqsp.fsf@suse.com> <87fubofiji.fsf@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:44424 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751184AbdIOME7 (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Fri, 15 Sep 2017 08:04:59 -0400
In-Reply-To: <87fubofiji.fsf@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Patrick Donnelly <pdonnell@redhat.com>, Yuri Weinstein <yweinste@redhat.com>
Cc: "Development, Ceph" <ceph-devel@vger.kernel.org>, "Weil, Sage" <sweil@redhat.com>, "Durgin, Josh" <jdurgin@redhat.com>, "Sadeh-Weinraub, Yehuda" <yehuda@redhat.com>, John Spray <jspray@redhat.com>, "gmeno@redhat.com" <gregory.meno@inktank.com>

Abhishek Lekshmanan <abhishek@suse.com> writes:

> Abhishek Lekshmanan <abhishek@suse.com> writes:
>
>> Patrick Donnelly <pdonnell@redhat.com> writes:
>>
>>> On Wed, Sep 13, 2017 at 8:49 AM, Patrick Donnelly <pdonnell@redhat.com> wrote:
>>>> On Wed, Sep 13, 2017 at 8:40 AM, Yuri Weinstein <yweinste@redhat.com> wrote:
>>>>> This email is an attempt to make sure that all are clear on luminous
>>>>> v12.2.1 release status.
>>>>>
>>>>> Dev leads - what is left before we can start QE validation?
>>>>
>>>> To be merged into master today and then backported:
>>>> http://tracker.ceph.com/issues/21378
>>>> Luminous backport: http://tracker.ceph.com/issues/21357
>>>> To be merged into master today and then backported:
>>>> http://tracker.ceph.com/issues/20594
>>>
>>> Final list of CephFS backports needed for 12.2.1:
>>>
>>> http://tracker.ceph.com/issues/21323
>>> http://tracker.ceph.com/issues/21114
>>> http://tracker.ceph.com/issues/21107
>>> http://tracker.ceph.com/issues/21357
>>> http://tracker.ceph.com/issues/21322
>>> http://tracker.ceph.com/issues/21384
>>>
>>
>> So scheduled the relevant suites (rgw,rados,fs) at priority 100 right
>> now) for the current PRs targeting Luminous, 
>> http://tracker.ceph.com/issues/21296#note-15
>>
>> if this run goes through, lets merge these PRs to luminous and handover
>> to Yuri
>
> So had failures in many jobs of all the 3 suites due to an ansible
> failure, the fs suite, however, has a few failures in this test
> (tasks.cephfs.test_misc.TestMisc), is anyone aware of prior failures of
> this suite, can be seen in this run for eg.
>
> http://pulpito.ceph.com/abhi-2017-09-14_11:23:49-fs-wip-luminous-2017-09-14-distro-basic-smithi/1632469/
>
> reruns updated at http://tracker.ceph.com/issues/21296 

The cephfs reruns besides the ansible failure failed again at the same
test suite (tasks.cephfs.test_misc) , seen at

http://pulpito.ceph.com/abhi-2017-09-15_08:41:20-fs-wip-luminous-2017-09-14-distro-basic-smithi/

RADOS suite saw a failure at
http://pulpito.ceph.com/abhi-2017-09-15_08:47:22-rados-wip-luminous-2017-09-14-distro-basic-smithi/1635585/

on  (workunit test cephtool/test.sh), other than the same ansible
related env. failures. 


both RGW suite saw a few ansible failures again, but no other
failures, so let us deem these as passed for now? (Yuri also ran another suite
with RGW and these too had only the ansible failures again). In which
case we can merge the staged PRs and handover to Yuri for the final QE.

Sage, Patrick, Yehuda/Orit thoughts?

-- 
Abhishek Lekshmanan
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton,
HRB 21284 (AG Nürnberg)
