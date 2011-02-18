From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: C vs C++ APIs
Date: Fri, 18 Feb 2011 13:28:17 -0800
Message-ID: <2BED54EA-8D0F-497F-B5C5-8314ACE9E168@cs.ucsc.edu>
References: <Pine.LNX.4.64.1102181309590.13848@cobra.newdream.net> <AF86DA6B-D189-4746-9BDC-79A67314C64B@cs.ucsc.edu> <Pine.LNX.4.64.1102181324110.13848@cobra.newdream.net>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:46844 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752645Ab1BRV2S convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Feb 2011 16:28:18 -0500
In-Reply-To: <Pine.LNX.4.64.1102181324110.13848@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org


On Feb 18, 2011, at 1:25 PM, Sage Weil wrote:
> 
> Then you depend on the kernel support.

I guess I should have said, port the kernel client to user space, but that is probably easier said than done ;)

> The main benefit of the C++ API is the bufferlists (used internally), 
> which can avoid memory copies between the library user and the library.

This is cool. Thanks for the info.

-Noah