From: Sage Weil <sage@inktank.com>
Subject: Re: Memory usage of ceph-mds
Date: Wed, 19 Sep 2012 14:12:58 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1209191410380.7537@cobra.newdream.net>
References: <CANLRBoyZ5JCTfdu_ntf+aOYBPa2C4w5TLM8-2Q4_=YWg8=VL1w@mail.gmail.com> <alpine.DEB.2.00.1209191347210.7537@cobra.newdream.net> <CAPYLRziPh0+7BGxMa7e9n6QQGruRX6-58x-fnAAwYaONkOVZ1g@mail.gmail.com>
 <CANLRBoyKVk68Kxd85++WjWFr4870ihrRqWarO69V+7Pza62mXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:41030 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751780Ab2ISVM6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Sep 2012 17:12:58 -0400
In-Reply-To: <CANLRBoyKVk68Kxd85++WjWFr4870ihrRqWarO69V+7Pza62mXw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tren Blackburn <tren@eotnetworks.com>
Cc: Gregory Farnum <greg@inktank.com>, ceph-devel@vger.kernel.org

On Wed, 19 Sep 2012, Tren Blackburn wrote:
> On Wed, Sep 19, 2012 at 1:52 PM, Gregory Farnum <greg@inktank.com> wrote:
> > On Wed, Sep 19, 2012 at 1:48 PM, Sage Weil <sage@inktank.com> wrote:
> >> On Wed, 19 Sep 2012, Tren Blackburn wrote:
> >>> Hey List;
> >>>
> >>> I'm in the process of rsyncing in about 7TB of data to Ceph across
> >>> approximately 58565475 files (okay, so I guess that's not so
> >>> approximate). It's only managed to copy a small portion of this so far
> >>> (about 35GB) and the server that currently is the mds master shows the
> >>> ceph-mds process closing in on 2GB of RAM used. I'm getting a little
> >>> nervous about this steep increase.
> >>>
> >>> fern ceph # ps wwaux | grep ceph-mds
> >>> root     29943  3.7  0.9 2473884 1915468 ?     Ssl  08:42  11:22
> >>> /usr/bin/ceph-mds -i 1 --pid-file /var/run/ceph/mds.1.pid -c
> >>> /etc/ceph/ceph.conf
> >>>
> >>> Thank in advance!
> >>
> >> That's not necessarily a problem.  The mds memory usage is controlled via
> >> the 'mds cache size' knob which defaults to 100,000.  You might try
> >> halving that and restarting the MDS.
> >
> > Last time we counted those inodes were ~1KB each, so getting 2GB of
> > memory used is an awful lot.
> >
> > Tren, what does your tree look like ? are there very large directories?
> 
> Greg: It's difficult to tell you that. I'm rsyncing 2 volumes from our
> filers. Each base directory on each filer mount has approximate 213
> directories, and then each directory under that has approximately
> anywhere from 3000 - 5000 directories (very loose approximation here,
> 850,000 directories per filer mount), and then each of those
> directories contains files.
> 
> We have many many files here. We're doing this to see how CephFS
> handles lots of files. We are coming from MooseFS which its master
> metalogger process eats lots of ram, so we're hoping that Ceph is a
> bit lighter on us.
> 
> Sage: The memory the MDS is using is only a cache? There should be no
> problem restarting the MDS server while activity is going on? I should
> probably change the limit for the non-active MDS servers first, and
> then the active one and hope it fails over cleanly?

Right.  Restarting ceph-mds will do the trick.  You shouldn't have to 
adjust max_mds (leave it at 1).  Just make sure it doesn't fail over to 
another ceph-mds daemon that was started before you made the config 
change.

There is some pending work to reduce the memory footprint for in-memory 
inodes; they currently include a zillion fields used for dirty updates 
that aren't needed for clean/cached metadata.  Fixing that is a boring but 
tedious process of moving them into an auxilliary structure and will 
happen sometime soonish.  :)

sage
