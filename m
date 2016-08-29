From: Loic Dachary <loic@dachary.org>
Subject: Re: SIMD accelerated crush_do_rule proof of concept
Date: Mon, 29 Aug 2016 16:54:11 +0200
Message-ID: <57C44C93.3050100@dachary.org>
References: <57C41F9E.7090309@dachary.org>
 <alpine.DEB.2.11.1608291352290.24244@piezo.us.to>
 <a97a87c5-1cc6-7747-8a2a-347e49ae6e69@6wind.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:46068 "EHLO
        slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757200AbcH2O6z (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Aug 2016 10:58:55 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by slow1-d.mail.gandi.net (Postfix) with ESMTP id 5668947BB6D
        for <ceph-devel@vger.kernel.org>; Mon, 29 Aug 2016 16:55:36 +0200 (CEST)
In-Reply-To: <a97a87c5-1cc6-7747-8a2a-347e49ae6e69@6wind.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Vincent JARDIN <vincent.jardin@6wind.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Vincent,

On 29/08/2016 16:08, Vincent JARDIN wrote:
> Le 29/08/2016 à 15:55, Sage Weil a écrit :
>> To answer your question, the only real risk/problem I see is that we need
>> to keep the perfectly in sync with the non-optimized variant
> 
> I do propose a generic implementation that allows to share SIMD on ARM, Intel and others (Altivec),
> 
> 
> https://github.com/dachary/ceph/commit/71ae4584d9ed57f70aad718d0ffe206a01e91fef
> 
> You can try the following,
> For instance,
> #include <stdint.h>
> #include <immintrin.h>
> {
> __v32qi va, vb;
> va = (__v32qi) { 31, 30, 29, 28, 27, 26, 25, 24, 23, 22, 21, 20, 19, 18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 4, 1, 0 };
> vb = (__v32qi) { 31, 30, 29, 28, 27, 26, 25, 24, 23, 22, 21, 20, 19, 18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0 };
> 
> __v32qi res = va ^ vb;
> }
> 
> it will produce the optimized Neon or AVX, AVX2 according to each targets.

Generic code that relies on the compiler optimizations is terse, which is nice. But the code is not generic: it needs to be written specifically for the optimizer, which is self defeating. The http://locklessinc.com/articles/vectorize/ article illustrate that in a fun way. Instead of maintaining code with SIMD instructions, you need to understand each optimizer by reading assembly language, which is more complicated.

Cheers

-- 
Loïc Dachary, Artisan Logiciel Libre
