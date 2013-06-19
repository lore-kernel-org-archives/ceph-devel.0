From: Alex Elsayed <eternaleye@gmail.com>
Subject: Re: Erasure code library summary
Date: Tue, 18 Jun 2013 18:14:26 -0700
Message-ID: <kpr0ld$3cr$2@ger.gmane.org>
References: <51C05123.8000002@dachary.org> <kpr0dn$3cr$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:53522 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932644Ab3FSBPJ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 18 Jun 2013 21:15:09 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1Up6zH-0006kO-RY
	for ceph-devel@vger.kernel.org; Wed, 19 Jun 2013 03:15:03 +0200
Received: from 66-87-113-27.pools.spcsdns.net ([66.87.113.27])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 19 Jun 2013 03:15:03 +0200
Received: from eternaleye by 66-87-113-27.pools.spcsdns.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 19 Jun 2013 03:15:03 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Alex Elsayed wrote:

> Loic Dachary wrote:
> 
>> Hi Ceph,
>> 
> <snip>
>> Reed-Solomon coding family is the only one that can keep the chuncks
>> unencoded and therefore concatenable.
> <snip>
> 
> In my understanding, this is not strictly true - any 'systematic' code
> will have the unencoded chunks remain available in this manner, and any
> non- systematic linear code can be transformed into a systematic code with
> the same minimum distance. Fountain codes are often explicitly constructed
> to maintain this property, as in the case of RaptorQ [RFC 6330].
> 
> https://en.wikipedia.org/wiki/Systematic_code

...that said, Reed-Solomon is to the best of my knowledge the only space-
optimal such code. An interesting option, however, might be to use a 
fountain code over the network when distributing either replicas *or* parity 
chunks, so that losses can be recovered with <1 full chunk retransmission.

