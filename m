From: Brian Edmonds <mornir@gmail.com>
Subject: Re: Designing a cluster guide
Date: Fri, 29 Jun 2012 14:18:20 -0700
Message-ID: <CAMsVa3vN_MKtSbYhitYEhNNn-WO5LJW135TJ7S1yUnt56_oSQA@mail.gmail.com>
References: <4FABAFE9.5060202@profihost.ag> <4FABC15C.3030500@profihost.ag>
 <CAPYLRzgTWLcbZHHpVs0j=WZokXfh8CGLcTUF6nkV1CCYiSs1DQ@mail.gmail.com>
 <CAPYLRzim+GHZe88_YA=1COKqh-A4XkPmUDYYiUyFVaQ2dxCuvA@mail.gmail.com>
 <CAMsVa3vyJo05M4KkXmYwmRnoPi2V-sjM7SVHrM0ZJJ6JEZdCzA@mail.gmail.com>
 <CAPYLRzguXka1S_CyQ5q-f9VmhACpkHRZer1_9kuk3LPpfXOMcw@mail.gmail.com>
 <CAMsVa3vMBh6MoMS1pHc6HzNgJUhLp8Dyr5GzVYE9BKGFye2pBQ@mail.gmail.com> <CAPYLRzjiD+2dQ=C=VRbVa=3T4=05LD_WRvj0tJygfpqdZoYJ-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:35641 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754116Ab2F2VZl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Jun 2012 17:25:41 -0400
Received: by qcro28 with SMTP id o28so1991244qcr.19
        for <ceph-devel@vger.kernel.org>; Fri, 29 Jun 2012 14:25:40 -0700 (PDT)
In-Reply-To: <CAPYLRzjiD+2dQ=C=VRbVa=3T4=05LD_WRvj0tJygfpqdZoYJ-g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On Fri, Jun 29, 2012 at 2:11 PM, Gregory Farnum <greg@inktank.com> wrote:
> Well, actually this depends on the filesystem you're using. With
> btrfs, the OSD will roll back to a consistent state, but you don't
> know how out-of-date that state is.

Ok, so assuming btrfs, then a single machine failure with a ramdisk
journal should not result in any data loss, assuming replication is
working?  The cluster would then be at risk of data loss primarily
from a full power outage.  (In practice I'd expect either one machine
to die, or a power loss to take out all of them, and smaller but
non-unitary losses would be uncommon.)

Something to play with, perhaps.

Brian.
