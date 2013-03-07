From: Greg Farnum <greg@inktank.com>
Subject: Re: changes to rados command
Date: Thu, 7 Mar 2013 12:55:23 -0800
Message-ID: <74BC2630EA0146BEA60A73393B40F964@inktank.com>
References: <20130307192522.0F7C7EAF31@ningd5.research.att.com>
 <B48B0643D9BB4AB2A1798C68B52481F7@inktank.com>
 <ED04914F-28E0-4641-B00F-147CC757B184@research.att.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f44.google.com ([209.85.210.44]:64768 "EHLO
	mail-da0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757176Ab3CGUz0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Mar 2013 15:55:26 -0500
Received: by mail-da0-f44.google.com with SMTP id z20so98223dae.31
        for <ceph-devel@vger.kernel.org>; Thu, 07 Mar 2013 12:55:26 -0800 (PST)
In-Reply-To: <ED04914F-28E0-4641-B00F-147CC757B184@research.att.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrew Hume <andrew@research.att.com>
Cc: ceph-devel@vger.kernel.org

(Re-added the list for future reference)

Well, you'll need to learn how to use git at a basic level in order to be able to work effectively on Ceph (or most other open-source projects).
Some links that might be helpful:
http://www.joelonsoftware.com/items/2010/03/17.html
http://www.ibm.com/developerworks/library/l-git-subversion-1/
http://try.github.com/

I haven't been through these all thoroughly, but the first one should describe the mental model changes that motivate git, the second looks to be a deep tutorial, and the third will teach you the mechanics. :)


Github pull requests are a Github nicety; their website will teach you how to use them. A simple git URL just requires that your git repository be accessible over the internet, and then you tell us what the URL is and what branch to pull from, and we can do so. (This of course requires that your changes actually be in a branch, so you'll need to have the commits arranged nicely and such.)
-Greg


On Thursday, March 7, 2013 at 12:42 PM, Andrew Hume wrote:

> i don't know how to do teh first two (but i am a quickish learner).
> i know how to type git diff | mail already.
> if you can guide me a little on how to do teh git things, i'll do those.
> 
> 
> On Mar 7, 2013, at 1:37 PM, Greg Farnum wrote:
> > On Thursday, March 7, 2013 at 11:25 AM, Andrew Hume wrote:
> > > 
> > > in order to make the rados command more useful in scripts,
> > > i'd like to make a change, specifically change to
> > > 
> > > rados -p pool getomapval obj key [fmt]
> > > 
> > > where fmt is an optional formatting parameter.
> > > i've implemented 'str' which will print the value as an unadorned string.
> > > 
> > > what is the process for doing this?
> > Patch submission, you mean? Github pull requests, sending a pull request with git URL to the list, or sending straight patches the list are all good. I'll like you more if you give me a URL of some form instead of making me get the patches out of email and into my git repo correctly, though. :)
> > -Greg
> > Software Engineer #42 @ http://inktank.com | http://ceph.com
> > 
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org (mailto:majordomo@vger.kernel.org)
> > More majordomo info at http://vger.kernel.org/majordomo-info.html
> 
> 
> 
> -----------------------
> Andrew Hume
> 623-551-2845 (VO and best)
> 973-236-2014 (NJ)
> andrew@research.att.com (mailto:andrew@research.att.com)



