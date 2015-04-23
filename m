From: Gregory Farnum <greg@gregs42.com>
Subject: Re: ceph tell osd bench
Date: Thu, 23 Apr 2015 10:36:35 -0700
Message-ID: <CAC6JEv8x-6hVBCiqSDH-oHPeMum3fe7d+V_fb8MoGmLdD4FQ+A@mail.gmail.com>
References: <BC97738F8E7C8742BABED7F06FB9DF916642BFFE@SATLEXDAG01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:35115 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966414AbbDWRgg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 23 Apr 2015 13:36:36 -0400
Received: by iejt8 with SMTP id t8so66258746iej.2
        for <ceph-devel@vger.kernel.org>; Thu, 23 Apr 2015 10:36:35 -0700 (PDT)
Received: from mail-ig0-f176.google.com (mail-ig0-f176.google.com. [209.85.213.176])
        by mx.google.com with ESMTPSA id cy11sm12598933igc.14.2015.04.23.10.36.35
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Apr 2015 10:36:35 -0700 (PDT)
Received: by iget9 with SMTP id t9so14371491ige.1
        for <ceph-devel@vger.kernel.org>; Thu, 23 Apr 2015 10:36:35 -0700 (PDT)
In-Reply-To: <BC97738F8E7C8742BABED7F06FB9DF916642BFFE@SATLEXDAG01.amd.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Deneau, Tom" <tom.deneau@amd.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Apr 23, 2015 at 6:58 AM, Deneau, Tom <tom.deneau@amd.com> wrote:
> While running ceph tell osd bench and playing around with the total_bytes and block_size parameters,
> I have noticed that if the total_bytes written is less than about 0.5G, the bytes/sec is much higher.
> Why is that?

It's probably only writing the data into the journal at that size. I'm
a bit surprised because I thought the osd bench took care to only
provide stable numbers, but maybe it's just using well-chosen defaults
and at half a gig you're running well below them.
-Greg
