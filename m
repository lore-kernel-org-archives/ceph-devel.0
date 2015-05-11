From: Sage Weil <sage@newdream.net>
Subject: Re: autodetecting init system.
Date: Mon, 11 May 2015 10:34:56 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1505111032530.28239@cobra.newdream.net>
References: <5550D903.8000802@suse.com> <5550DACA.4070504@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:56181 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751353AbbEKRe4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 May 2015 13:34:56 -0400
In-Reply-To: <5550DACA.4070504@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <john.spray@redhat.com>
Cc: Owen Synge <osynge@suse.com>, ceph-devel@vger.kernel.org

On Mon, 11 May 2015, John Spray wrote:
> On 11/05/2015 17:29, Owen Synge wrote:
> > Dear all,
> > 
> > Many init systems are used in linux now. Some ceph code needs to know
> > the init system. (I must admit I have not looked into Solaris, MacOS and
> > BSD and probably should have)
> > 
> > It would be nice to have one function that detects the init system
> > 
> > Since the init system can be specified in ceph and ceph-deploy
> > explicitly it seems to be its reasonable to fail clearly to detect init
> > system.
>
> I think I'm missing some background here.  I was under the impression that
> distros generally had a preferred init system (even if they let you switch),
> and if another is in use then compatibility links are usually provided (e.g.
> sysv-style calling through to systemd or vice versa).  Given that, the distro
> packaging then uses whatever the "right" way to start a service is for that
> distro, and it's up to the distro to make sure that command is available.
> 
> Otherwise don't we descend into a kind of madness where a package post-install
> script can't start a service, because it doesn't know what command to run?

Ceph daemons are marked with a file like 
/var/lib/ceph/$type/.../{upstart,systemd,sysvinit} indicating which init 
system is responsible for starting/stopping them.  This is necesary mainly 
because on most systems they *do* coexist--at least with sysvinit scripts.

Owen, this is basically what ceph-detect-init is doing now, right?

IIRC the users are:

 - ceph-disk, when creating a new osd
 - ceph-deploy, when deploying a mon or mds or rgw

Thanks!
sage

