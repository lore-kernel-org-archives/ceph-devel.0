From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: blueprint: consistency groups
Date: Tue, 29 Mar 2016 10:54:03 -0700
Message-ID: <CAJ4mKGZHd1Bm558woz=2Agd-x7sDkQmarwQfZUkwSWAcmOb8ew@mail.gmail.com>
References: <CA+hcxJQqbi_oCMF+0=fgQ6-=W1k-KPw6Y_3pZZnXKe01=Z-dhQ@mail.gmail.com>
	<CAJ4mKGYHno0u4z8PkUz0gL9voeBPQCPP+TSroEQRy2+26H+WHQ@mail.gmail.com>
	<20160325071933.GA14634@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f46.google.com ([209.85.213.46]:36152 "EHLO
	mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753352AbcC2RyF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 Mar 2016 13:54:05 -0400
Received: by mail-vk0-f46.google.com with SMTP id z68so29409026vkg.3
        for <ceph-devel@vger.kernel.org>; Tue, 29 Mar 2016 10:54:04 -0700 (PDT)
In-Reply-To: <20160325071933.GA14634@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mykola Golub <mgolub@mirantis.com>
Cc: Victor Denisov <vdenisov@mirantis.com>, ceph-devel <ceph-devel@vger.kernel.org>, Josh Durgin <jdurgin@redhat.com>, Jason Dillaman <dillaman@redhat.com>

On Fri, Mar 25, 2016 at 12:19 AM, Mykola Golub <mgolub@mirantis.com> wrote:
> On Thu, Mar 24, 2016 at 03:38:25PM -0700, Gregory Farnum wrote:
>
>> Just to be clear, you know that you can use the same snapid for all
>> the images, right? (...although not if you're trying to allow CGs
>> across pools. Those will be a little harder.)
>
> I think not allowing CGs across pools would be annoying limitation for
> users. If a VM has several volumes for different purposes (e.g. small
> but fast volume for applicatin data, and large but slow one for
> backups) it is logical to have different pools for those.

This isn't impossible either. We do it with cache pools and backing
pools sharing a set of snapids, for instance. But the default rules
won't work, since a snapid is just a 64-bit counter and they're
per-pool rather than cluster-global.
-Greg
