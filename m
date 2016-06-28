From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: cmake
Date: Tue, 28 Jun 2016 09:35:39 +0200
Message-ID: <94aeab09-6e86-9e94-5a96-d8e477b85cad@digiware.nl>
References: <alpine.DEB.2.11.1606271746590.2844@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:25720 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750704AbcF1Hfz (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 28 Jun 2016 03:35:55 -0400
In-Reply-To: <alpine.DEB.2.11.1606271746590.2844@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, ceph-devel@vger.kernel.org

On 27-6-2016 19:50, Sage Weil wrote:
> We are switching from autotools to cmake on the master branch. Any 
> builds done post-jewel will be cmake and not autotools based.  Jewel and 
> older releases will still be built with autotools the old way.
> 
> The README.md in the master branch has been updated with new developer 
> build instructions.  Please take a look:
> 
> 	https://github.com/ceph/ceph/blob/master/README.md
> 
> If you are doing development, please switch to using cmake (i.e., 
> run do_cmake.sh) now.  Running vstart.sh is a little different and it 
> takes some getting used to.
> 
> If there is anything that doesn't work that is part of your developer 
> workflow, we need to fix it now, before the autotools support is removed 
> and you're unable to work!  This is hopefully a week or two away.

Hi Sage,

Although i appreciate and understand the desire to move to cmake.
Really ripping out the automake stuff would put me in the situation
where I have no more building environment until all the cmake tweaks for
FreeBSD are in place.

An while I'll start working on it, time is rather scarce atm.
So please disable but please keep it around for a bit longer...

Thanx,
--WjW


