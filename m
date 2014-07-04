From: Xavier Hernandez <xhernandez@datalab.es>
Subject: Re: Intel ISA-L EC plugin
Date: Fri, 04 Jul 2014 09:43:29 +0200
Message-ID: <2838442.T0NM9d70iG@xavih.datalab.es>
References: <3472A07E6605974CBC9BC573F1BC02E4AE748075@CERNXCHG44.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from dlbex1.datalab.es ([192.146.172.55]:54256 "EHLO
	dlbex1.datalab.es" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082AbaGDHvt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Jul 2014 03:51:49 -0400
In-Reply-To: <3472A07E6605974CBC9BC573F1BC02E4AE748075@CERNXCHG44.cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Cc: Loic Dachary <loic@dachary.org>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thursday 03 July 2014 21:24:59 Andreas Joachim Peters wrote:
> Hi Loic,
> 
> I have chosen after benchmarking to use the LRU cache for the decoding
> matrix. I can cache easily all decoding matrices (worst case scenario) for
> configurations up to (10,4) without trashing it. I will restrict the (k,m)
> in case of the vandermonde matrix to the ones which are invertible, for
> cauchy they are all invertible anyway.

Maybe I'm misunderstanding something because I haven't had time to analyze ec 
code.

AFAIK the only condition that a Vandermonde matrix needs to be invertible is 
to have all rows different (i.e. use a different base number for each row). Do 
you have matrices with duplicated rows ? or there is some property I don't 
know ?

Thanks,

Xavi
