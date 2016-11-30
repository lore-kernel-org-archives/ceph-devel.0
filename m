From: Josh Durgin <jdurgin@redhat.com>
Subject: Re: ceph v10.2.4 QE validation status
Date: Wed, 30 Nov 2016 08:35:48 -0800
Message-ID: <36ceb1c8-d947-56f4-9150-2bb989b9dcbe@redhat.com>
References: <CAMMFjmEkMUBCnZFqMr_kcfZgB5jm3CjVNfXpSAXT7ZCwMLQEfg@mail.gmail.com>
 <CAMMFjmGRO7F30WwU8NwMU=t3bEXEhz1G6bwZwqyQJrp7mceZdQ@mail.gmail.com>
 <87r362tr92.fsf@suse.com> <alpine.DEB.2.11.1611231441130.21102@piezo.us.to>
 <87mvgia7if.fsf@suse.com> <87zikh3tj3.fsf@suse.com>
 <2943214e-519d-ced4-6b83-f53119ca4932@redhat.com> <87wpfl3pj5.fsf@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45272 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753106AbcK3Qfu (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 30 Nov 2016 11:35:50 -0500
In-Reply-To: <87wpfl3pj5.fsf@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek L <abhishek@suse.com>
Cc: Sage Weil <sweil@redhat.com>, Gregory Farnum <gfarnum@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, Abhishek Varshney <abhishek.varshney@flipkart.com>, "Dachary, Loic" <ldachary@redhat.com>, "Dachary, Loic" <loic@dachary.org>, "Dillaman, Jason" <dillaman@redhat.com>, Nathan Cutler <ncutler@suse.cz>, Ilya Dryomov <idryomov@gmail.com>, John Spray <jspray@redhat.com>, Yuri Weinstein <yweinste@redhat.com>

On 11/30/2016 08:23 AM, Abhishek L wrote:
>
> Josh Durgin writes:
>
>> On 11/30/2016 06:57 AM, Abhishek L wrote:
>>>
>>> Abhishek L writes:
>>>
>>>> Sage Weil writes:
>>>>
>>>>> On Wed, 23 Nov 2016, Abhishek L wrote:
>>>>>>
>>>>>> Hi Sage, Greg,
>>>>>>
>>>>>>
>>>>>> Yuri Weinstein writes:
>>>>>>
>>>>>>> See updated status - http://tracker.ceph.com/issues/17487#note-32
>>>>>>>
>>>>>>> Outstanding issues:
>>>>>>>
>>>>>>> knfs - http://tracker.ceph.com/issues/16397 (same as in v10.2.3, Greg
>>>>>>> pls review/approve, assumed Approved ?)
>>>>>>>
>>>>>>> upgrade/hammer-x (jewel) - http://tracker.ceph.com/issues/17847 ((Sage
>>>>>>> pls review/approve, seems persistent, but maybe not a showstopper)
>>>>>>>
>>>>>>> upgrade/infernalis-x (jewel) - deprecated (Nathan is still working
>>>>>>> to make it pass, see issues in the tacker summary above)
>>>>>>>
>>>>>>> Sage, jewel 10.2.4 can be released as soon as you agree with the
>>>>>>> findings/summary.
>>>>>>
>>>>>> Do you think we're ready to release 10.2.4 yet?
>>>>>
>>>>> I'm reproducing http://tracker.ceph.com/issues/17847 with logs to make
>>>>> sure this isn't a regression.
>>>>>
>>>>> We can ignore the infernalis runs.
>>>>>
>>>>> I think we can ignore the knfs selinux issue too.. Greg, can you confirm?
>>>>>
>>>> Added the prs 12001 & 12167 on top of the jewel branch and scheduled rados runs
>>>> at
>>>> http://pulpito.ceph.com/abhi-2016-11-29_10:22:25-rados-wip-jewel-10-2-4-distro-basic-smithi/ &
>>>>
>>>> updated the tracker at http://tracker.ceph.com/issues/17851#note-17,
>>>> with details of the test. I'll update the progress once the suite goes
>>>> through
>>>
>>> Had around 11 tests fail from 296 scheduled, there were a couple of
>>> valgrind issues on ceph-mon (which were seen at earlier runs on jewel as
>>> well) and an s3test failure, rest of the issues were looking related to
>>> infrastructure as they were failing to get specific version numbers from
>>> gitbuilders.
>>>
>>> Reported this issue as:
>>>
>>> http://tracker.ceph.com/issues/18089
>>>
>>> subsequent re runs are still failing with similar errors. The details
>>> are updated at
>>>
>>> http://tracker.ceph.com/issues/17487#note-37
>>>
>>> The upgrade suite has also failed with similar errors.
>>>
>>> Overall it looks like we're close to cutting the release, as soon as we
>>> can get through these infra errors
>>
>> We should also get https://github.com/ceph/ceph/pull/12207 in once the
>> master version (https://github.com/ceph/ceph/pull/12206) is merged -
>> likely later today.
>
> Do you want it in 10.2.4 itself? what all qe suites would you recommend if so?

Yes, we need to not break the librados API or ABI in stable series 
especially.

The rgw suite would be enough - it's the only thing that really uses 
setxattr.

Josh
