From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: xio messenger is not building by default
Date: Mon, 16 Mar 2015 08:17:57 -0600
Message-ID: <5506E615.30807@redhat.com>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F28CA2435@SACMBXIP01.sdcorp.global.sandisk.com> <alpine.DEB.2.00.1503131642080.30090@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45712 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932638AbbCPOR7 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 16 Mar 2015 10:17:59 -0400
In-Reply-To: <alpine.DEB.2.00.1503131642080.30090@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, Somnath Roy <Somnath.Roy@sandisk.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 03/13/2015 05:44 PM, Sage Weil wrote:
> On Fri, 13 Mar 2015, Somnath Roy wrote:
>> Hi Sage,
>> Why we are not building xio messenger by default like other experimental features ?
>> Let me know if you want to, I can put a patch in.
> 
> This is a build/packaging issue.  I think right now libxio needs to be 
> present at build time and it's not available in any of the distros we 
> build for.  Usually what we do in this situation is embed it as a git 
> submodule (like we do with rocksdb).  Happy to take patches that do that 
> if that's the best route (I suspect it is?).  There'll be a few final 
> tweaks in the build environment then to set up the git repo mirror but 
> nothing major.
> 
> I'd look at how things are handled with rocksdb now as a model?
> 

What are the packages that we would need in the distros? From
README.xio, it looks like we'd need the following to be packaged:

https://www.openfabrics.org/downloads/verbs/
https://github.com/accelio/accelio

Is there anything else that's missing?

- Ken
