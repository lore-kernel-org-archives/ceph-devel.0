From: Samuel Just <sjust@redhat.com>
Subject: Re: ceph-qa-suite branching (merge it into ceph.git?)
Date: Wed, 13 Apr 2016 11:23:14 -0700
Message-ID: <CAN=+7FXfDOP1KrbP-7qArVXyP8G1QjK+YY0phHgHajZ3fv4CyA@mail.gmail.com>
References: <CALe9h7fp=qaio8npS0naXjCp9bbg-kkB6bXG9PcGXGftvD4puA@mail.gmail.com>
	<CAKPXa=Y5rJ4ygM9Sdvys+86RwufnKopTOkMNdPHcpCh5bFbQ0w@mail.gmail.com>
	<CAKPXa=a0vVU5t2wVvQ92FLz3T20Z_sr1J2PGPPVsA3=R7_2-Dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f177.google.com ([209.85.161.177]:33443 "EHLO
	mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755169AbcDMSXP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Apr 2016 14:23:15 -0400
Received: by mail-yw0-f177.google.com with SMTP id t10so79386881ywa.0
        for <ceph-devel@vger.kernel.org>; Wed, 13 Apr 2016 11:23:15 -0700 (PDT)
In-Reply-To: <CAKPXa=a0vVU5t2wVvQ92FLz3T20Z_sr1J2PGPPVsA3=R7_2-Dw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Vasu Kulkarni <vakulkar@redhat.com>
Cc: John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, ceph-qa <ceph-qa@ceph.com>

This seems tidy to me.  I'd love to be able to merge a PR with it's
ceph-qa-suite PR "atomically".
-Sam

On Wed, Apr 13, 2016 at 11:10 AM, Vasu Kulkarni <vakulkar@redhat.com> wrote:
> Sorry for spam, the first one was rejected due to text/html format.
>
> On Wed, Apr 13, 2016 at 3:52 AM, John Spray <jspray@redhat.com> wrote:
>>
>> Lately, we've instances where ceph.git and ceph-qa-suite.git got
>> slightly out of sync, as we were adding new stuff and interface
>> changes to ceph (especially in cephfs).
>>
>> We used to have two repos (ceph and teuthology), now we have three
>> (ceph, ceph-qa-suite and teuthology).
>
>
> we also have s3 suites in its own repo, we have big files in
> ceph.com/qa which i believe is the right place.
>
>>
>> Splitting tests out of
>> teuthology was a good thing, but maybe they should have gone into the
>> ceph tree instead of a new repo?  The ceph-qa-suite branching seems to
>> pretty much mirror what we do with ceph, with master vs jewel etc.
>>
>> Historically we had a comparatively static set of workloads in the qa
>> suite (e.g. kernel-untar-build, fsstresss, pjd), which didn't change
>> much with ceph changes.  But these days we're adding much more
>> detailed tests, so there's more effort to keep the two in sync.
>>
>> I would personally love to be able to have a single PR that contained
>> my code and the tests for it.  What if after Jewel we pulled all of
>> ceph-qa-suite into the ceph repo?
>
>
> I understand the advantage of having same sha between builds and
> tests, but how are we going to guarantee ceph-builds in different
> places(one built on other than ceph.com) will have same sha?
> why not move ceph tests from ceph.git into ceph-qa-suite,  Ideally
> this is not an issue with any major release, jewel workunits are
> supposed to work with jewel ceph,
> only in rare cases it may cause some issue but easily fixable. All the
> dev runs can point to any qa-sha using the cli option so much less of
> an issue in rare case.
>
>>
>> We could still enable folks running test changes without having to
>> rebuild ceph packages: the suite sha1 selected when running a
>> teuthology suite could still be different from that used for
>> installing ceph, it's just that it would fetch that sha1 from the ceph
>> repo instead of from a separate repo.
>>
>> John
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
