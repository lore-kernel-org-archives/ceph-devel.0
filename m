From: Brian Edmonds <mornir@gmail.com>
Subject: Re: Designing a cluster guide
Date: Fri, 29 Jun 2012 13:59:58 -0700
Message-ID: <CAMsVa3vMBh6MoMS1pHc6HzNgJUhLp8Dyr5GzVYE9BKGFye2pBQ@mail.gmail.com>
References: <4FABAFE9.5060202@profihost.ag> <4FABC15C.3030500@profihost.ag>
 <CAPYLRzgTWLcbZHHpVs0j=WZokXfh8CGLcTUF6nkV1CCYiSs1DQ@mail.gmail.com>
 <CAPYLRzim+GHZe88_YA=1COKqh-A4XkPmUDYYiUyFVaQ2dxCuvA@mail.gmail.com>
 <CAMsVa3vyJo05M4KkXmYwmRnoPi2V-sjM7SVHrM0ZJJ6JEZdCzA@mail.gmail.com> <CAPYLRzguXka1S_CyQ5q-f9VmhACpkHRZer1_9kuk3LPpfXOMcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:46370 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755973Ab2F2VAT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Jun 2012 17:00:19 -0400
Received: by qcro28 with SMTP id o28so1980051qcr.19
        for <ceph-devel@vger.kernel.org>; Fri, 29 Jun 2012 14:00:18 -0700 (PDT)
In-Reply-To: <CAPYLRzguXka1S_CyQ5q-f9VmhACpkHRZer1_9kuk3LPpfXOMcw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On Fri, Jun 29, 2012 at 11:50 AM, Gregory Farnum <greg@inktank.com> wrote:
> If you lose a journal, you lose the OSD.

Really?  Everything?  Not just recent commits?  I would have hoped it
would just come back up in an old state.  Replication should have
already been taking care of regaining redundancy for the stuff that
was on it, particularly the newest stuff that wouldn't return with it
and say "Hi, I'm back."

I suppose it makes the design easier though. =)

Brian.
