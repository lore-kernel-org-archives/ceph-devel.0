From: Sage Weil <sage@newdream.net>
Subject: Re: metablob fix
Date: Mon, 20 Jun 2011 09:38:04 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1106200936030.28760@cobra.newdream.net>
References: <Pine.LNX.4.64.1106172215440.4755@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42233 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751860Ab1FTQfj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Jun 2011 12:35:39 -0400
In-Reply-To: <Pine.LNX.4.64.1106172215440.4755@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: samlang@gmail.com
Cc: ceph-devel@vger.kernel.org

On Fri, 17 Jun 2011, Sage Weil wrote:
> Hi Sam-
> 
> I pushed a fix for the valgrind error you were seeing to mds_metablob_fix.  
> There was a class used in an STL container that wasn't copyable.  As far 
> as I can tell, you can't actually put items in a container (map<> in this 
> case) that aren't copyable, so I used a boost::smart_ptr.  
> 
> Maybe someone with better C++-fu than I has a way to avoid the copies 
> entirely?  Adding
> 
> 	fullbit(const fullbit& other);
> 	const fullbit operator=(const fullbit& other);
> 
> fails to link, and if I assert in there I can't get past inserting the 
> initial element.  :/

This didn't work, btw; you can't reclaim the raw pointer from the 
shared_ptr.  That means either using shared_ptr throughout CInode (which 
does some weird stuff with it). 

Instead, I made fullbit non-copyable, and changed dirlump to use

	list<boost::shared_ptr<fullbit> >   dfull;

so that it's never copied.  In general, this is probably a better solution 
for any encoded/decoded type that is largish since it'll avoid copying the 
memory around...

sage



> 
> sage
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
