From: Sage Weil <sage@redhat.com>
Subject: Re: master does not compile
Date: Thu, 26 Jun 2014 10:33:28 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1406261032560.10777@cobra.newdream.net>
References: <53AC5815.3090503@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35417 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757255AbaFZRd2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Jun 2014 13:33:28 -0400
In-Reply-To: <53AC5815.3090503@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Luis Pabon <lpabon@redhat.com>
Cc: ceph-devel@vger.kernel.org

On Thu, 26 Jun 2014, Luis Pabon wrote:
> I hit this issue just now (Fedora 20).  Please confirm that this happens in
> other systems.  Travis may be able to at least help do sanity tests.

You may need to do

 git submodule update

?  I believe this change relied on a new commit in the gf-complete 
submodule.

sage

> 
> - Luis
> 
>   CXX      librados/librados_la-RadosClient.lo
> erasure-code/jerasure/ErasureCodePluginJerasure.cc: In function 'int
> __erasure_code_init(char*)':
> erasure-code/jerasure/ErasureCodePluginJerasure.cc:78:43: error:
> 'galois_init_default_field' was not declared in this scope
>      int r = galois_init_default_field(w[i]);
>                                            ^
> erasure-code/jerasure/ErasureCodePluginJerasure.cc: In function 'int
> __erasure_code_init(char*)':
> erasure-code/jerasure/ErasureCodePluginJerasure.cc:78:43: error:
> 'galois_init_default_field' was not declared in this scope
>      int r = galois_init_default_field(w[i]);
>                                            ^
> make[3]: ***
> [erasure-code/jerasure/libec_jerasure_generic_la-ErasureCodePluginJerasure.lo]
> Error 1
> make[3]: *** Waiting for unfinished jobs....
> make[3]: ***
> [erasure-code/jerasure/libec_jerasure_sse3_la-ErasureCodePluginJerasure.lo]
> Error 1
> erasure-code/jerasure/ErasureCodePluginJerasure.cc: In function 'int
> __erasure_code_init(char*)':
> erasure-code/jerasure/ErasureCodePluginJerasure.cc:78:43: error:
> 'galois_init_default_field' was not declared in this scope
>      int r = galois_init_default_field(w[i]);
>                                            ^
> make[3]: ***
> [erasure-code/jerasure/libec_jerasure_sse4_la-ErasureCodePluginJerasure.lo]
> Error 1
> make[3]: Leaving directory `/data/lpabon/git/ceph/ceph/src'
> make[2]: *** [all-recursive] Error 1
> make[2]: Leaving directory `/data/lpabon/git/ceph/ceph/src'
> make[1]: *** [all] Error 2
> make[1]: Leaving directory `/data/lpabon/git/ceph/ceph/src'
> make: *** [all-recursive] Error 1
> 
> $ git log --oneline -3
> 959d664 Merge pull request #2032 from sponce/wip-fixstriperoni386
> a5f9a09 Fixed build on 32 bits platforms
> f5a72b7 Added a couple of ASSERTS for avoiding coverity to complain about the
> possibility of a division by 0
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
