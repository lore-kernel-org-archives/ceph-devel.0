From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: Testing with Bluestore and Filestore
Date: Thu, 2 Mar 2017 13:40:20 -0500
Message-ID: <CA+aFP1BrsLFXr=nu2aucFT1RzR3eufY4Ut4XKp9UkafNfXhujA@mail.gmail.com>
References: <CAMdDSN2xU=eRCxEDrq3qP0zmXxxTLAZrSboHcB8N4EH2ZhU8PQ@mail.gmail.com>
 <CAJ4mKGaq+d6EzFHsADSnO-nC3VbbugrxgkmrhY=3d5cqDjFBqQ@mail.gmail.com>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f53.google.com ([209.85.215.53]:36432 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752480AbdCBSkW (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Mar 2017 13:40:22 -0500
Received: by mail-lf0-f53.google.com with SMTP id y193so37730416lfd.3
        for <ceph-devel@vger.kernel.org>; Thu, 02 Mar 2017 10:40:21 -0800 (PST)
In-Reply-To: <CAJ4mKGaq+d6EzFHsADSnO-nC3VbbugrxgkmrhY=3d5cqDjFBqQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Brett Niver <bniver@redhat.com>, John Spray <jspray@redhat.com>, Sage Weil <sweil@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Mar 2, 2017 at 1:36 PM, Gregory Farnum <gfarnum@redhat.com> wrote:
> On Thu, Mar 2, 2017 at 8:36 AM, Brett Niver <bniver@redhat.com> wrote:
>> Sage,
>>
>> Perhaps this has already been discussed, but Jason had a good idea,
>> that perhaps instead of testing both BS and FS upstream independently,
>>  and doubling our testing, we might have teuthology randomly pick
>> which to use.
>>
>> That would potentially reduce TCs and also give us the testing that
>> would help prepare for working thru the migration/transition once BS
>> is ready.
>
> This is really what the subset functionality is for, although I think
> John had started working on a feature in this area that would let the
> subset functionality go across the rados configuration options while
> guaranteeing full combinatorial explosion on the FS tests.
> -Greg

I was actually thinking that OSDs should be randomly assigned an
object store by teuthology (i.e. roughly 50% FileStore vs 50%
BlueStore in the same cluster in the same test run). Right now, the
tests (at least for RBD) running 100% FileStore or 100% BlueStore with
no intermixing (and no verification that PGs comprised of FileStore
and BlueStore OSDs behave properly). That would also have the added
benefit of eliminating half the test cases in the RBD suite even
before you apply a subset.

>>
>> Brett
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Jason
