From: Brian Edmonds <mornir@gmail.com>
Subject: Re: Designing a cluster guide
Date: Fri, 29 Jun 2012 11:42:41 -0700
Message-ID: <CAMsVa3vyJo05M4KkXmYwmRnoPi2V-sjM7SVHrM0ZJJ6JEZdCzA@mail.gmail.com>
References: <4FABAFE9.5060202@profihost.ag> <4FABC15C.3030500@profihost.ag>
 <CAPYLRzgTWLcbZHHpVs0j=WZokXfh8CGLcTUF6nkV1CCYiSs1DQ@mail.gmail.com> <CAPYLRzim+GHZe88_YA=1COKqh-A4XkPmUDYYiUyFVaQ2dxCuvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:59379 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756036Ab2F2SnD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Jun 2012 14:43:03 -0400
Received: by qadb17 with SMTP id b17so851084qad.19
        for <ceph-devel@vger.kernel.org>; Fri, 29 Jun 2012 11:43:01 -0700 (PDT)
In-Reply-To: <CAPYLRzim+GHZe88_YA=1COKqh-A4XkPmUDYYiUyFVaQ2dxCuvA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On Fri, Jun 29, 2012 at 11:07 AM, Gregory Farnum <greg@inktank.com> wrote:
>>> the "Designing a cluster guide"
>>> http://wiki.ceph.com/wiki/Designing_a_cluster is pretty good but it
>>> still leaves some questions unanswered.

Oh, thank you.  I've been poking through the Ceph docs, but somehow
had not managed to turn up the wiki yet.

What are the likely and worst case scenarios if the OSD journal were
to simply be on a garden variety ramdisk, no battery backing?  In the
case of a single node losing power, and thus losing some data, surely
Ceph can recognize this, and handle it through normal redundancy?  I
could see it being an issue if the whole cluster lost power at once.
Anything I'm missing?

Brian.
