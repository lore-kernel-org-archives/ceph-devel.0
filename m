From: Sage Weil <sage@newdream.net>
Subject: Re: Fresh deploy Ceph (Jewel) failed because the ceph OSD deamon is
 not activated
Date: Fri, 3 Jun 2016 08:56:59 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1606030856470.6221@cpach.fuggernut.com>
References: <CAOCf4A=8WiBpmYV9NBFyQ639TpHxN74h3O6sT1UqMPiopaY5zQ@mail.gmail.com> <alpine.DEB.2.11.1606030825210.6221@cpach.fuggernut.com> <CAC-Np1w-TZJXfwGdi81wVK7xTdJdJwRJ1zrhfVh1Bc+JkuktUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50556 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752045AbcFCM4g (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 3 Jun 2016 08:56:36 -0400
In-Reply-To: <CAC-Np1w-TZJXfwGdi81wVK7xTdJdJwRJ1zrhfVh1Bc+JkuktUw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alfredo Deza <adeza@redhat.com>
Cc: Tone Zhang <tone.zhang@linaro.org>, ceph-devel <ceph-devel@vger.kernel.org>

On Fri, 3 Jun 2016, Alfredo Deza wrote:
> On Fri, Jun 3, 2016 at 8:25 AM, Sage Weil <sage@newdream.net> wrote:
> > On Fri, 3 Jun 2016, Tone Zhang wrote:
> >> Hello all,
> >>
> >> I fresh deployed Ceph within 3 ceph nodes according to the manual
> >> http://docs.ceph.com/docs/master/start/quick-ceph-deploy/.
> >> Ceph version is Jewel (ceph version 10.2.1
> >> (3a66dd4f30852819c1bdaa8ec23c795d4ad77269)).
> >> Ubuntu 16.04 is used in each node.
> >> After run the command "ceph-deploy osd activate", there is warning
> >> reported, following an ERROR, ENAMETOOLONG. After check in each ceph
> >> OSD node, the ceph osd daemon is not start up.
> >
> > This probably happened because you deployed the OSD on ext4.  We should
> > probably remove that option (or add a warning) to ceph-deploy.
> 
> Since ceph-deploy is meant to be opinionated about these things, I
> think the option should be removed:
> 
> PR: https://github.com/ceph/ceph-deploy/pull/399
> Tracker issue: http://tracker.ceph.com/issues/16140

Even better!  Merged.

Thanks!
sage
