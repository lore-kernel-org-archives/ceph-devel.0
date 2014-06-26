From: Luis Pabon <lpabon@redhat.com>
Subject: master does not compile
Date: Thu, 26 Jun 2014 13:27:49 -0400
Message-ID: <53AC5815.3090503@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:19226 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753043AbaFZR1v (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 26 Jun 2014 13:27:51 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s5QHRoCq010715
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <ceph-devel@vger.kernel.org>; Thu, 26 Jun 2014 13:27:51 -0400
Received: from localhost.localdomain (vpn-59-95.rdu2.redhat.com [10.10.59.95])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id s5QHRorJ011296
	for <ceph-devel@vger.kernel.org>; Thu, 26 Jun 2014 13:27:50 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I hit this issue just now (Fedora 20).  Please confirm that this happens 
in other systems.  Travis may be able to at least help do sanity tests.

- Luis

   CXX      librados/librados_la-RadosClient.lo
erasure-code/jerasure/ErasureCodePluginJerasure.cc: In function 'int 
__erasure_code_init(char*)':
erasure-code/jerasure/ErasureCodePluginJerasure.cc:78:43: error: 
'galois_init_default_field' was not declared in this scope
      int r = galois_init_default_field(w[i]);
                                            ^
erasure-code/jerasure/ErasureCodePluginJerasure.cc: In function 'int 
__erasure_code_init(char*)':
erasure-code/jerasure/ErasureCodePluginJerasure.cc:78:43: error: 
'galois_init_default_field' was not declared in this scope
      int r = galois_init_default_field(w[i]);
                                            ^
make[3]: *** 
[erasure-code/jerasure/libec_jerasure_generic_la-ErasureCodePluginJerasure.lo] 
Error 1
make[3]: *** Waiting for unfinished jobs....
make[3]: *** 
[erasure-code/jerasure/libec_jerasure_sse3_la-ErasureCodePluginJerasure.lo] 
Error 1
erasure-code/jerasure/ErasureCodePluginJerasure.cc: In function 'int 
__erasure_code_init(char*)':
erasure-code/jerasure/ErasureCodePluginJerasure.cc:78:43: error: 
'galois_init_default_field' was not declared in this scope
      int r = galois_init_default_field(w[i]);
                                            ^
make[3]: *** 
[erasure-code/jerasure/libec_jerasure_sse4_la-ErasureCodePluginJerasure.lo] 
Error 1
make[3]: Leaving directory `/data/lpabon/git/ceph/ceph/src'
make[2]: *** [all-recursive] Error 1
make[2]: Leaving directory `/data/lpabon/git/ceph/ceph/src'
make[1]: *** [all] Error 2
make[1]: Leaving directory `/data/lpabon/git/ceph/ceph/src'
make: *** [all-recursive] Error 1

$ git log --oneline -3
959d664 Merge pull request #2032 from sponce/wip-fixstriperoni386
a5f9a09 Fixed build on 32 bits platforms
f5a72b7 Added a couple of ASSERTS for avoiding coverity to complain 
about the possibility of a division by 0


