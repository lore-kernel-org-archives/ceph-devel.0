From: Noah Watkins <noah.watkins@inktank.com>
Subject: Re: Erasure encoding as a storage backend
Date: Sun, 5 May 2013 07:51:10 -0700
Message-ID: <03CFA780-35CB-4583-ACE2-FE4B37F3718F@inktank.com>
References: <5185428B.6070109@dachary.org> <C93B376E-72EF-4822-9559-ECF6F2962AA7@cs.ucsc.edu> <51855512.20207@dachary.org> <C38EEFE7-DC29-4325-B268-5BB85B1E4D9A@cs.ucsc.edu> <CAPYLRziAvz-DvPpX5aArQM_D8x27Lt+2ea9rtuOCTNcj-fnOFw@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:65466 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751496Ab3EEOvM convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 5 May 2013 10:51:12 -0400
Received: by mail-pd0-f177.google.com with SMTP id g10so1601594pdj.22
        for <ceph-devel@vger.kernel.org>; Sun, 05 May 2013 07:51:12 -0700 (PDT)
In-Reply-To: <CAPYLRziAvz-DvPpX5aArQM_D8x27Lt+2ea9rtuOCTNcj-fnOFw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Noah Watkins <jayhawk@cs.ucsc.edu>, Loic Dachary <loic@dachary.org>, Ceph Development <ceph-devel@vger.kernel.org>


On May 4, 2013, at 9:51 PM, Gregory Farnum <greg@inktank.com> wrote:

> I'm pretty sure we'd just want to use erasure-coded RADOS pools,
> rather than trying to do any CephFS magic erasure encoding. Doing it
> above the RADOS layers would introduce some very odd behaviors in
> terms of losing objects, as you've mentioned, and requires the clients
> to do a lot more network traffic for reads and writes.

Cool. I was just thinking of some setups I've heard of in HPC environments where the extra client work was ostensibly worth it in terms of reducing disk heads, or something :)

-Noah