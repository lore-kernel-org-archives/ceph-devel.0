From: Sage Weil <sweil@redhat.com>
Subject: Re: cmake
Date: Tue, 28 Jun 2016 13:42:40 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1606281339570.8816@piezo.us.to>
References: <alpine.DEB.2.11.1606271746590.2844@piezo.us.to> <94aeab09-6e86-9e94-5a96-d8e477b85cad@digiware.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35159 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751193AbcF1Nmn (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 28 Jun 2016 09:42:43 -0400
In-Reply-To: <94aeab09-6e86-9e94-5a96-d8e477b85cad@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: ceph-devel@vger.kernel.org

On Tue, 28 Jun 2016, Willem Jan Withagen wrote:
> On 27-6-2016 19:50, Sage Weil wrote:
> > We are switching from autotools to cmake on the master branch. Any 
> > builds done post-jewel will be cmake and not autotools based.  Jewel and 
> > older releases will still be built with autotools the old way.
> > 
> > The README.md in the master branch has been updated with new developer 
> > build instructions.  Please take a look:
> > 
> > 	https://github.com/ceph/ceph/blob/master/README.md
> > 
> > If you are doing development, please switch to using cmake (i.e., 
> > run do_cmake.sh) now.  Running vstart.sh is a little different and it 
> > takes some getting used to.
> > 
> > If there is anything that doesn't work that is part of your developer 
> > workflow, we need to fix it now, before the autotools support is removed 
> > and you're unable to work!  This is hopefully a week or two away.
> 
> Hi Sage,
> 
> Although i appreciate and understand the desire to move to cmake.
> Really ripping out the automake stuff would put me in the situation
> where I have no more building environment until all the cmake tweaks for
> FreeBSD are in place.
> 
> An while I'll start working on it, time is rather scarce atm.
> So please disable but please keep it around for a bit longer...

There is no particular need to remove any of the autotools stuff while 
anyone still relies on it, so don't worry.  I'm just making sure 
everyone starts using it now so that we can identify any gaps and 
avoid surprises and fragmentation of efforts later.

Thanks for taking a look!
sage
