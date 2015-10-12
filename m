From: Mark Nelson <mnelson@redhat.com>
Subject: Initial performance cluster SimpleMessenger vs AsyncMessenger results
Date: Mon, 12 Oct 2015 11:50:43 -0500
Message-ID: <561BE4E3.7050404@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60251 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751101AbbJLQup (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 12 Oct 2015 12:50:45 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>
Cc: "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

Hi Guy,

Given all of the recent data on how different memory allocator 
configurations improve SimpleMessenger performance (and the effect of 
memory allocators and transparent hugepages on RSS memory usage), I 
thought I'd run some tests looking how AsyncMessenger does in 
comparison.  We spoke about these a bit at the last performance meeting 
but here's the full write up.  The rough conclusion as of right now 
appears to be:

1) AsyncMessenger performance is not dependent on the memory allocator 
like with SimpleMessenger.

2) AsyncMessenger is faster than SimpleMessenger with TCMalloc + 32MB 
(ie default) thread cache.

3) AsyncMessenger is consistently faster than SimpleMessenger for 128K 
random reads.

4) AsyncMessenger is sometimes slower than SimpleMessenger when memory 
allocator optimizations are used.

5) AsyncMessenger currently uses far more RSS memory than SimpleMessenger.

Here's a link to the paper:

https://drive.google.com/file/d/0B2gTBZrkrnpZS1Q4VktjZkhrNHc/view

Mark
