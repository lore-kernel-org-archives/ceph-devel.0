From: Sage Weil <sage@inktank.com>
Subject: Re: Ceph question
Date: Sun, 8 Jul 2012 21:13:22 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1207082107200.13271@cobra.newdream.net>
References: <CALLwk6t2RXyRN6Kvc4s21pQRLZxYhrAkf01MxbOOuTP6dOu8aA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45029 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750767Ab2GIENZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Jul 2012 00:13:25 -0400
In-Reply-To: <CALLwk6t2RXyRN6Kvc4s21pQRLZxYhrAkf01MxbOOuTP6dOu8aA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: HarmeekSingh Bedi <harmeeksingh@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Sun, 8 Jul 2012, HarmeekSingh Bedi wrote:
> Hi there.
> 
>   Quick question - I was looking at the code to understand the CRUSH
> placement based on unique bijection based on the prime number
> generation - I looked at the code and could not locate the specific
> code where we generate p > m as described in the papers.
> bucket_perm_choose seems to be use "jenkins" hash function to choose a
> permutation that is different from the paper ? Would the code still
> generate a unique bijection from set {1....m} -> some permutation of
> the same set to garauntee that the replica is not placed on the same
> sub-cluster devices
> 
> Am I missing something here? Kindly help me understand.

The original code used the prime number arithmetic to generate a 
permutation, but the current code does not; the prime number method did 
not in fact generate a purely uniform distribution, but favored certain 
choices.

In fact, the current implementation is not perfect either (although it is 
better), as later items in the permuted set are more likely to be swapped 
at least once.

In reality, it probably doesn't matter much.  Ceph uses 'straw' buckets by 
default (not uniform buckets), which do not have these problems, and are 
more flexible in general.  The computation cost of doing so is highly 
unlikely to be significant.

sage
