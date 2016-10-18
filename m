From: Andrew Schoen <aschoen@redhat.com>
Subject: Re: upgrade testing with shaman
Date: Tue, 18 Oct 2016 14:54:44 -0500
Message-ID: <CAEPMp+50MLans6Zv32LR2+U8bvMSraK7QR6-FkDpw_JD_R2-SA@mail.gmail.com>
References: <CAEPMp+696EQxGjBi6v6kN5KycaoNMuEemaromTCSh4P2gwh2rA@mail.gmail.com>
 <CAJ4mKGYoEkEYFesWisQsOv+XCu5nuD-hA2wS+R7t8vDdNLONqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f47.google.com ([209.85.213.47]:34554 "EHLO
        mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932230AbcJRTyq (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 18 Oct 2016 15:54:46 -0400
Received: by mail-vk0-f47.google.com with SMTP id b186so6336706vkb.1
        for <ceph-devel@vger.kernel.org>; Tue, 18 Oct 2016 12:54:46 -0700 (PDT)
In-Reply-To: <CAJ4mKGYoEkEYFesWisQsOv+XCu5nuD-hA2wS+R7t8vDdNLONqg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: "Development, Ceph" <ceph-devel@vger.kernel.org>, sepia@ceph.com

On Tue, Oct 18, 2016 at 2:04 PM, Gregory Farnum <gfarnum@redhat.com> wrote:
> On Tue, Oct 18, 2016 at 11:04 AM, Andrew Schoen <aschoen@redhat.com> wrote:
>> All,
>>
>> We are working on a solution that will allow us to run the
>> teuthology upgrade tests with shaman, until we can start using the
>> repos from download.ceph.com (which is the ideal scenario).
>
> Can you elaborate on this? I can understand wanting to test against
> release packages, but we also need to not muck up our stable branches
> and sometimes test our next major release against a patched previous
> release.
> -Greg

Mostly for the reason you've stated, testing the repos that the
end-user will actually use.

Testing against a patched previous version should work through the
same process as any other branch pushed to ceph.git, those wouldn't
need to be on download.ceph.com.

This email was about providing a way to test against our tagged
upstream releases instead of using those releases that were built by
the gitbuilders.
