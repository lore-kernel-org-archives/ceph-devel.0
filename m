From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: ceph_setattr mask
Date: Tue, 14 Feb 2012 10:48:37 -0800
Message-ID: <4EE4DFDB-50B9-44C5-850A-209A661ADF2B@cs.ucsc.edu>
References: <C5CEE4B7-2D43-48F4-B741-8AB23C62D039@cs.ucsc.edu> <CAF3hT9A-n9yVWQExONF2T0ODwZRLeoVe6bi3qTFY9EEGeWBv+A@mail.gmail.com> <6E946A5C-EC6F-4D3F-9D37-1CA6A640AF55@cs.ucsc.edu> <Pine.LNX.4.64.1202140902450.1554@cobra.newdream.net>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:51363 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754994Ab2BNSsi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Feb 2012 13:48:38 -0500
In-Reply-To: <Pine.LNX.4.64.1202140902450.1554@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org


On Feb 14, 2012, at 9:03 AM, Sage Weil wrote:

>> 
>> java-libcephfs has a build dependency on libcephfs-dev deb that only 
>> contains libcephfs.h. These flags must be available during build and it 
>> seems to make little sense to add another header just for these bits. So 
>> as far as moving vs copying I'm not sure, but exposing all of ceph_fs.h 
>> seems like overkill.
> 
> The simplest thing is to probably duplicate them (with an #ifndef guard) 
> in libcephfs.h.  I'll push something to do that now.

Works great. Thanks.

- Noah
