From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: Ceph questions regarding auth and return on PUT from radosgw
Date: Mon, 11 Jun 2012 08:08:08 -0700
Message-ID: <CAC-hyiE3RFqeM7V3bXX_GXhYoFh-jMC8-Ch=ovMvzv62Mqq=ZQ@mail.gmail.com>
References: <CAMmJxtJyzaqwV2+BgrHwMZSWiLJKhM7948MUuEme-MGjZofuWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:56878 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754323Ab2FKPIJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Jun 2012 11:08:09 -0400
Received: by bkcji2 with SMTP id ji2so3624699bkc.19
        for <ceph-devel@vger.kernel.org>; Mon, 11 Jun 2012 08:08:08 -0700 (PDT)
In-Reply-To: <CAMmJxtJyzaqwV2+BgrHwMZSWiLJKhM7948MUuEme-MGjZofuWw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Axel Eriksson <john@insane.se>
Cc: ceph-devel@vger.kernel.org

On Mon, Jun 11, 2012 at 5:32 AM, John Axel Eriksson <john@insane.se> wrote:
>
> Also, when PUTting something through radosgw, does ceph/rgw return as
> soon as all data has been received or does it return
> when it has ensured N replicas? (I've seen quite a delay after all
> data has been sent before my PUT returns). I'm using nginx (1.2) by
> the way.
>

It sounds like that you're seeing the effect of nginx buffering of the
entire request before sending it to to the radosgw process (via
fastcgi). The same happens with apache when using mod_fcgi, unlike
mod_fastcgi that actually streams the written data to the backend and
thus acks are throttled accordingly.

Yehuda
