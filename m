From: Gregory Farnum <greg@gregs42.com>
Subject: Re: dumpling integration branch for v0.67.12 ready for QE
Date: Tue, 10 Feb 2015 10:25:00 -0800
Message-ID: <CAC6JEv-37ga5X0M4GG=fBmo-T9OWWgSTkMSgfVt1eXXmm9XhTg@mail.gmail.com>
References: <54DA3A5B.5050509@dachary.org>
	<54483038.14900677.1423588756901.JavaMail.zimbra@redhat.com>
	<54DA3E72.9010600@dachary.org>
	<867276671.14905190.1423589356764.JavaMail.zimbra@redhat.com>
	<54DA4843.10901@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:48356 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752550AbbBJSZD convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Feb 2015 13:25:03 -0500
Received: by mail-ig0-f172.google.com with SMTP id l13so25461692iga.5
        for <ceph-devel@vger.kernel.org>; Tue, 10 Feb 2015 10:25:01 -0800 (PST)
Received: from mail-ie0-f169.google.com (mail-ie0-f169.google.com. [209.85.223.169])
        by mx.google.com with ESMTPSA id 93sm9073661iop.4.2015.02.10.10.25.00
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Feb 2015 10:25:01 -0800 (PST)
Received: by iecat20 with SMTP id at20so18372088iec.12
        for <ceph-devel@vger.kernel.org>; Tue, 10 Feb 2015 10:25:00 -0800 (PST)
In-Reply-To: <54DA4843.10901@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Yuri Weinstein <yweinste@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Feb 10, 2015 at 10:04 AM, Loic Dachary <loic@dachary.org> wrote:
>
>
> On 10/02/2015 18:29, Yuri Weinstein wrote:>
>> On 10/02/2015 18:19, Yuri Weinstein wrote:>
>>> Loic,
>>>
>>> The only difference between options if we run suits on merged dumpling vs dumpling-backports first - is time.
>>> We will have to run suites on the final branch after the merge anyway.
>>
>> Could you explain why ? After merging dumpling and dumpling-backports will be exactly the same.
>>
>> Loic - I feel that finial QE validation should be done on the code that gets actually released to customers, e.g. dumpling branch after the merge.  I do see your point about branches being identical and ready to change my mind if you insist.  Does my reasoning make sense?  Please advice, how we should proceed.
>
> The dumpling-backports branch currently is at
>
> https://github.com/ceph/ceph/commit/3944c77c404c4a05886fe8276d5d0dd7e4f20410
>
> after a successful test run from QE and a merge into dumpling, the dumpling branch will be at
>
> https://github.com/ceph/ceph/commit/3944c77c404c4a05886fe8276d5d0dd7e4f20410
>
> as well. In other words they are identical and there is no point in running a test again. The only reason why they could be different is if a commit is inadvertently added to the dumpling branch while testing happens on the dumpling-backport branc. In this case the presence of this new commit would be reason enough to run another round of test indeed. So the process could be:
>
> If tests are ok and merge can fast forward, then release.
> If tests are ok and merge cannot fast forward, send back to loic because a commit was added by accident and needs to be approved by the leads.
>
> If testing happens on the dumpling branch, adding a commit to the dumpling branch would have side effects that could taint the results of the tests or, even worse, go unnoticed. There is zero chance that someone adds a commit to the dumpling-backports branch and that gives us something stable. On the contrary, the odds that someone adds a commit to the dumpling branch are high, specially if the tests take a few weeks to complete.
>
> As Greg mentioned, merging in dumpling does not matter much for this round because it is what has been done in the past. And to be honest, I would not mind if an additional commit taints the process by accident. However, unless there is a reason not to, it would be good to establish a process that is solid if we can.
>
> I've witnessed Alfredo's pain on each release and an additional benefit of having a dumpling-backports branch that nobody tampers with just occured to me. When and if QE finds that dumpling-backports is fit for release, instead of merging it into dumpling it could be handed over to Alfredo for release. And he would be able to proceed knowing it is stable and won't be moving forward. Once the release is done and the tag set to the proper commit, the dumpling branch can be reset to dumpling-backports. If commits were added during the process, their authors could be notified that they were discarded and need to be merge again. That would not work for the master branch but it would definitely be possible for the stable branches because such "out of process" commits are rarely added.
>
> I've not thought this through, but the more I think about it the more I like the idea of using dumpling-backports as a staging area until the release is final.

What's the purpose of even having a dumpling branch at that point?
We're not using it for anything under your model.

Now, as it happens there are some reasons to maintain a dumpling
branch that isn't part of backports. We've been doing a lot of work
lately to make the nightlies behave well under RHEL and in various
other environments, which sometimes involve changing the tests
themselves. That can mean updating the ceph.git/qa/workunits in our
LTS branches, which I've done a few times over the last couple of
months. Since they're used for testing they aren't suitable for going
through a backports workflow, we just want them to get into the
nightlies as fast as possible. Tossing out any such work every time a
point release appears would be irritating, to say the least.
(We could also pull the workunits out of ceph.git, but that's a
different discussion.)
-Greg
