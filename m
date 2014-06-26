From: Luis Pabon <lpabon@redhat.com>
Subject: Re: master does not compile
Date: Thu, 26 Jun 2014 13:35:09 -0400
Message-ID: <53AC59CD.8010208@redhat.com>
References: <53AC5815.3090503@redhat.com> <alpine.DEB.2.00.1406261032560.10777@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:28705 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757824AbaFZRfL (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 26 Jun 2014 13:35:11 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s5QHZAK7017052
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <ceph-devel@vger.kernel.org>; Thu, 26 Jun 2014 13:35:10 -0400
In-Reply-To: <alpine.DEB.2.00.1406261032560.10777@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@redhat.com>
Cc: ceph-devel@vger.kernel.org

Sweet! That worked.  Should we put that as part of the do_autogen.sh?

- Luis

On 06/26/2014 01:33 PM, Sage Weil wrote:
> On Thu, 26 Jun 2014, Luis Pabon wrote:
>> I hit this issue just now (Fedora 20).  Please confirm that this happens in
>> other systems.  Travis may be able to at least help do sanity tests.
> You may need to do
>
>   git submodule update
>
> ?  I believe this change relied on a new commit in the gf-complete
> submodule.
>
> sage
>
>> - Luis
>>
>>    CXX      librados/librados_la-RadosClient.lo
>> erasure-code/jerasure/ErasureCodePluginJerasure.cc: In function 'int
>> __erasure_code_init(char*)':
>> erasure-code/jerasure/ErasureCodePluginJerasure.cc:78:43: error:
>> 'galois_init_default_field' was not declared in this scope
>>       int r = galois_init_default_field(w[i]);
>>                                             ^
>> erasure-code/jerasure/ErasureCodePluginJerasure.cc: In function 'int
>> __erasure_code_init(char*)':
>> erasure-code/jerasure/ErasureCodePluginJerasure.cc:78:43: error:
>> 'galois_init_default_field' was not declared in this scope
>>       int r = galois_init_default_field(w[i]);
>>                                             ^
>> make[3]: ***
>> [erasure-code/jerasure/libec_jerasure_generic_la-ErasureCodePluginJerasure.lo]
>> Error 1
>> make[3]: *** Waiting for unfinished jobs....
>> make[3]: ***
>> [erasure-code/jerasure/libec_jerasure_sse3_la-ErasureCodePluginJerasure.lo]
>> Error 1
>> erasure-code/jerasure/ErasureCodePluginJerasure.cc: In function 'int
>> __erasure_code_init(char*)':
>> erasure-code/jerasure/ErasureCodePluginJerasure.cc:78:43: error:
>> 'galois_init_default_field' was not declared in this scope
>>       int r = galois_init_default_field(w[i]);
>>                                             ^
>> make[3]: ***
>> [erasure-code/jerasure/libec_jerasure_sse4_la-ErasureCodePluginJerasure.lo]
>> Error 1
>> make[3]: Leaving directory `/data/lpabon/git/ceph/ceph/src'
>> make[2]: *** [all-recursive] Error 1
>> make[2]: Leaving directory `/data/lpabon/git/ceph/ceph/src'
>> make[1]: *** [all] Error 2
>> make[1]: Leaving directory `/data/lpabon/git/ceph/ceph/src'
>> make: *** [all-recursive] Error 1
>>
>> $ git log --oneline -3
>> 959d664 Merge pull request #2032 from sponce/wip-fixstriperoni386
>> a5f9a09 Fixed build on 32 bits platforms
>> f5a72b7 Added a couple of ASSERTS for avoiding coverity to complain about the
>> possibility of a division by 0
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>

