From: Gregory Farnum <greg@inktank.com>
Subject: Re: master does not compile
Date: Thu, 26 Jun 2014 10:32:21 -0700
Message-ID: <CAPYLRzj+9JOj7TuT8L44xDkq+1raBMtb-uqmisPGb+cKn=yjfA@mail.gmail.com>
References: <53AC5815.3090503@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f44.google.com ([209.85.192.44]:36238 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756110AbaFZRcW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Jun 2014 13:32:22 -0400
Received: by mail-qg0-f44.google.com with SMTP id j107so3378521qga.31
        for <ceph-devel@vger.kernel.org>; Thu, 26 Jun 2014 10:32:21 -0700 (PDT)
In-Reply-To: <53AC5815.3090503@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Luis Pabon <lpabon@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Looking at our gitbuilder page, we haven't built Ceph on Fedora for a
while, but it's fine elsewhere. And the Fedora issues look to be some
config issue; it never actually makes it to the compilation stage...
http://ceph.com/gitbuilder.cgi
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com


On Thu, Jun 26, 2014 at 10:27 AM, Luis Pabon <lpabon@redhat.com> wrote:
> I hit this issue just now (Fedora 20).  Please confirm that this happens in
> other systems.  Travis may be able to at least help do sanity tests.
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
> f5a72b7 Added a couple of ASSERTS for avoiding coverity to complain about
> the possibility of a division by 0
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
