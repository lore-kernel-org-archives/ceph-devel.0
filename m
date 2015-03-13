From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: RE: xio messenger is not building by default
Date: Fri, 13 Mar 2015 23:53:04 +0000
Message-ID: <755F6B91B3BE364F9BCA11EA3F9E0C6F28CA2467@SACMBXIP01.sdcorp.global.sandisk.com>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F28CA2435@SACMBXIP01.sdcorp.global.sandisk.com>
 <alpine.DEB.2.00.1503131642080.30090@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1bon0096.outbound.protection.outlook.com ([157.56.111.96]:22748
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750818AbbCMXx0 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 13 Mar 2015 19:53:26 -0400
In-Reply-To: <alpine.DEB.2.00.1503131642080.30090@cobra.newdream.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hmm...I missed that part..I thought it would be a quick config fix :-(
Yes, git submodule should be the approach.

Thanks & Regards
Somnath

-----Original Message-----
From: Sage Weil [mailto:sage@newdream.net]
Sent: Friday, March 13, 2015 4:45 PM
To: Somnath Roy
Cc: ceph-devel@vger.kernel.org
Subject: Re: xio messenger is not building by default

On Fri, 13 Mar 2015, Somnath Roy wrote:
> Hi Sage,
> Why we are not building xio messenger by default like other experimental features ?
> Let me know if you want to, I can put a patch in.

This is a build/packaging issue.  I think right now libxio needs to be present at build time and it's not available in any of the distros we build for.  Usually what we do in this situation is embed it as a git submodule (like we do with rocksdb).  Happy to take patches that do that if that's the best route (I suspect it is?).  There'll be a few final tweaks in the build environment then to set up the git repo mirror but nothing major.

I'd look at how things are handled with rocksdb now as a model?

sage

________________________________

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).

