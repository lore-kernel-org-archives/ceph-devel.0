From: Sage Weil <sage@newdream.net>
Subject: Re: C vs C++ APIs
Date: Fri, 18 Feb 2011 13:25:21 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1102181324110.13848@cobra.newdream.net>
References: <Pine.LNX.4.64.1102181309590.13848@cobra.newdream.net>
 <AF86DA6B-D189-4746-9BDC-79A67314C64B@cs.ucsc.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45442 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751062Ab1BRVX5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Feb 2011 16:23:57 -0500
In-Reply-To: <AF86DA6B-D189-4746-9BDC-79A67314C64B@cs.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: ceph-devel@vger.kernel.org

On Fri, 18 Feb 2011, Noah Watkins wrote:
> On Feb 18, 2011, at 1:14 PM, Sage Weil wrote:
> 
> > I see a few options...
> 
> This might be a completely inappropriate question :), ....since there is 
> ostensibly an in-kernel rados client supporting rbd, why not use a 
> pure-C rados client in userspace, and build whatever C++ API on top of 
> this?

Then you depend on the kernel support.

The main benefit of the C++ API is the bufferlists (used internally), 
which can avoid memory copies between the library user and the library.

sage
