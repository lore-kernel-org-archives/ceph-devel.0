From: Sage Weil <sweil@redhat.com>
Subject: Re: Sizes of attributes and attributenames....
Date: Tue, 31 May 2016 09:34:42 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1605310931180.6221@cpach.fuggernut.com>
References: <eeeec6f0-3aff-e1e1-8e85-5e7922fa2e15@digiware.nl> <alpine.DEB.2.11.1605310854550.6221@cpach.fuggernut.com> <b1234938-8f3c-5c28-7a04-7a3cd00438a3@digiware.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44605 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754224AbcEaNeV (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 31 May 2016 09:34:21 -0400
In-Reply-To: <b1234938-8f3c-5c28-7a04-7a3cd00438a3@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: ldachary@redhat.com, Ceph Development <ceph-devel@vger.kernel.org>

On Tue, 31 May 2016, Willem Jan Withagen wrote:
> On 31-5-2016 14:55, Sage Weil wrote:
> > On Tue, 31 May 2016, Willem Jan Withagen wrote:
> >>
> >> Hi,
> >>
> >> I'm getting bitten in tests/ceph-disk.sh by.
> >>
> >>  2 osd.0 0 boot
> >> -1 osd.0 0 backend (filestore) is unable to support max object
> >> name[space] len
> >> -1 osd.0 0    osd max object name len = 2048
> >> -1 osd.0 0    osd max object namespace len = 256
> >> -1 osd.0 0 (63) File name too long
> >>  1 journal close test-ceph-disk/dir/journal
> >> -1  ** ERROR: osd init failed: (63) File name too long	
> >>
> >> And it seems that I did have this fixed in one run or another, but now
> >> it raises it scary head again.
> >> Now I think it is posible to fix this by starting vstart -short, but
> >> that does not cut it with other tests, so it seems.
> > 
> > I think we either need to do --short unconditionally for the make check 
> > vstart tests, or have an environment variable that does it conditionally.  
> > I'm inclined to do it unconditionally...  Loic, does that seem 
> > reasonable?  That way make check can work reliably on ext4.
> 
> I've now "fixed" it, rather bluntly, in:
> common/config_opts.h, like:
> 
> #if defined(__FreeBSD__)
> // Assuming ZFS
> OPTION(filestore_max_inline_xattr_size_other, OPT_U32, 2048)
> #else
> OPTION(filestore_max_inline_xattr_size_other, OPT_U32, 512)
> #endif
> 
> While that works for my porting and testing, I would definitely not
> consider that a permanent band-aid.

Ah, I think this is the right direction.  Instead of redefining 
other, though, can you add a _zfs option (like the other types) and update 
the code to use that if the fs type is zfs?

> Now the future problem occurs if people are going to connect OSDs to the
> cluster that are of different origine. Like we now have a few nodes running:
> DISTRIB_ID=Ubuntu
> DISTRIB_RELEASE=14.04
> DISTRIB_CODENAME=trusty
> DISTRIB_DESCRIPTION="Ubuntu 14.04.4 LTS"
> running on btrfs (that is the way things started here, me being a ZFS fan)

These options are a layer down from the configured limits.  The 
(presumably cluster-wide) config option will specify what name length 
limits are set, and individual osds will refuse to start if they can't 
support that given what they believe the backend fs cna do (based on the 
above options).

sage

