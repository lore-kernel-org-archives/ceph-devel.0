From: Sage Weil <sweil@redhat.com>
Subject: Re: RHEL 6.5 shared library upgrade safety
Date: Mon, 18 Aug 2014 08:17:35 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1408180816390.28244@cobra.newdream.net>
References: <53F1EA1C.1020108@dachary.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55818 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750789AbaHRPRg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Aug 2014 11:17:36 -0400
In-Reply-To: <53F1EA1C.1020108@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, 18 Aug 2014, Loic Dachary wrote:
> Hi Ceph,
> 
> In RHEL 6.5, is the following scenario possible : 
> 
> a) an OSD dlopen a shared library for erasure-code, 
> b) the shared library file is replaced while the OSD is running, 
> c) the OSD starts using the new file instead of the old one. 
> 
> It seems unlikely but it would explain a weird stack trace at 
> http://tracker.ceph.com/issues/9153#note-5 so I'm double checking ;-)

I think this is possible and likely.  We had similar problems with the 
rados classes and eventually just made them load all available plugins on 
startup (and also on demand in case one is installed later).

The simplest thing is probably to do that here as well...

sage
