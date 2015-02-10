From: Gregory Farnum <greg@gregs42.com>
Subject: Re: dumpling integration branch for v0.67.12 ready for QE
Date: Tue, 10 Feb 2015 10:40:18 -0800
Message-ID: <CAC6JEv9EGMpJUcOxb=Nt9TgF8S0dqHroddCNwto-YdU_sNn0jw@mail.gmail.com>
References: <54DA3A5B.5050509@dachary.org>
	<54483038.14900677.1423588756901.JavaMail.zimbra@redhat.com>
	<54DA3E72.9010600@dachary.org>
	<867276671.14905190.1423589356764.JavaMail.zimbra@redhat.com>
	<54DA4843.10901@dachary.org>
	<CAC6JEv-37ga5X0M4GG=fBmo-T9OWWgSTkMSgfVt1eXXmm9XhTg@mail.gmail.com>
	<54DA4EF4.8020304@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:45134 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753382AbbBJSkT convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Feb 2015 13:40:19 -0500
Received: by iecat20 with SMTP id at20so18485185iec.12
        for <ceph-devel@vger.kernel.org>; Tue, 10 Feb 2015 10:40:18 -0800 (PST)
Received: from mail-ie0-f174.google.com (mail-ie0-f174.google.com. [209.85.223.174])
        by mx.google.com with ESMTPSA id ii3sm8344341igb.13.2015.02.10.10.40.18
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Feb 2015 10:40:18 -0800 (PST)
Received: by iecrp18 with SMTP id rp18so22508783iec.10
        for <ceph-devel@vger.kernel.org>; Tue, 10 Feb 2015 10:40:18 -0800 (PST)
In-Reply-To: <54DA4EF4.8020304@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Yuri Weinstein <yweinste@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Feb 10, 2015 at 10:33 AM, Loic Dachary <loic@dachary.org> wrote:
>
>
> On 10/02/2015 19:25, Gregory Farnum wrote:
>>
>> Now, as it happens there are some reasons to maintain a dumpling
>> branch that isn't part of backports. We've been doing a lot of work
>> lately to make the nightlies behave well under RHEL and in various
>> other environments, which sometimes involve changing the tests
>> themselves. That can mean updating the ceph.git/qa/workunits in our
>> LTS branches, which I've done a few times over the last couple of
>> months. Since they're used for testing they aren't suitable for going
>> through a backports workflow, we just want them to get into the
>> nightlies as fast as possible. Tossing out any such work every time a
>> point release appears would be irritating, to say the least.
>> (We could also pull the workunits out of ceph.git, but that's a
>> different discussion.)
>
> This is a good point. I'm assuming backports rely on the dumpling branch of ceph-qa-suite. And if a change needs to be done in ceph-qa-suite for the benefit of an ongoing backport effort to publish a point release, it will have to be done in such a way that it can work for both the current dumpling and the future point release.
>
> Am I understanding you correctly ?

No, I mean we are (unfortunately) actually changing the ceph.git
dumpling branch in order to update the tests we run so they succeed in
new environments. Those changes aren't going through backports
testing, because we want to verify that they're working in our regular
nightlies ASAP and don't want to wait for the backports branch to
merge for them to take effect in giving us successful tests. Look
at...wow, pick a commit on the first screen of the current dumpling
branch.

Also, as Sage mentions we actually run the dumpling branch in the
nightlies and using that as integration testing. I think it's
appropriate to keep doing so; otherwise we need to run every patch
through every suite *enough times to be sure we've not added a bug
that's hard to reproduce*. If we use dumpling as an integration branch
for backports that can be tested en-masse but independently we get a
lot more test coverage of them prior to releases.
-Greg
