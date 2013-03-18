From: Sage Weil <sage@inktank.com>
Subject: Re: Direct IO on CephFS for blocks larger than 8MB
Date: Mon, 18 Mar 2013 14:21:33 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1303181421240.28537@cobra.newdream.net>
References: <5A908216FB901F499F602F4F9CEF5B380FEA68C3@SHSMSX102.ccr.corp.intel.com> <alpine.DEB.2.00.1303140819420.11175@cobra.newdream.net> <F9E1A4A5-FE26-460B-A228-99033A36ECF8@intel.com> <alpine.DEB.2.00.1303150931160.23110@cobra.newdream.net>
 <B0E6BFC2-292E-4EB5-BE19-FD0F670EBDE3@enovance.com> <869D592D-E098-4EB9-8F25-FC8FBF715E03@intel.com> <CANExM-Oj1ctk5i0HL-7VXd8K3oP5oUTuUWMq-2F5u4i+cHz7Ww@mail.gmail.com> <555712E2BBAC4147BF96AE32C88A1C83@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:39863 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932368Ab3CRVVd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Mar 2013 17:21:33 -0400
In-Reply-To: <555712E2BBAC4147BF96AE32C88A1C83@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Greg Farnum <greg@inktank.com>
Cc: Henry C Chang <henry.cy.chang@gmail.com>, "Huang, Xiwei" <xiwei.huang@intel.com>, Sebastien Han <sebastien.han@enovance.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Mon, 18 Mar 2013, Greg Farnum wrote:
> On Saturday, March 16, 2013 at 5:38 AM, Henry C Chang wrote:
> > The following patch should fix the problem.
> > 
> > -Henry
> > 
> > diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> > index e51558f..4bcbcb6 100644
> > --- a/fs/ceph/file.c
> > +++ b/fs/ceph/file.c
> > @@ -608,7 +608,7 @@ out:
> > pos += len;
> > written += len;
> > left -= len;
> > - data += written;
> > + data += len;
> > if (left)
> > goto more;
> 
> This looks good to me. If you'd like to submit it as a proper patch with a sign-off I'll pull it into our tree. :)
> -Greg

I just added a quick test and it fixes it up.  :)

sage
