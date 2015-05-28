From: Gregory Farnum <greg@gregs42.com>
Subject: Re: teuthology job priorities
Date: Thu, 28 May 2015 11:04:33 -0700
Message-ID: <CAC6JEv_DDtBKkkumnatHcF-L7+BB_eS-A0ZzC6N8-eXvH598Qg@mail.gmail.com>
References: <5566E0AD.80401@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f180.google.com ([209.85.220.180]:35487 "EHLO
	mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753723AbbE1SEf convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 May 2015 14:04:35 -0400
Received: by qkhq76 with SMTP id q76so2460194qkh.2
        for <ceph-devel@vger.kernel.org>; Thu, 28 May 2015 11:04:34 -0700 (PDT)
Received: from mail-qk0-f182.google.com (mail-qk0-f182.google.com. [209.85.220.182])
        by mx.google.com with ESMTPSA id f31sm1387942qge.27.2015.05.28.11.04.33
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 May 2015 11:04:34 -0700 (PDT)
Received: by qkx62 with SMTP id 62so30933468qkx.3
        for <ceph-devel@vger.kernel.org>; Thu, 28 May 2015 11:04:33 -0700 (PDT)
In-Reply-To: <5566E0AD.80401@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Thu, May 28, 2015 at 2:32 AM, Loic Dachary <loic@dachary.org> wrote:
> Hi,
>
> This morning I'll schedule a job with priority 50, assuming nobody will get mad at me for using such a low priority because the associated bug fix blocks the release of v0.94.2 (http://tracker.ceph.com/issues/11546) and also assuming noone uses a priority lower than 100 just to get in front of the nightlies[1]. In my imagination
>
>    priority [0,100] is for emergencies
>    priority [100,1000] is to schedule a job with higher priority than the nightlies
>    priority 1000 (the default) is for all automated tests and no human being wait on them (the nightlies for instance).
>
> Does someone have a different mapping in mind ?

Those are pretty sensible. In practice I think the important points to
be aware of are:
1000: nightly priority
101: Sam's priority for anything he schedules.

That 101 can be a bit tricky since going over it can mean you don't
run for a few days if he's busy running stuff repeatedly. It's kind of
an unfortunate race to the bottom when there are several people who
think their stuff is important. (A few weeks ago Sage was running RGW
bugfix tests for several days, at least some of which were priority 1.
I was also trying to push some stuff through at the time and that was
quite an experience.) :/
-Greg
