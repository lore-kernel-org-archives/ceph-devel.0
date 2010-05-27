From: Sage Weil <sage@newdream.net>
Subject: Re: ceph.spec for Centos 5
Date: Thu, 27 May 2010 14:26:38 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1005271424210.27661@cobra.newdream.net>
References: <htlluv$70g$2@dough.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45432 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932556Ab0E0V0g (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 May 2010 17:26:36 -0400
In-Reply-To: <htlluv$70g$2@dough.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Thomas Mueller <thomas@chaschperli.ch>
Cc: ceph-devel@vger.kernel.org

Hi Thomas,

On Thu, 27 May 2010, Thomas Mueller wrote:
> hi 
> 
> i've took the ceph.spec from the 0.20.1 tar.gz and modified it to work 
> with Centos 5.
> 
> i've sucessfully built/installed/uninstalled the package (but not tried 
> to use it yet)
> 
> get the .spec file here:
> http://pastebin.com/JBSBWUbB

Thanks.

It looks like your changes are all RHEL <= 5, Fedora <= 9 specific, with 
the exception of the build-requires changes, which I've updated in git.  
If I'm missing something, let me know--I don't use the rpms myself.  (The 
ceph.spec in git is what's being used for Fedora 13.)

sage
