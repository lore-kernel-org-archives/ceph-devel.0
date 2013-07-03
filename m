From: Sage Weil <sage@inktank.com>
Subject: Re: HA: wip-libcephfs rebased and pulled up to v.65
Date: Wed, 3 Jul 2013 09:05:23 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1307030901030.31503@cobra.newdream.net>
References: <515941372.160.1372801066160.JavaMail.root@thunderbeast.private.linuxbox.com>, <alpine.DEB.2.00.1307021616570.3375@cobra.newdream.net> <941FC8BE87ADE64D90E4EB6CD554517710022A7C@EPBYMINSA0032.epam.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35431 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932369Ab3GCQFZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Jul 2013 12:05:25 -0400
In-Reply-To: <941FC8BE87ADE64D90E4EB6CD554517710022A7C@EPBYMINSA0032.epam.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Storozhilov <Ilya_Storozhilov@epam.com>
Cc: "Matt W. Benjamin" <matt@linuxbox.com>, ceph-devel <ceph-devel@vger.kernel.org>, aemerson <aemerson@linuxbox.com>, David Zafman <david.zafman@inktank.com>

On Wed, 3 Jul 2013, Ilya Storozhilov wrote:
> Hi Sage,
> 
> Andrey has amended our changes according to you comments except one 
> regarding re-fetching xattrs from the MDS after setting or removal the 
> extended attribute of the filesystem object, cause it just requires some 
> resources we do not have at the moment (Andrey is sick till Thursday) - 
> you can check Andrey's commits here: 
> https://github.com/ferustigris/ceph/commits/open_by_handle_api. Other 
> staff, including xattrs unit tests have been implemented.
> 
> Does it possible to rebase our current changes on top of this and to 
> implement re-fetching of xattrs from MDS later, cause I suspect we are 
> not able to complete it till Monday?

Sounds good; just ping me when the rebased branch is there.  I think the 
xattr pieces can wait.

Thanks!
sage

> 
> Best regards,
> Ilya
> ________________________________________
> ??: Sage Weil [sage@inktank.com]
> ??????????: 3 ???? 2013 ?. 3:19
> To: Matt W. Benjamin; Ilya Storozhilov
> Cc: ceph-devel; aemerson; David Zafman
> ????: Re: wip-libcephfs rebased and pulled up to v.65
> 
> Hi Matt,
> 
> On Tue, 2 Jul 2013, Matt W. Benjamin wrote:
> > Hi Sage (et al),
> >
> > We have rebased the former wip-libcephfs branch, on the model of the
> > rebased example branch, as planned, and also pulled it up to Ceph's
> > v65 tag/master, also as planned.
> >
> > In addition to cross checking this, Adam has updated our Ganesha client
> > driver to use the ll v2 API, and this checks out.
> >
> > We've pushed wip-libcephfs-rebased-v65 to our public git repository,
> > https://github.com/linuxbox2/linuxbox-ceph, for review.
> 
> I made a couple comments on github with small nits.  In the meantime, I'm
> going to run this through our fs test suite.
> 
> Looks good!
> 
> Ilya, do you want to rebase your changes on top of this?  It would be
> great to get both sets of changes in before the dumpling feature freeze
> (Monday!).
> 
> Thanks!
> sage
> 
> 
