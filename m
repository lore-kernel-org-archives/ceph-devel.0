From: Sage Weil <sweil@redhat.com>
Subject: Re: OSD's load_pgs takes a lot of time
Date: Tue, 26 Aug 2014 06:03:43 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1408260601570.30994@cobra.newdream.net>
References: <CADg7yx3mM+zagdcwQ6AO-omzxBM33=Gft3hvMEKDPEVysqKxBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45971 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755489AbaHZNDo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Aug 2014 09:03:44 -0400
In-Reply-To: <CADg7yx3mM+zagdcwQ6AO-omzxBM33=Gft3hvMEKDPEVysqKxBg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-2?Q?Micha=B3_Szyma=F1ski?= <michalszymanski91@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, 26 Aug 2014, Micha? Szyma?ski wrote:
> I have noticed that sometimes it takes a lot of time for an OSD to go
> back up and in. From what i can see in the logs it is stuck on
> load_pgs for a while:
> 2014-08-21 15:32:04.711048 7fba11569780  0 osd.1 139 load_pgs
> 2014-08-21 15:32:04.712512 7fba11569780 10 osd.1 139 load_pgs
> 3.165_TEMP clearing temp
> 2014-08-21 15:32:19.648610 7fba11569780 10 osd.1 139 load_pgs
> 3.13b_TEMP clearing temp
> 2014-08-21 15:32:34.674773 7fba11569780 10 osd.1 139 load_pgs
> 3.36b_TEMP clearing temp
> 
> It happens when you restart an OSD while there was an ongoing recovery
> in the cluster. The process isn't neither IO nor CPU heavy at that
> time, and judging by strace output it mostly does futex calls and a
> little IO on PGs. I am using Ceph 0.80.5.
> 
> Have anybody noticed this behavior? Isn't it possible to clear temp faster?

load_pgs is doing a lot more than just clearing temp; most of the work 
just isn't mentioned at debug osd = 10.  It loads the PG logs into 
memory (recent operations) and scans them to ensure they aren't missing 
locally.

There are likely several things we could do to speed this up (especially 
the search_for_missing() call) but they're a bit complex and not at the 
top of the list...

sage
