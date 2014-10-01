From: Sebastien Ponce <sebastien.ponce@cern.ch>
Subject: Re: librados AIO problem diagnostic
Date: Wed, 1 Oct 2014 09:28:57 +0200
Message-ID: <1412148537.6822.11.camel@sebmain.cern.ch>
References: <542BA6D4.4070207@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx11.cern.ch ([188.184.36.50]:49442 "EHLO CERNMX11.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750850AbaJAHfK (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 1 Oct 2014 03:35:10 -0400
In-Reply-To: <542BA6D4.4070207@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Thanks for this effort !
I'll look at all that this afternoon (it's mid morning here).
Concerning configure and autogen, I do the standard (naive ?)
"./autogen.sh; ./configure; make" given by the readme.

Sebastien


On Wed, 2014-10-01 at 09:01 +0200, Loic Dachary wrote:
> Hi Sebastien,
> 
> In the context of http://tracker.ceph.com/issues/9356 I'm trying to collect as much information as I can in an environment that can be reconstructed to avoid interferences. Could you please let me know which ./configure line you are using ? Or which do_autogen.sh command you are using.
> 
> Thanks in advance :-)
> 


