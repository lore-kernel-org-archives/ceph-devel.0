From: Alfredo Deza <adeza@redhat.com>
Subject: Re: PRs not being tested by jenkins??
Date: Tue, 2 May 2017 08:51:16 -0400
Message-ID: <CAC-Np1w4jR3v_8id1dhdgn2-=dhUq+fhrSVigGVZF=xnaBwDHg@mail.gmail.com>
References: <368674ff-451c-f006-147b-ba7ab17b660a@digiware.nl>
 <585be7e7-3eab-76e8-af6b-788d79d6721e@digiware.nl> <CAJ4mKGaz09_gTA64aAAT2ZVFnpp+NXMazX3VWEY1Tg-qN5AZGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:37875 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750740AbdEBMvS (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 2 May 2017 08:51:18 -0400
Received: by mail-wm0-f49.google.com with SMTP id m123so18770772wma.0
        for <ceph-devel@vger.kernel.org>; Tue, 02 May 2017 05:51:17 -0700 (PDT)
In-Reply-To: <CAJ4mKGaz09_gTA64aAAT2ZVFnpp+NXMazX3VWEY1Tg-qN5AZGg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Willem Jan Withagen <wjw@digiware.nl>, Andrew Schoen <aschoen@redhat.com>, Ken Dreyer <kdreyer@redhat.com>

On Fri, Apr 28, 2017 at 5:28 PM, Gregory Farnum <gfarnum@redhat.com> wrote:
> Apparently something happened to out Jenkins system during an upgrade
> so it was out for a while. One of the CC'ed guys can hopefully provide
> some details.
> -Greg
>
> On Thu, Apr 27, 2017 at 8:05 AM Willem Jan Withagen <wjw@digiware.nl> wrote:
>>
>> On 27-4-2017 16:52, Willem Jan Withagen wrote:
>> > Hi,
>> >
>> > Is there any particulars why I have 4 PRs that are held on trial runs
>> > thru Jenkins?

Hey Willem, apologies for taking so long to respond, Greg Meno just
sent an update to the sepia mailing list, but let me give a tl;dr here
as well:

* We upgraded our Jenkins master instance to address a security issue
on the same day it was released
* After the upgrade all of the slaves lost connectivity because the
security upgrade brought in some incompatibilities on how we connect
* Several hours after debugging and submitting upstream patches on the
libraries we depend on we were able to get back almost back to normal

Even after being able to connect some other jobs and slaves continued
to have some issues that took an extra day to resolve (mostly
ceph-ansible which relies on libvirt hosts).

I had initially sent out an email to a non-public facing email list
and I should've followed up with ceph-devel too. Thanks Gregory for
pinging us and letting us know that we missed out on that

Apologies again for the delay
>>
>> 'mmm,
>>
>> Some/All of them "just" started to be processed.
>> So I guess the queue was rather full.
>>
>> --WjW
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
