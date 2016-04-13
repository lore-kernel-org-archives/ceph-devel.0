From: Abhishek Lekshmanan <abhishek@suse.com>
Subject: Re: ceph-qa-suite branching (merge it into ceph.git?)
Date: Wed, 13 Apr 2016 21:18:02 +0200
Message-ID: <86pottl3md.fsf@linux-stsn.suse>
References: <CALe9h7fp=qaio8npS0naXjCp9bbg-kkB6bXG9PcGXGftvD4puA@mail.gmail.com> <CAKPXa=Y5rJ4ygM9Sdvys+86RwufnKopTOkMNdPHcpCh5bFbQ0w@mail.gmail.com> <CALe9h7f3OFobvNscxMTmoSSkxf2PfG71wPqAJ8mTWEBKpGH3Dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:39189 "EHLO
	smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750881AbcDMTSl (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Wed, 13 Apr 2016 15:18:41 -0400
In-reply-to: <CALe9h7f3OFobvNscxMTmoSSkxf2PfG71wPqAJ8mTWEBKpGH3Dw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Vasu Kulkarni <vakulkar@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, ceph-qa <ceph-qa@ceph.com>


John Spray writes:

> On Wed, Apr 13, 2016 at 7:02 PM, Vasu Kulkarni <vakulkar@redhat.com> wrote:
>>
>>
>> On Wed, Apr 13, 2016 at 3:52 AM, John Spray <jspray@redhat.com> wrote:
>>>
>>> Lately, we've instances where ceph.git and ceph-qa-suite.git got
>>> slightly out of sync, as we were adding new stuff and interface
>>> changes to ceph (especially in cephfs).
>>>
>>> We used to have two repos (ceph and teuthology), now we have three
>>> (ceph, ceph-qa-suite and teuthology).
>>
>>
>> we also have s3 suites in its own repo, we have big files in ceph.com/qa
>> which i believe is the right place.
>
> I'm a bit ignorant of the s3 tests, is there a particular reason they
> live separately to the main ceph-qa-suite?

Technically s3-tests can have tests that do not all pass on rgw (which
is true mostly even now as we have a fails_on_rgw filter) and pass on
Amazon S3. I'm guessing this may be a reason they live outside of the
qa-suite, but I could be wrong

Abhishek
>
> As for the stuff in ceph.com/qa, I of course am not suggesting putting
> those bit binaries into the main git repo.  It is sort of annoying
> that they live out there on a web server, but it's a separate issue
> from the ceph/ceph-qa-suite one.
>
>>> Splitting tests out of
>>> teuthology was a good thing, but maybe they should have gone into the
>>> ceph tree instead of a new repo?  The ceph-qa-suite branching seems to
>>> pretty much mirror what we do with ceph, with master vs jewel etc.
>>>
>>> Historically we had a comparatively static set of workloads in the qa
>>> suite (e.g. kernel-untar-build, fsstresss, pjd), which didn't change
>>> much with ceph changes.  But these days we're adding much more
>>> detailed tests, so there's more effort to keep the two in sync.
>>>
>>> I would personally love to be able to have a single PR that contained
>>> my code and the tests for it.  What if after Jewel we pulled all of
>>> ceph-qa-suite into the ceph repo?
>>
>>
>> I understand the advantage of having same sha between builds and tests, but
>> how are we going to guarantee ceph-builds in different places(one built on
>> other than ceph.com) will have same sha?
>
> The thing that needs to match is the sha1 of the ceph code you're
> running, and the sha1 you use when pulling the code to test it with.
>
> I believe you currently have a situation where you have a built RPM
> but you're not sure what ceph sha1 it came from, so you're pulling
> e.g. the jewel branch of ceph-qa-suite rather than a specific sha1.
> That needs fixing independently of ceph/ceph-qa-suite separation: you
> have to run the right revision of the tests, irrespective of where
> they're getting pulled from.
>
> Basically, anyone generating packages with versions that don't map to
> a ceph sha1 will need to have a way of remembering what ceph sha1
> their packages correspond to.  This is not a new requirement, it's the
> same issue that was discussed on IRC recently.
>
>> why not move ceph tests from ceph.git into ceph-qa-suite,  Ideally this is
>> not an issue with any major release, jewel workunits are supposed to work
>> with jewel ceph,
>
> That would not help, because you still have the same issue of changes
> in ceph being out of step with changes in ceph-qa-suite.
>
> I think your misconception here is to assume that running tests from
> the same branch as the code is sufficient.  You need to run tests from
> the same *revision*.  Otherwise, when I add a new test to reproduce a
> bug, and fix the bug at the same time, then you will get failures if
> you run the newer commit against the older code.
>
> John
>
>> only in rare cases it may cause some issue but easily fixable. All the dev
>> runs can point to any qa-sha using the cli option so much less of an issue
>> in rare case.
>
>
>
>>>
>>> We could still enable folks running test changes without having to
>>> rebuild ceph packages: the suite sha1 selected when running a
>>> teuthology suite could still be different from that used for
>>> installing ceph, it's just that it would fetch that sha1 from the ceph
>>> repo instead of from a separate repo.
>>>
>>> John
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>


-- 
Abhishek
