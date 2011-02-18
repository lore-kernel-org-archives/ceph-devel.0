From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: C vs C++ APIs
Date: Fri, 18 Feb 2011 13:21:53 -0800
Message-ID: <AF86DA6B-D189-4746-9BDC-79A67314C64B@cs.ucsc.edu>
References: <Pine.LNX.4.64.1102181309590.13848@cobra.newdream.net>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:41687 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753389Ab1BRVas convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Feb 2011 16:30:48 -0500
In-Reply-To: <Pine.LNX.4.64.1102181309590.13848@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org


On Feb 18, 2011, at 1:14 PM, Sage Weil wrote:

> I see a few options...

This might be a completely inappropriate question :), ....since there is ostensibly an in-kernel rados client supporting rbd, why not use a pure-C rados client in userspace, and build whatever C++ API on top of this?

-noah

