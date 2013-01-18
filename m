From: Gregory Farnum <greg@inktank.com>
Subject: Re: HOWTO: teuthology and code coverage
Date: Thu, 17 Jan 2013 16:05:29 -0800
Message-ID: <CAPYLRzidB-OpBu_zm95Z+NX5Vx9sz5s5+fvejBUcxtkuN_QPSA@mail.gmail.com>
References: <50F6B2A4.5090608@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f54.google.com ([209.85.216.54]:57428 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754030Ab3ARAFa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Jan 2013 19:05:30 -0500
Received: by mail-qa0-f54.google.com with SMTP id p6so926943qad.6
        for <ceph-devel@vger.kernel.org>; Thu, 17 Jan 2013 16:05:29 -0800 (PST)
In-Reply-To: <50F6B2A4.5090608@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

It's great to see people outside of Inktank starting to get into using
teuthology. Thanks for the write-up!
-Greg

On Wed, Jan 16, 2013 at 6:01 AM, Loic Dachary <loic@dachary.org> wrote:
> Hi,
>
> I'm happy to report that running teuthology to get a lcov code coverage report worked for me.
>
> http://dachary.org/wp-uploads/2013/01/teuthology/total/mon/Monitor.cc.gcov.html
>
> It took me a while to figure out the logic (thanks Josh for the help :-). I wrote a HOWTO explaining the steps in detail. It should be straightforward to run on an OpenStack tenant, using virtual machines instead of bare metal.
>
> http://dachary.org/?p=1788
>
> Cheers
>
