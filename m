From: "Matt W. Benjamin" <matt@cohortfs.com>
Subject: Re: xio messenger is not building by default
Date: Mon, 16 Mar 2015 12:20:29 -0400 (EDT)
Message-ID: <2079341836.20.1426522829406.JavaMail.root@thunderbeast.private.linuxbox.com>
References: <5506E615.30807@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from aa.linuxbox.com ([69.128.83.226]:2343 "EHLO aa.linuxbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753230AbbCPQUn (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 16 Mar 2015 12:20:43 -0400
In-Reply-To: <5506E615.30807@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>
Cc: ceph-devel@vger.kernel.org, Sage Weil <sage@newdream.net>, Somnath Roy <Somnath.Roy@sandisk.com>

Hi,

Arent OFED dependencies already packaged?  I assumed that only Accelio would
be a submodule.

Matt

----- "Ken Dreyer" <kdreyer@redhat.com> wrote:

> On 03/13/2015 05:44 PM, Sage Weil wrote:
> > On Fri, 13 Mar 2015, Somnath Roy wrote:
> >> Hi Sage,
> >> Why we are not building xio messenger by default like other
> experimental features ?
> >> Let me know if you want to, I can put a patch in.
> > 
> > This is a build/packaging issue.  I think right now libxio needs to
> be 
> > present at build time and it's not available in any of the distros
> we 
> > build for.  Usually what we do in this situation is embed it as a
> git 
> > submodule (like we do with rocksdb).  Happy to take patches that do
> that 
> > if that's the best route (I suspect it is?).  There'll be a few
> final 
> > tweaks in the build environment then to set up the git repo mirror
> but 
> > nothing major.
> > 
> > I'd look at how things are handled with rocksdb now as a model?
> > 
> 
> What are the packages that we would need in the distros? From
> README.xio, it looks like we'd need the following to be packaged:
> 
> https://www.openfabrics.org/downloads/verbs/
> https://github.com/accelio/accelio
> 
> Is there anything else that's missing?
> 
> - Ken
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Matt Benjamin
CohortFS, LLC.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://cohortfs.com

tel.  734-761-4689 
fax.  734-769-8938 
cel.  734-216-5309 
