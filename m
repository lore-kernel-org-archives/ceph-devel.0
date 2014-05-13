From: Hannes Landeholm <hannes@jumpstarter.io>
Subject: Re: crash in rbd_img_request_create
Date: Tue, 13 May 2014 19:17:24 +0200
Message-ID: <CABt9es_dd3VjuBaHUkM9qRW6aJDujHE3yN1FvkojtXXXQhcsqQ@mail.gmail.com>
References: <CABt9es_QVVHR30D+VyKyn+gr=0pHahwwvZAbXAvG78ixX9t86w@mail.gmail.com>
	<536EEA5C.70503@ieee.org>
	<CALFYKtBXLKhm1HvwK=FGQpJdx_TMaWE_7a0s6Qo7=9vdcsjkkw@mail.gmail.com>
	<53704F70.3090800@ieee.org>
	<CABt9es8snhMJ5jg9OkiYVmXU6iX9aj3jAG8_XL1Th_BmJpgonQ@mail.gmail.com>
	<537211AD.9070209@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:52183 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174AbaEMRR0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 May 2014 13:17:26 -0400
Received: by mail-lb0-f180.google.com with SMTP id p9so525927lbv.11
        for <ceph-devel@vger.kernel.org>; Tue, 13 May 2014 10:17:24 -0700 (PDT)
In-Reply-To: <537211AD.9070209@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>, Ilya Dryomov <ilya.dryomov@inktank.com>, Ceph Development <ceph-devel@vger.kernel.org>
Cc: Thorwald Lundqvist <thorwald@jumpstarter.io>

On Tue, May 13, 2014 at 2:35 PM, Alex Elder <elder@ieee.org> wrote:
> On 05/12/2014 12:28 PM, Hannes Landeholm wrote:
>> We where experimenting to use ZFS as a backend for
>> CEPH just to see what the performance and storage saving
>> characteristics was like but we're gonna completely switch to ext4 now
>> and see if the problem goes away.
>
> This is very good to know. Please report back what you find.

We completely cleansed the server in question from any trace of ZFS
and ran the same test again with ext4 instead for the ceph backend
with the same conditions. Everything worked fine. The machine has also
stopped randomly locking up. We will not touch ZFS again. Maybe in a
distant future where it actually integrates well with Linux.

Thank you for your time,
Hannes
