From: Sage Weil <sage@newdream.net>
Subject: Re: xio messenger is not building by default
Date: Fri, 13 Mar 2015 16:44:53 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1503131642080.30090@cobra.newdream.net>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F28CA2435@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36791 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751289AbbCMXoy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 13 Mar 2015 19:44:54 -0400
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F28CA2435@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, 13 Mar 2015, Somnath Roy wrote:
> Hi Sage,
> Why we are not building xio messenger by default like other experimental features ?
> Let me know if you want to, I can put a patch in.

This is a build/packaging issue.  I think right now libxio needs to be 
present at build time and it's not available in any of the distros we 
build for.  Usually what we do in this situation is embed it as a git 
submodule (like we do with rocksdb).  Happy to take patches that do that 
if that's the best route (I suspect it is?).  There'll be a few final 
tweaks in the build environment then to set up the git repo mirror but 
nothing major.

I'd look at how things are handled with rocksdb now as a model?

sage
