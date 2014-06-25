From: Sage Weil <sage@redhat.com>
Subject: Re: Speeding up ceph builds
Date: Wed, 25 Jun 2014 10:28:19 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1406251027350.12946@cobra.newdream.net>
References: <53AAE7A0.5060404@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:56925 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757446AbaFYR2T (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Jun 2014 13:28:19 -0400
In-Reply-To: <53AAE7A0.5060404@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Luis Pabon <lpabon@redhat.com>
Cc: ceph-devel@vger.kernel.org

On Wed, 25 Jun 2014, Luis Pabon wrote:
> Hi all,
>   I have tried disabling static builds which cut build time by half.  I have
> built it without static builds and they work, but I wanted to see if others
> could try it out also and determine that the software still works.  To speed
> up the build time, you can type:
> 
> ./configure --disable-static
> 
> If no one finds any issues with this mode, we can set it up as the default in
> configure.ac.
> 
> This could provide a speed up while we wait for the Cmake patch.

As a conservative first step, this

	https://github.com/ceph/ceph/pull/2025

enables it for do_autogen.sh, which will make life better for 
developers...

sage

