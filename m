From: Sage Weil <sage@newdream.net>
Subject: Re: PATCH: add dkms support
Date: Wed, 7 Jul 2010 08:07:14 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1007070806110.23002@cobra.newdream.net>
References: <i11gng$mk1$2@dough.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:38841 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755606Ab0GGPFf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Jul 2010 11:05:35 -0400
In-Reply-To: <i11gng$mk1$2@dough.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Thomas Mueller <thomas@chaschperli.ch>
Cc: ceph-devel@vger.kernel.org

On Wed, 7 Jul 2010, Thomas Mueller wrote:
> hi
> 
> i've added DKMS support to the ceph-client-standalone git repo.  DKMS 
> enables drivers to be automatically rebuilt when a new kernel is 
> installed. 
> 
> the patch is based on my other patch "link ceph-client version to kernel 
> version"
> 
> Changes:
> * rewrote hole debian/ dir based on ipeth-dkms package
> * added dkms.conf
> * added dkms/ dir with pre/post scripts
> * fixed build_upload_debian_package.sh for the new package name
> 
> get patch here:
> http://chaschperli.ch/debian/ceph-client-standalone-dkms.patch

This is great!  Let's just sort out the versioning stuff first, then we 
can hopefully get the dkms package reviewed and pushed into debian sid.

sage
