From: Dan van der Ster <dan@vanderster.com>
Subject: Re: hdparm -W redux, bug in _check_disk_write_cache for RHEL6?
Date: Tue, 21 Jul 2015 19:44:43 +0200
Message-ID: <CABZ+qq=W0NebscoGA9sEgpOnNTrx77bR8c1ia3kosBypaGyKuA@mail.gmail.com>
References: <CABZ+qq=NDjKsQfqshVTzoPoC7PW2MPW1Q8MgvvmJfNGqhp0feQ@mail.gmail.com>
 <alpine.DEB.2.00.1507210646120.8878@cobra.newdream.net> <CAOi1vP-dFaquVYvSSVX_L3P8R6fFz0M5taUXG6bjzUO2tiMwjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:35789 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933295AbbGURpa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Jul 2015 13:45:30 -0400
Received: by lblf12 with SMTP id f12so120882530lbl.2
        for <ceph-devel@vger.kernel.org>; Tue, 21 Jul 2015 10:45:28 -0700 (PDT)
Received: from mail-la0-f45.google.com (mail-la0-f45.google.com. [209.85.215.45])
        by smtp.gmail.com with ESMTPSA id pl1sm3732258lbc.30.2015.07.21.10.45.27
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jul 2015 10:45:27 -0700 (PDT)
Received: by laem6 with SMTP id m6so122776582lae.0
        for <ceph-devel@vger.kernel.org>; Tue, 21 Jul 2015 10:45:26 -0700 (PDT)
In-Reply-To: <CAOi1vP-dFaquVYvSSVX_L3P8R6fFz0M5taUXG6bjzUO2tiMwjQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Sage Weil <sage@newdream.net>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Ric Wheeler <rwheeler@redhat.com>

On Tue, Jul 21, 2015 at 4:20 PM, Ilya Dryomov <idryomov@gmail.com> wrote:
> This one, I think:
>
> commit ab0a9735e06914ce4d2a94ffa41497dbc142fe7f
> Author: Christoph Hellwig <hch@lst.de>
> Date:   Thu Oct 29 14:14:04 2009 +0100
>
>     blkdev: flush disk cache on ->fsync

Thanks, that looks relevant! Looks to me that all RHEL 6 kernels have
(a version of) that patch.

Cheers, Dan
