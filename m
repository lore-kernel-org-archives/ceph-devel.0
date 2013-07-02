From: Sage Weil <sage@inktank.com>
Subject: Re: wip-libcephfs rebased and pulled up to v.65
Date: Tue, 2 Jul 2013 16:19:55 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1307021616570.3375@cobra.newdream.net>
References: <515941372.160.1372801066160.JavaMail.root@thunderbeast.private.linuxbox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:56066 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755924Ab3GBXT4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Jul 2013 19:19:56 -0400
In-Reply-To: <515941372.160.1372801066160.JavaMail.root@thunderbeast.private.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Matt W. Benjamin" <matt@linuxbox.com>, Ilya_Storozhilov@epam.com
Cc: ceph-devel <ceph-devel@vger.kernel.org>, aemerson <aemerson@linuxbox.com>, David Zafman <david.zafman@inktank.com>

Hi Matt,

On Tue, 2 Jul 2013, Matt W. Benjamin wrote:
> Hi Sage (et al),
> 
> We have rebased the former wip-libcephfs branch, on the model of the
> rebased example branch, as planned, and also pulled it up to Ceph's
> v65 tag/master, also as planned.
> 
> In addition to cross checking this, Adam has updated our Ganesha client
> driver to use the ll v2 API, and this checks out.
> 
> We've pushed wip-libcephfs-rebased-v65 to our public git repository,
> https://github.com/linuxbox2/linuxbox-ceph, for review.

I made a couple comments on github with small nits.  In the meantime, I'm 
going to run this through our fs test suite.

Looks good!

Ilya, do you want to rebase your changes on top of this?  It would be 
great to get both sets of changes in before the dumpling feature freeze 
(Monday!).

Thanks!
sage
