From: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Subject: RE: Intel ISA-L EC plugin
Date: Wed, 9 Jul 2014 04:36:10 +0000
Message-ID: <3472A07E6605974CBC9BC573F1BC02E4AE749A92@CERNXCHG44.cern.ch>
References: <3472A07E6605974CBC9BC573F1BC02E4AE748075@CERNXCHG44.cern.ch>,<2838442.T0NM9d70iG@xavih.datalab.es>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx11.cern.ch ([188.184.36.50]:46350 "EHLO CERNMX11.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750724AbaGIEgP convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Jul 2014 00:36:15 -0400
In-Reply-To: <2838442.T0NM9d70iG@xavih.datalab.es>
Content-Language: en-GB
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xavier Hernandez <xhernandez@datalab.es>
Cc: Loic Dachary <loic@dachary.org>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Xavi, 
I had the same understanding. However the decoding routine is not always able to invert the given matrix. This can be either due to the generator matrix which does not conserve the MDS property, the matrix inversion procedure or a bug on my side I will check carefully my code and the input I provide. I already asked the maintainer of the library who put me on that path and there are also inline comments about non invertible vandermonde matrices in the code. However if I switch to a cauchy matrix I never see any problem with the code.

Cheers Andreas.

________________________________________
From: Xavier Hernandez [xhernandez@datalab.es]
Sent: 04 July 2014 09:43
To: Andreas Joachim Peters
Cc: Loic Dachary; ceph-devel@vger.kernel.org
Subject: Re: Intel ISA-L EC plugin

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
