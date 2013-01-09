From: Florian Haas <florian@hastexo.com>
Subject: Re: Windows port
Date: Wed, 9 Jan 2013 15:31:44 +0100
Message-ID: <CAPUexz_5CMm6sMXcMYCXJXgcBxemLOKaymtF0EgpoGvdg72PmQ@mail.gmail.com>
References: <CAJVE5RWjv9ZVpTX5rxB1dL7bDSCtqkfr-Ac5m0hEnprANpwu0Q@mail.gmail.com>
	<CAJVE5RV-JZzK7Ofe9q2whcxp1eHquE_A2YELof8TAzBVjcsfgQ@mail.gmail.com>
	<CA+GnOzR29oKSXWpuS8dffsXJWChzMvTCFQ+dutmAm+zsuVkBgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:58914 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755725Ab3AIObp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Jan 2013 09:31:45 -0500
Received: by mail-ie0-f170.google.com with SMTP id k10so2134214iea.15
        for <ceph-devel@vger.kernel.org>; Wed, 09 Jan 2013 06:31:44 -0800 (PST)
In-Reply-To: <CA+GnOzR29oKSXWpuS8dffsXJWChzMvTCFQ+dutmAm+zsuVkBgQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dino Yancey <dino2gnt@gmail.com>
Cc: Cesar Mello <cmello@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Jan 8, 2013 at 3:00 PM, Dino Yancey <dino2gnt@gmail.com> wrote:
> Hi,
>
> I am also curious if a Windows port, specifically the client-side, is
> on the roadmap.

This is somewhat OT from the original post, but if all you're
interested is using RBD block storage from Windows, you can already do
that by going through an iSCSI or FC head node. Proof-of-concept
configuration outlined here:

http://www.hastexo.com/resources/hints-and-kinks/turning-ceph-rbd-images-san-storage-devices

Not sure if this helps, but just thought I'd mention it.

Cheers,
Florian

-- 
Helpful information? Let us know!
http://www.hastexo.com/shoutbox
