From: Gregory Farnum <greg@inktank.com>
Subject: Re: [PATCH] PG: Do not discard op data too early
Date: Thu, 27 Sep 2012 15:27:50 -0700
Message-ID: <CAPYLRzgXNCOYqjbF8SyWOSwHU6kvLNJR6Wd8kgsJu6Z7YXWMYw@mail.gmail.com>
References: <1348782975-7082-1-git-send-email-jaschut@sandia.gov>
	<CAPYLRzh_ngQt11Dv17YFJCj5pR3RJino6dbsw3HZ6WGAAhfu-w@mail.gmail.com>
	<5064D1CA.4030206@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:54832 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753287Ab2I0W1v (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Sep 2012 18:27:51 -0400
Received: by ieak13 with SMTP id k13so5848135iea.19
        for <ceph-devel@vger.kernel.org>; Thu, 27 Sep 2012 15:27:51 -0700 (PDT)
In-Reply-To: <5064D1CA.4030206@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: ceph-devel@vger.kernel.org

On Thu, Sep 27, 2012 at 3:23 PM, Jim Schutt <jaschut@sandia.gov> wrote:
> On 09/27/2012 04:07 PM, Gregory Farnum wrote:
>>
>> Have you tested that this does what you want? If it does, I think
>> we'll want to implement this so that we actually release the memory,
>> but continue accounting it.
>
>
> Yes.  I have diagnostic patches where I add an "advisory" option
> to Throttle, and apply it in advisory mode to the cluster throttler.
> In advisory mode Throttle counts bytes but never throttles.

Can't you also do this if you just set up a throttler with a limit of 0? :)

>
> When I run all the clients I can muster (222) against a relatively
> small number of OSDs (48-96), with osd_client_message_size_cap set
> to 10,000,000 bytes I see spikes of > 100,000,000 bytes tied up
> in ops that came through the cluster messenger, and I see long
> wait times (> 60 secs) on ops coming through the client throttler.
>
> With this patch applied, I can raise osd_client_message_size_cap
> to 40,000,000 bytes, but I rarely see more than 80,000,000 bytes
> tied up in ops that came through the cluster messenger.  Wait times
> for ops coming through the client policy throttler are lower,
> overall daemon memory usage is lower, but throughput is the same.
>
> Overall, with this patch applied, my storage cluster "feels" much
> less brittle when overloaded.

Okay, cool. Are you interested in reducing the memory usage a little
more by deallocating the memory separately from accounting it?
