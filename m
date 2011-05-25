From: Sage Weil <sage@newdream.net>
Subject: Re: CRUSH again
Date: Wed, 25 May 2011 09:03:09 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1105250901030.29945@cobra.newdream.net>
References: <4DDCF375.7010109@ufm.su>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36751 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757898Ab1EYQBq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 May 2011 12:01:46 -0400
In-Reply-To: <4DDCF375.7010109@ufm.su>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fyodor Ustinov <ufm@ufm.su>
Cc: ceph-devel@vger.kernel.org

On Wed, 25 May 2011, Fyodor Ustinov wrote:
> Hi!
> 
> Again few questions.
> 
> 1. What is the difference between "uniform | list | tree | straw" bucket type?

There is a full discussion in the CRUSH paper linked from the publications 
tab on the web site.  Basically, use uniform if the bucket has fixed size 
and equally weighted items.  The rest of the time you're probably best off 
with straw.

> 2. Replication chunk can not be placed on different devices on the same host
> and on different hosts on the same rack? Or only rack? Or only host?
>
> 3. What isthe difference between host and rack except nesting levels?

It depends on how you structure your crush map and rules.  You can name 
the bucket types whatever you want and make the placement rule separate 
replicas across whatever level of the hierarchy you want.  Grouping by 
host and then rack probably makes the most sense for most installations.  
Then separate across either hosts or racks (depending on how big the 
cluster is).  

sage
