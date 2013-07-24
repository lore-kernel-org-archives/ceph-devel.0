From: Joao Eduardo Luis <joao.luis@inktank.com>
Subject: Re: Upgrading from 0.61.5 to 0.61.6 ended in disaster
Date: Wed, 24 Jul 2013 12:11:12 +0100
Message-ID: <51EFB650.6050506@inktank.com>
References: <51EF7CC8.9070507@profihost.ag> <51EF843D.1070107@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f41.google.com ([74.125.83.41]:38603 "EHLO
	mail-ee0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750820Ab3GXLLM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Jul 2013 07:11:12 -0400
Received: by mail-ee0-f41.google.com with SMTP id d51so163928eek.28
        for <ceph-devel@vger.kernel.org>; Wed, 24 Jul 2013 04:11:11 -0700 (PDT)
In-Reply-To: <51EF843D.1070107@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 07/24/2013 08:37 AM, Stefan Priebe - Profihost AG wrote:
> Hi,
>
> i uploaded my ceph mon store to cephdrop
> /home/cephdrop/ceph-mon-failed-assert-0.61.6/mon.tar.gz.
>
> So hopefully someone can find the culprit soon.
>
> It fails in OSDMonitor.cc here:
>
>     // if we trigger this, then there's something else going with the store
>      // state, and we shouldn't want to work around it without knowing what
>      // exactly happened.
>      assert(latest_full > 0);
>

Wrong variable being used in a loop as part of a workaround for 5704.

Opened a bug for this on http://tracker.ceph.com/issues/5737

A fix is available on wip-5737 (next) and wip-5737-cuttlefish.

Tested the mon against your store and it worked flawlessly.  Also tested 
it against the same stores used during the original fix and also they 
worked just fine.

My question now is how the hell those stores worked fine although the 
original fix was grabbing what should have been a non-existent version, 
or how did they not trigger that assert.  Which is what I'm going to 
investigate next.

   -Joao


-- 
Joao Eduardo Luis
Software Engineer | http://inktank.com | http://ceph.com
