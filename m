From: Janne Grunau <j@jannau.net>
Subject: Re: [PATCH v3 0/4] buffer alignment for erasure code SIMD
Date: Thu, 2 Oct 2014 14:15:31 +0200
Message-ID: <20141002121531.GO2542@jannau.net>
References: <1410796508-28711-1-git-send-email-j@jannau.net>
 <1411994072-18850-1-git-send-email-j@jannau.net>
 <CANP1eJGxY8wR4smOfZ49+1dwjWCU7FrdbOG4UvMJR7UP77UX4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from soltyk.jannau.net ([185.27.253.110]:38169 "EHLO
	soltyk.jannau.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751219AbaJBMPc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Oct 2014 08:15:32 -0400
Content-Disposition: inline
In-Reply-To: <CANP1eJGxY8wR4smOfZ49+1dwjWCU7FrdbOG4UvMJR7UP77UX4g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Milosz Tanski <milosz@adfin.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

On 2014-09-29 11:18:03 -0400, Milosz Tanski wrote:
> Janne, I have a couple questions and forgive me if I missed something
> from the past.
> 
> Did you consider using std::aligned_storage? That way you don't have
> to worry as much about portability yourself. Also, there is a
> boost::aligned_storage as well if Ceph can't build against C++11
> goodness.

no. I'm more familiar with C than C++ so those are not in my active 
C/C++ vocabulary.

Janne
