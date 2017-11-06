From: Abhishek Lekshmanan <abhishek@suse.com>
Subject: Re: 12.2.2 status
Date: Mon, 06 Nov 2017 19:29:36 +0100
Message-ID: <87o9ofb6r3.fsf@suse.com>
References: <87fua6c4xy.fsf@suse.com> <CA+2bHPYXuma-e-4_XAdLp6rxcT7NBYL+xF4Rz0PAvptLoXvQdw@mail.gmail.com> <874lqbcl5p.fsf@suse.com> <alpine.DEB.2.11.1711031753520.23234@piezo.novalocal> <871slfckae.fsf@suse.com> <CAJE9aOMv3pNFbL3RA3=wiXJKGL9+Mx6N9BazApPZ9E9DMXVp2A@mail.gmail.com> <7fc4336c-40fc-848c-00f7-e7ebc8aa744c@suse.cz> <CAEw75dMUFUQ5JAd4LRX=ycjo0d0C7RmvqMq6d+=5qkKcaGf8ow@mail.gmail.com> <CAJE9aOP+11MR+kKDKiCQx4FQPjofBkQcecEFOJjubZX30br-Og@mail.gmail.com> <87y3njbuh7.fsf@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:58770 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751821AbdKFS3j (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Mon, 6 Nov 2017 13:29:39 -0500
In-Reply-To: <87y3njbuh7.fsf@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kefu chai <tchaikov@gmail.com>, Abhishek L <abhishek.lekshmanan@gmail.com>
Cc: Nathan Cutler <ncutler@suse.cz>, Kefu Chai <kchai@redhat.com>, vumrao@redhat.com, Sage Weil <sweil@redhat.com>, Nathan Cutler <NCutler@suse.com>, "Dreyer, Ken" <kdreyer@redhat.com>, Patrick Donnelly <pdonnell@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, Matt Benjamin <mbenjamin@redhat.com>, "Sadeh-Weinraub, Yehuda" <yehuda@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>, "Durgin, Josh" <jdurgin@redhat.com>, Karol Mroz <KMroz@suse.com>

Abhishek Lekshmanan <abhishek@suse.com> writes:

> kefu chai <tchaikov@gmail.com> writes:
>
>> On Sun, Nov 5, 2017 at 8:17 PM, Abhishek L
>> <abhishek.lekshmanan@gmail.com> wrote:
>>> On Sat, Nov 4, 2017 at 8:51 AM, Nathan Cutler <ncutler@suse.cz> wrote:
>>>>> all or nothing. if we want to backport the fix of
>>>>> http://tracker.ceph.com/issues/21762, we will have to backport the
>>>>> "debian: fix package relationships after" fixes. so i think pull/18589
>>>>> is self-contained. and no additional step is needed.
>>>>>
>>>>> and per http://tracker.ceph.com/issues/21762, we need to have it in
>>>>> luminous. but i have no strong opinion on including it in 12.2.2 or
>>>>> post 12.2.2. Vikhyat and Nathan, what do you think?
>>>>
>>>>
>>>> Yes, I tried to make 18589 self-contained by pulling in Kefu's and
>>>> Abhishek's follow-on fixes. I think it would be nice to have it in 12.2.2.
>>>
>>> Rebuilt the integration branch with the newer PR and it still fails
>>> with the same reason
>>> http://pulpito.ceph.com/abhi-2017-11-05_11:53:02-ceph-disk-wip-abhi-testing-2017-11-05-0933-distro-basic-vps/
>>> for eg.
>>>
>>> Kefu, are there any more commits we need to solve the dependency issue?
>>
>> well, yes and no.
>>
>> we need to "dch" the changelog, to bump up the version number to
>> 12.2.2 to address this issue. but i thought this was a step of our
>> release process: see
>> https://github.com/ceph/ceph-build/blob/2cb4f4069c7a0fac1abecd76e6014272f22cf139/ansible/roles/ceph-release/tasks/release/stable.yml#L3.
>>
>> that's why i believed that PR#18589 was self-contained. anyway, we can
>> "fix" this issue in two ways:
>>
>> 1. "dch" the changelog in a commit only for testing, and it will not
>> be merged into luminous. run that the upgrade suites using dch'ed
>> version, and wait until the jenkins builder to tag and dch
>> automatically for the official release of 12.2.2
>> 2. just drop the PR#18589. so and include it in post 12.2.2. so the
>> problem will be resolved w/o any efforts by then.
>
> I'm inclined to do #2, either way I've scheduled suites (which has
> completed now) without this PR since I couldn't get moving with the PR
> included, I'll post the results soon & hopefully we can handover to QE
> today itself

update:

refer http://tracker.ceph.com/issues/21830 for update information

RADOS, RBD suites were green, ran into a couple of possible env. errors
which didn't reproduce in the rerun. A possible timing issue (didn't
reproduce) http://tracker.ceph.com/issues/22047

CephFS runs seem to hit http://tracker.ceph.com/issues/22039
consistently, the other failures look environmental. run info
http://tracker.ceph.com/issues/21830#note-23
@Patrick can you take a look.

RGW initially hit some failures due to s3-tests branch which was fixed,
the tests are still running though failures so far have been
environmental or known.
http://tracker.ceph.com/issues/21830#note-18

Saw a valgrind leak on mons in one of the RGW runs, reported at
http://tracker.ceph.com/issues/22052

ceph-disk consistently seems to run into a nearfull failure (was present
in the first integration branch run as well) possibly related to
dmcrypt. (a python backtrace is thrown as unknown key managment-mode)
tracker.ceph.com/issues/21830#note-19, don't see any recent patches that
went into master/luminous that could explain this failure unfortunately. 


Upgrade luminous-x seems to consistently fail with being unable to find
ceph-common packages, eg. run:
http://pulpito.ceph.com/abhi-2017-11-06_15:35:39-upgrade:luminous-x-wip-abhi-testing-2017-11-05-1320-distro-basic-smithi/ 

-- 
Abhishek Lekshmanan
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton,
HRB 21284 (AG Nürnberg)
