From: Wido den Hollander <wido@42on.com>
Subject: Re: Is there a way to build rbd tools only?
Date: Wed, 6 Apr 2016 08:56:22 +0200 (CEST)
Message-ID: <944732311.2353.160e133c-ee3f-4c6e-9b8b-e4d468651d78.open-xchange@ox.pcextreme.nl>
References: <5703DC53.9060908@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:48582 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751187AbcDFG43 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Apr 2016 02:56:29 -0400
In-Reply-To: <5703DC53.9060908@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jevon Qiao <scaleqiao@gmail.com>, ceph-devel@vger.kernel.org


> Op 5 april 2016 om 17:40 schreef Jevon Qiao <scaleqiao@gmail.com>:
> 
> 
> Hi Cephers,
> 
> I modified some code of rbd tools, I'm wondering if there is a way to 
> build them only instead of building the whole Ceph.
> 

I think you can run 'make rbd' in the src directory, that should give you the
rbd tool.

It will build more things, but those are dependencies for the tool.

Wido

> Thanks,
> Jevon
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
