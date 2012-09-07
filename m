From: Sage Weil <sage@inktank.com>
Subject: Re: Telling an osd to reload a cls library
Date: Fri, 7 Sep 2012 08:51:16 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1209070849260.9861@cobra.newdream.net>
References: <CAEVWPAVfRk-2pg0RATzH8ph0zqXWrodm4viWhjDHJh3+P-zh7g@mail.gmail.com> <50494C6B.5090005@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35289 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750746Ab2IGPva (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Sep 2012 11:51:30 -0400
In-Reply-To: <50494C6B.5090005@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: Ian Pye <ianpye@gmail.com>, ceph-devel@vger.kernel.org

On Thu, 6 Sep 2012, Josh Durgin wrote:
> On 09/06/2012 06:17 PM, Ian Pye wrote:
> > Hi,
> > 
> > Is there a way to tell an osd to reload a cls.so file without
> > re-starting the osd?
> > 
> > Thanks,
> > 
> > Ian
> 
> Not right now, although there could be an admin socket or
> 'ceph osd tell' command to do so I guess.

In order to make this work right, I think ClassHandler needs to be updated 
to return a shared_ptr<> to ClassData and make the ~ClassData do a 
dlclose()... or something along those lines so that a reload won't screw 
up other threads that are currently executing the class you're trying to 
close.

The 'reload' is mostly just a 'close', since on the next request it will 
get loaded automatically (tho it could do an explicit load so that you see 
any errors immediately).

sage
