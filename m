From: Vincent JARDIN <vincent.jardin@6wind.com>
Subject: Re: SIMD accelerated crush_do_rule proof of concept
Date: Mon, 29 Aug 2016 16:08:55 +0200
Message-ID: <a97a87c5-1cc6-7747-8a2a-347e49ae6e69@6wind.com>
References: <57C41F9E.7090309@dachary.org>
 <alpine.DEB.2.11.1608291352290.24244@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:37500 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756135AbcH2OJC (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Aug 2016 10:09:02 -0400
Received: by mail-wm0-f43.google.com with SMTP id i5so94154322wmg.0
        for <ceph-devel@vger.kernel.org>; Mon, 29 Aug 2016 07:09:01 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1608291352290.24244@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Le 29/08/2016 à 15:55, Sage Weil a écrit :
> To answer your question, the only real risk/problem I see is that we need
> to keep the perfectly in sync with the non-optimized variant

I do propose a generic implementation that allows to share SIMD on ARM, 
Intel and others (Altivec),

 
https://github.com/dachary/ceph/commit/71ae4584d9ed57f70aad718d0ffe206a01e91fef

You can try the following,
For instance,
#include <stdint.h>
#include <immintrin.h>
{
__v32qi va, vb;
va = (__v32qi) { 31, 30, 29, 28, 27, 26, 25, 24, 23, 22, 21, 20, 19, 18, 
17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 4, 1, 0 };
vb = (__v32qi) { 31, 30, 29, 28, 27, 26, 25, 24, 23, 22, 21, 20, 19, 18, 
17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0 };

__v32qi res = va ^ vb;
}

it will produce the optimized Neon or AVX, AVX2 according to each targets.


