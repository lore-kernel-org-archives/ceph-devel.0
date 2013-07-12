From: Sage Weil <sage@inktank.com>
Subject: Re: wip-libcephfs rebased and pulled up to v.65
Date: Fri, 12 Jul 2013 08:50:42 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1307120850280.25223@cobra.newdream.net>
References: <941FC8BE87ADE64D90E4EB6CD5545177100231F4@EPBYMINSA0032.epam.com>,  <78k3kyfjv2.wl%aemerson@linuxbox.com> <941FC8BE87ADE64D90E4EB6CD554517710023305@EPBYMINSA0032.epam.com>, <alpine.DEB.2.00.1307111201000.5149@cobra.newdream.net>
 <941FC8BE87ADE64D90E4EB6CD5545177100234DD@EPBYMINSA0032.epam.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54494 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933072Ab3GLPum (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 12 Jul 2013 11:50:42 -0400
In-Reply-To: <941FC8BE87ADE64D90E4EB6CD5545177100234DD@EPBYMINSA0032.epam.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Storozhilov <Ilya_Storozhilov@epam.com>
Cc: "Adam C. Emerson" <aemerson@linuxbox.com>, "Matt W. Benjamin" <matt@linuxbox.com>, David Zafman <david.zafman@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, 12 Jul 2013, Ilya Storozhilov wrote:
> Hi Sage, Adam, Matt and David,
> 
> we have resolved a couple of compilation issues in 'wip-libcephfs' 
> branch and have created a respective pull request, see 
> https://github.com/ceph/ceph/pull/424

Thanks, i'll squash these down into the relevant commits.
> 
> Regards,
> Ilya
> 
> P.S. I'm going on vacation for the next week, so keep connected with Andrey Kuznetsov (Andrey_Kuznetsov@epam.com) during this period, please.
> 
> ________________________________________
> ??: Sage Weil [sage@inktank.com]
> ??????????: 11 ???? 2013 ?. 23:01
> To: Ilya Storozhilov
> Cc: Adam C. Emerson; Matt W. Benjamin; David Zafman; ceph-devel@vger.kernel.org
> ????: Re: wip-libcephfs rebased and pulled up to v.65
> 
> Please check out the current wip=libcephfs branch and let me know how it
> looks/works for you guys.  I cleaned up your patches a bit and fixed teh
> root cause of the xattr issue you were seeing.
> 
> Thanks!
> sage
> 
> 
> On Thu, 11 Jul 2013, Ilya Storozhilov wrote:
> 
> > Hi Adam (CC: Sage, Matt and David),
> >
> > it seems to me we have choosen a bad commit description, where instead of "FIX: readlink not copy link path to user's buffer" there should be something like "FIX: ceph_ll_readlink() now fills user provided buffer with the link data instead of returning a pointer to the libcephfs internal memory location". Take a look to the sourcecode - it does actually what you are talking about (see https://github.com/ferustigris/ceph/blob/wip-libcephfs-rebased-v65/src/libcephfs.cc):
> >
> > -----------------------------------------------------------------------
> > extern "C" int ceph_ll_readlink(struct ceph_mount_info *cmount, Inode *in, char *buf, size_t bufsiz, int uid, int gid)
> > {
> >   const char *value = NULL;
> >   int res = (cmount->get_client()->ll_readlink(in, &value, uid, gid));
> >   if (res < 0)
> >     return res;
> >   if (bufsiz < (size_t)res)
> >     return ENAMETOOLONG;
> >   memcpy(buf, value, res);  // <-- Here we are copying a link data to the user provided buffer. This is what you want us to do.
> >   return res;
> > }
> > -----------------------------------------------------------------------
> >
> > In your branch (see https://github.com/linuxbox2/linuxbox-ceph/blob/wip-libcephfs-rebased-v65/src/libcephfs.cc) this function does not copy link data to the user-provided buffer, but passes back a pointer to the internal libcephfs structure, which is not good solution, as you mentioned below:
> >
> > -----------------------------------------------------------------------
> > extern "C" int ceph_ll_readlink(struct ceph_mount_info *cmount, Inode *in, char **value, int uid, int gid)
> > {
> >   return (cmount->get_client()->ll_readlink(in, (const char**) value, uid, gid));
> > }
> > -----------------------------------------------------------------------
> >
> > Regards,
> > Ilya
> >
> > ________________________________________
> > ??: Adam C. Emerson [aemerson@linuxbox.com]
> > ??????????: 10 ???? 2013 ?. 20:41
> > To: Ilya Storozhilov
> > Cc: Sage Weil; Matt W. Benjamin; David Zafman
> > ????: Re: wip-libcephfs rebased and pulled up to v.65
> >
> > At Wed, 10 Jul 2013 12:17:24 +0000, Ilya Storozhilov wrote:
> > [snip]
> > > ?wip-libcephfs-rebased-v65? branch of the https://github.com/linuxbox2/linuxbox-ceph repository has not been branched from the ?wip-libcephfs? branch of https://github.com/ceph/ceph as it was made with our ?open_by_handle_api? branch of the https://github.com/ferustigris/ceph repo. That is why we were not able to automatically ?cherry-pick? our changes using respective git command. So we have manually applied our changes to the ?wip-libcephfs-rebased-v65? branch in https://github.com/ferustigris/ceph repo as one commit - you can check it out here: https://github.com/ferustigris/ceph/commit/c3f4940b2cfcfd3ea9a004e6f07f1aa3c0b6c419.
> > [snip]
> >
> > Good afternoon, sir.
> >
> > I was looking at your patch and Matt and I have concerns about the
> > change you made to readlink.  By passing back a pointer to a buffer
> > rather than copying the link into a supplied buffer, we're opening
> > ourselves up to the content changing, being deallocated, or otherwise
> > having something bad happen to it.
> >
> > Thanks.
> >
> >
> 
> 
