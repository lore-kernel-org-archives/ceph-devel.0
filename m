From: Alfredo Deza <adeza@redhat.com>
Subject: Re: major infrastructure outage
Date: Thu, 12 Oct 2017 19:15:14 -0400
Message-ID: <CAC-Np1xkBQEaVLgpRd4YRCT_+tP6rkFoCNu84Q9Uh2ZrTuwY8w@mail.gmail.com>
References: <CAC-Np1xnrr-RXUV3m87bJ6QP-b-xV7KtQrQud5HckEgBQ-fDDw@mail.gmail.com>
 <bc4c8883-ab21-a81d-33f4-a4f77f05a8c1@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:48885 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751168AbdJLXPP (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Oct 2017 19:15:15 -0400
Received: by mail-wm0-f48.google.com with SMTP id i124so16875212wmf.3
        for <ceph-devel@vger.kernel.org>; Thu, 12 Oct 2017 16:15:15 -0700 (PDT)
In-Reply-To: <bc4c8883-ab21-a81d-33f4-a4f77f05a8c1@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Galloway <dgallowa@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Oct 12, 2017 at 9:15 AM, David Galloway <dgallowa@redhat.com> wrote:
>
> On 10/12/2017 07:24 AM, Alfredo Deza wrote:
>> We are currently going through a severe outage. All critical
>> infrastructure services are currently unavailable.
>>
>> This includes the following:
>>
>> * Both Jenkins masters (one is for Ceph the other one for ceph-ansible)
>> * Anything in Shaman
>> * All build nodes
>> * All repositories (anything *chacra.ceph.com)
>>
>> Some services are up, like docs.ceph.com, tracker, and download.ceph.com
>>
>> We are currently trying to determine the reason why these are
>> completely unreachable with the service provider.
>>
>> We will keep updating once we have anything to report.
>>
>
> All services have been restored.  The outage only affected the CI
> infrastructure (Jenkins, Shaman, Chacra, etc.).

Some of you may have experienced some builds being "stale" and not
completed to get repos.

This happened because the service that polls to check repos to build
was not started on one of the servers. That server is
2.chacra.ceph.com

So if you were impacted, I apologize, this was very hard to catch. The
good news is that the binaries are there, and the server will pick up
where it needs to, building
the repos as it finds them.

Because there is a backlog on that server, please be patient, at some
point it will up to date.

Again, apologies, this was totally something that we didn't
anticipate. Created an issue to make sure this is tracked next time

http://tracker.ceph.com/issues/21779
>
> OVH temporarily suspended our CI public cloud account due to a past due
> bill.
>
> I'm currently monitoring a build to verify packages are being created
> and pushed to the chacra nodes but I think we're in the clear.
