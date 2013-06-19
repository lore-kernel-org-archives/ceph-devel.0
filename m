From: Alex Elsayed <eternaleye@gmail.com>
Subject: Re: Erasure code library summary
Date: Tue, 18 Jun 2013 18:10:17 -0700
Message-ID: <kpr0dn$3cr$1@ger.gmane.org>
References: <51C05123.8000002@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:48328 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932644Ab3FSBKf (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 18 Jun 2013 21:10:35 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1Up6ut-00063R-FQ
	for ceph-devel@vger.kernel.org; Wed, 19 Jun 2013 03:10:31 +0200
Received: from 66-87-113-27.pools.spcsdns.net ([66.87.113.27])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 19 Jun 2013 03:10:31 +0200
Received: from eternaleye by 66-87-113-27.pools.spcsdns.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 19 Jun 2013 03:10:31 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Loic Dachary wrote:

> Hi Ceph,
> 
<snip>
> Reed-Solomon coding family is the only one that can keep the chuncks
> unencoded and therefore concatenable.
<snip>

In my understanding, this is not strictly true - any 'systematic' code will 
have the unencoded chunks remain available in this manner, and any non-
systematic linear code can be transformed into a systematic code with the 
same minimum distance. Fountain codes are often explicitly constructed to 
maintain this property, as in the case of RaptorQ [RFC 6330].

https://en.wikipedia.org/wiki/Systematic_code

