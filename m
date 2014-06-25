From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: [PATCH 0/4] rbd: #6628 fix (wip-remove-osd-6628)
Date: Wed, 25 Jun 2014 21:20:30 +0400
Message-ID: <CALFYKtAerwi51HrdA06esUqaCt=pR=0G+snH8tEYnCM6mNzAdg@mail.gmail.com>
References: <1403255383-5729-1-git-send-email-ilya.dryomov@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f51.google.com ([209.85.192.51]:33375 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757831AbaFYRUb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Jun 2014 13:20:31 -0400
Received: by mail-qg0-f51.google.com with SMTP id z60so1940025qgd.38
        for <ceph-devel@vger.kernel.org>; Wed, 25 Jun 2014 10:20:30 -0700 (PDT)
In-Reply-To: <1403255383-5729-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

On Fri, Jun 20, 2014 at 1:09 PM, Ilya Dryomov <ilya.dryomov@inktank.com> wrote:
> Hello,
>
> This fixes #6628 ("krbd: BUG during ceph_osdc_stop() sometimes when
> rbd_add() fails").

This has been superseded by

[PATCH 00/14] rbd: #6628 fixes (wip-remove-osd-6628)

Thanks,

                Ilya
