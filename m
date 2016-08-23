From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: should we remove autotools from master?
Date: Tue, 23 Aug 2016 20:32:01 +0200
Message-ID: <fb80d1d2-ddf2-d45f-4a47-905485eb8340@digiware.nl>
References: <alpine.DEB.2.11.1608231356290.25681@piezo.us.to>
 <57BC5B7A.8050103@dachary.org>
 <DB5PR05MB16077097293BBD4CBF85D90EA9EB0@DB5PR05MB1607.eurprd05.prod.outlook.com>
 <alpine.DEB.2.11.1608231517060.25681@piezo.us.to>
 <CAC-Np1x2wxuZ0X6V8PfZjbwpApeYnZXpY_Ad1JdMjt6zDQ2atg@mail.gmail.com>
 <alpine.DEB.2.11.1608231821460.25681@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:59136 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752910AbcHWScW (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 23 Aug 2016 14:32:22 -0400
In-Reply-To: <alpine.DEB.2.11.1608231821460.25681@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, Alfredo Deza <adeza@redhat.com>
Cc: Avner Ben Hanoch <avnerb@mellanox.com>, Loic Dachary <loic@dachary.org>, Nathan Cutler <ncutler@suse.cz>, Brad Hubbard <bhubbard@redhat.com>, Gregory Farnum <gfarnum@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, Adir Lev <adirl@mellanox.com>

On 23-8-2016 20:24, Sage Weil wrote:
> On Tue, 23 Aug 2016, Alfredo Deza wrote:
>> On Tue, Aug 23, 2016 at 11:21 AM, Sage Weil <sweil@redhat.com> wrote:
>>> On Tue, 23 Aug 2016, Avner Ben Hanoch wrote:
>>>> For removing autotools support, I think that we should first announce
>>>> that autotools will not be supported starting <some-future-day> and till
>>>> then support both of them in parallel and response to questions about
>>>> it.
>>>
>>> I think we're basically proposing some-future-day as now.
>>>
>>>> Also, we first need to make sure that we have comprehensive instructions
>>>> for using cmake. Notice, that many developers are not familiar with
>>>> cmake; hence, there might be need for extra explanations.
>>>>
>>>> For example, I tried now the instructions in https://github.com/ceph/ceph/blob/master/README.md
>>>>       ./do_cmake.sh
>>>>       cd build
>>>>       make
>>>> and I got the error:
>>>>       make: *** No targets specified and no makefile found.  Stop.
>>>>
>>>> Probably, because of the explanation "This assumes you make your build
>>>> dir a subdirectory of the ceph.git checkout. If you put it elsewhere,
>>>> just replace .. above with a correct path to the checkout." However, if
>>>> you are not familiar with cmake, then this explanation does not tell you
>>>> how to recover from the error.
>>>
>>> The do_cmake.sh script is doing 'mkdir build', so assuming you actually
>>> ran it from the git checkout (i.e., ./do_cmake.sh) then this should be the
>>> case.  Is that actually what caused the error?
>>>
>>> I agree that step 0 is to make README.md complete for cmake.  Perhaps
>>> step 1 is to remove autotools instructions too.
>>>
>>>> Also, I am not sure it is clear to all developers how to combine above
>>>> instructions with options that you could provide to ./configure script.
>>>
>>> There is no more ./configure :).  There are a new set of options you can
>>> pass cmake that are referenced here in README.md:
>>>
>>>         https://github.com/ceph/ceph/blob/master/README.md#cmake-options
>>>
>>>> Hence, I think removing autotools support should not be immediate
>>>
>>> Please help us identify any (other) documentation gaps so we can get past
>>> this.  I thought README.md was in good shape...
>>
>> Nothing in there helped when trying to build binaries in the CI
>> scripts. I had to look at
>> https://github.com/ceph/autobuild-ceph/blob/master/build-ceph-rpm.sh#L56-L58
>> to try to make it work.
>>
>> Of course, this might not help anyone else, since it might not be
>> common to run `make-dist` ?
> 
> Ah, good point.  This PR
> 
> 	https://github.com/ceph/ceph/pull/10829
> 
> replaces the incomplete/wrong package build directions with make-dist 
> instructions.
> 
> Should we document how to build a proper rpm or deb here, or should we try 
> to pull what autobuilder and/or ceph-build are doing into scripts in 
> ceph.git, and replace the (broken?) make-debs.sh with make-{deb,rpm} and 
> ensure they work?  I think it depends on if anything in what you build is 
> likely to require changes outside of the ceph tree...

As to dumping autotools: +1

For this specific PR, I'm pretty sure that in future when building
FreeBSD packages, I'd like directions instead of trying to figure out
all the {deb,rpm} stuff.

--WjW

>>>>> -----Original Message-----
>>>>> From: Loic Dachary
>>>>>
>>>>>
>>>>> On 23/08/2016 15:58, Sage Weil wrote:
>>>>>> Should we remove the autotools stuff from master?
>>>>>>
>>>>>> Yes:
>>>>>> - It won't be maintained
>>>>>> - It sucks
>>>>>> - It confuses people and they use it by mistake
>>>>>> - We'll find any build scripts etc that haven't been converted sooner
>>>>>> rather than later
>>>>>>
>>>>>> No:
>>>>>> - Other architectures might rely on it
>>>>>> - It's possible some build scripts haven't been convert yet
>>>>>>
>>>>>> I'm thinking yes?
>>>>>
>>>>> I vote yes. The build scripts I know about are either converted or broken
>>>>> because autotools no longer works :-)
>>>>>
>>
>> Yes from me too. We do have the build scripts kind of messed up
>> already for master in Jenkins:
>>
>> https://github.com/ceph/ceph-build/commit/40b94af494dbb07440bf90f5b6695ecf2839b392
>>
>> We still need to support both because we still need to cut releases
>> for branches that do not support it though.
>>
>>>>> Cheers
>>>>>
>>>>>> sage
>>>>>>
>>>>>>
>>>>>> On Tue, 23 Aug 2016, Nathan Cutler wrote:
>>>>>>
>>>>>>>> That's a different make-deb(s).sh
>>>>>>>
>>>>>>> Allow me to qualify that statement. This thread seems to be about
>>>>>>>
>>>>>>> https://github.com/ceph/ceph/blob/master/make-debs.sh
>>>>>>>
>>>>>>> while the "make-deb.sh" I am working on is
>>>>>>>
>>>>>>> https://github.com/ceph/ceph-qa-suite/blob/master/tasks/buildpackages
>>>>>>> /make-deb.sh
>>>>>>>
>>>>>>> which is used with the teuthology-openstack backend. However, I see
>>>>>>> the two scripts are similar.
>>>>>>>
>>>>>>> In general, although the autotools stuff is still there in master, it
>>>>>>> is not maintained and should not be expected to work (or continue to
>>>>>>> work). All build infrastructure targeting master should be converted to
>>>>> cmake.
>>>>>>>
>>>>>>> Nathan

