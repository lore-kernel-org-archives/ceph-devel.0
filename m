From: Sage Weil <sage@inktank.com>
Subject: Re: Memory usage of ceph-mds
Date: Wed, 19 Sep 2012 14:33:35 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1209191432240.7537@cobra.newdream.net>
References: <CANLRBoyZ5JCTfdu_ntf+aOYBPa2C4w5TLM8-2Q4_=YWg8=VL1w@mail.gmail.com> <alpine.DEB.2.00.1209191347210.7537@cobra.newdream.net> <CAPYLRziPh0+7BGxMa7e9n6QQGruRX6-58x-fnAAwYaONkOVZ1g@mail.gmail.com> <CANLRBoyKVk68Kxd85++WjWFr4870ihrRqWarO69V+7Pza62mXw@mail.gmail.com>
 <CAPYLRziJNqjZnD4J8ufhMZ+GYs3Wn67Qk_=GJKsb45e_D8Qjgw@mail.gmail.com> <CANLRBoyfwajKToDqWgnfMWK9b8AAGX3WsRW9Ymr-96GsqTJ1ag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:41126 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751916Ab2ISVdf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Sep 2012 17:33:35 -0400
In-Reply-To: <CANLRBoyfwajKToDqWgnfMWK9b8AAGX3WsRW9Ymr-96GsqTJ1ag@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tren Blackburn <tren@eotnetworks.com>
Cc: Gregory Farnum <greg@inktank.com>, ceph-devel@vger.kernel.org

On Wed, 19 Sep 2012, Tren Blackburn wrote:
> On Wed, Sep 19, 2012 at 2:12 PM, Gregory Farnum <greg@inktank.com> wrote:
> > On Wed, Sep 19, 2012 at 2:05 PM, Tren Blackburn <tren@eotnetworks.com> wrote:
> >
> >> Greg: It's difficult to tell you that. I'm rsyncing 2 volumes from our
> >> filers. Each base directory on each filer mount has approximate 213
> >> directories, and then each directory under that has approximately
> >> anywhere from 3000 - 5000 directories (very loose approximation here,
> >> 850,000 directories per filer mount), and then each of those
> >> directories contains files.
> >
> > Ah, directories are larger ? Sage, do you think they're enough bigger
> > to make up that much extra memory usage?
> >
> >
> >> We have many many files here. We're doing this to see how CephFS
> >> handles lots of files. We are coming from MooseFS which its master
> >> metalogger process eats lots of ram, so we're hoping that Ceph is a
> >> bit lighter on us.
> >>
> >> Sage: The memory the MDS is using is only a cache? There should be no
> >> problem restarting the MDS server while activity is going on? I should
> >> probably change the limit for the non-active MDS servers first, and
> >> then the active one and hope it fails over cleanly?
> > Yep, that should work fine, with the obvious caveat that your
> > filesystem will become inaccessible if the MDS is down long enough for
> > clients to exceed their timeouts (no metadata loss though, if all
> > clients remain active until the MDS comes back up).
> 
> I have 3 MDS's (active/standby setup). Shouldn't the MDS fail over to
> the other node when I restart the process? I'm not sure what the best
> method for just restarting the MDS is, and can it be done without
> forcing a fail over?

Any running standby ceph-mds daemon will take over when the first one is 
shut down.  Just stop the daemons on the other nodes too if for some 
reason you care which machine the daemon runs on (Ceph certainly 
doesn't!).

You can restart with

	/etc/init.d/ceph restart mds

sage
