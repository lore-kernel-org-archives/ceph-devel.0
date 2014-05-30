From: Sage Weil <sage@inktank.com>
Subject: Re: Librbd licensing
Date: Fri, 30 May 2014 10:43:21 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1405301042200.11044@cobra.newdream.net>
References: <loom.20140530T192820-478@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45695 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751776AbaE3RnW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 30 May 2014 13:43:22 -0400
In-Reply-To: <loom.20140530T192820-478@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Steve Taylor <steveftaylor@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi Steve,

On Fri, 30 May 2014, Steve Taylor wrote:
> I am working with a company that wants to utilize librbd in a project to
> interact with Ceph storage. For the purposes of this integration,
> LGPL-licensed open source code is acceptable, but GPL-licensed code is not.
> Well, at least not without other changes to the project, which can be
> accomplished if necessary.
> 
> The COPYING file distributed with the Ceph source code seems to indicate
> that librbd would fall under LGPL 2.1, but some of the source files in
> librbd reference GPL 2.1 in their copyright headers.

Which files?  If there are disparities we should correct them. To the best 
of my knowledge everything in librbd is LGPL.

Thanks!
sage


> 
> >From what I have found so far, it appears to me that the sources in
> question were probably originally LGPL, but were switched to GPL a few
> years back to comply with FUSE licensing, which is GPL. Is my understanding
> correct that these librbd source files are now GPL? If so and FUSE is the
> reason behind it, is it possible to dual-license those files so they could
> be LGPL when not used with FUSE?
> 
> I just want to make sure I understand the licensing properly. I apologize
> if this has been discussed previously. I am new to the list and can't seem
> to get the archive search feature to work.
> 
> Steve
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
