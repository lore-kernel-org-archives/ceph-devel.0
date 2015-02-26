From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: FileStore performance: coalescing operations
Date: Thu, 26 Feb 2015 23:02:13 +0800
Message-ID: <CACJqLyY7YEKWsrMc+8RTRypSGMtQO=wW1WFbtM57fLWNYHrgJg@mail.gmail.com>
References: <20150226152807.5b71a93c@doppio>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:45094 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753190AbbBZPCO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Feb 2015 10:02:14 -0500
Received: by pdjz10 with SMTP id z10so13483929pdj.12
        for <ceph-devel@vger.kernel.org>; Thu, 26 Feb 2015 07:02:14 -0800 (PST)
In-Reply-To: <20150226152807.5b71a93c@doppio>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Bluemle <andreas.bluemle@itxperts.de>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hmm, we already obverse this duplicate omap keys set from pglog operations.

And I think we need to resolve it in upper layer, of course,
coalescing omap operations in FileStore is also useful.

@Somnath Do you do this dedup work in KeyValueStore already?

On Thu, Feb 26, 2015 at 10:28 PM, Andreas Bluemle
<andreas.bluemle@itxperts.de> wrote:
> Hi,
>
> during the performance weely meeting, I had mentioned
> my experiences concerning the transaction structure
> for write requests at the level of the FileStore.
> Such a transaction not only contains the OP_WRITE
> operation to the object in the file system, but also
> a series of OP_OMAP_SETKEYS and OP_SETATTR operations.
>
> Find attached a README and source code patch, which
> describe a prototype for coalescing the OP_OMAP_SETKEYS
> operations and the performance impact f this change.
>
> Regards
>
> Andreas Bluemle
>
> --
> Andreas Bluemle                     mailto:Andreas.Bluemle@itxperts.de
> ITXperts GmbH                       http://www.itxperts.de
> Balanstrasse 73, Geb. 08            Phone: (+49) 89 89044917
> D-81541 Muenchen (Germany)          Fax:   (+49) 89 89044910
>
> Company details: http://www.itxperts.de/imprint.htm



-- 
Best Regards,

Wheat
