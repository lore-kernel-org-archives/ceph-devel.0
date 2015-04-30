From: Gregory Farnum <greg@gregs42.com>
Subject: Re: CephFS + Erasure coding
Date: Thu, 30 Apr 2015 15:00:39 -0700
Message-ID: <CAC6JEv-5b1JqdpoGXo02P2+xyhtUoCPx-B+17_RemJQbGkxVQg@mail.gmail.com>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CD83D5B@SACMBXIP01.sdcorp.global.sandisk.com>
	<CAC6JEv-pqbJ3JzV4MayJPF=1TAgVs0pm1=FxHvpScX2UsH4Otw@mail.gmail.com>
	<755F6B91B3BE364F9BCA11EA3F9E0C6F2CD83DA9@SACMBXIP01.sdcorp.global.sandisk.com>
	<755F6B91B3BE364F9BCA11EA3F9E0C6F2CD83DCB@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:35954 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717AbbD3WAk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Apr 2015 18:00:40 -0400
Received: by iebrs15 with SMTP id rs15so78571687ieb.3
        for <ceph-devel@vger.kernel.org>; Thu, 30 Apr 2015 15:00:39 -0700 (PDT)
Received: from mail-ig0-f177.google.com (mail-ig0-f177.google.com. [209.85.213.177])
        by mx.google.com with ESMTPSA id e6sm1807627igy.15.2015.04.30.15.00.39
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Apr 2015 15:00:39 -0700 (PDT)
Received: by igbhj9 with SMTP id hj9so26201625igb.1
        for <ceph-devel@vger.kernel.org>; Thu, 30 Apr 2015 15:00:39 -0700 (PDT)
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CD83DCB@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Apr 30, 2015 at 2:57 PM, Somnath Roy <Somnath.Roy@sandisk.com> wrote:
> Greg,
> Probably not supported right now, but, wanted to confirm if there is any way we can use Ceph cache tier for only writes and reads are forwarded to the backend erasure coded pool.

Anything like that would be based on what librados does; CephFS can't
do anything special there. I'm not following the proxy changes and
things that are being done now in any detail.
