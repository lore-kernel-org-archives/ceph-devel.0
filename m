From: Sage Weil <sage@newdream.net>
Subject: Re: rbd speed: write vs read
Date: Fri, 6 May 2011 09:08:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1105060906440.9905@cobra.newdream.net>
References: <4DC40249.7020903@ufm.su>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59939 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751293Ab1EFQHq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 May 2011 12:07:46 -0400
In-Reply-To: <4DC40249.7020903@ufm.su>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fyodor Ustinov <ufm@ufm.su>
Cc: ceph-devel@vger.kernel.org

On Fri, 6 May 2011, Fyodor Ustinov wrote:
> Hi!
> 
> oops. This my misconfiguration.

Out of curiousity, what was the misconfiguration?

Doing a streaming read in 10MB chunks when RBD is striped over 4MB 
objects won't be terribly efficient.  You should get the best sync read 
performance when the object sizes match up.  You'll get better performance 
if whatever is sitting above the block layer dispatches multiple read 
requests in parallel (i.e. something smarter than dd, like a file system).

sage
