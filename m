From: Jesse Williamson <jwilliamson@suse.de>
Subject: Re: Use of C++17 memory_resource and mempools
Date: Mon, 15 Jan 2018 23:58:31 -0800 (PST)
Message-ID: <alpine.LSU.2.21.1801152357390.10397@smaug>
References: <CA+2bHPbpW21ava_8Kz6xPTHjt9Ls54q49-LEr2ZayBanBdTJjw@mail.gmail.com> <5151a0e6-1781-388f-32db-d7a5e466b458@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:42285 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750725AbeAPH5y (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 16 Jan 2018 02:57:54 -0500
In-Reply-To: <5151a0e6-1781-388f-32db-d7a5e466b458@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Casey Bodley <cbodley@redhat.com>
Cc: Patrick Donnelly <pdonnell@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Mon, 15 Jan 2018, Casey Bodley wrote:

> I agree that polymorphic allocators sound perfect for this. That's 
> unfortunate that it's not available in libstdc++ yet, according to 
> https://gcc.gnu.org/onlinedocs/libstdc++/manual/status.html#table.cxx17_status. 
> We should keep an eye on that.

If you need an implementation to start development, Pablo Halpern has one 
you can use in the meantime:
https://github.com/phalpern/CppCon2017Code

-Jesse

