From: Alex Elder <elder@ieee.org>
Subject: Re: crash in rbd_img_request_create
Date: Tue, 13 May 2014 12:18:18 -0500
Message-ID: <537253DA.4030903@ieee.org>
References: <CABt9es_QVVHR30D+VyKyn+gr=0pHahwwvZAbXAvG78ixX9t86w@mail.gmail.com>	<536EEA5C.70503@ieee.org>	<CALFYKtBXLKhm1HvwK=FGQpJdx_TMaWE_7a0s6Qo7=9vdcsjkkw@mail.gmail.com>	<53704F70.3090800@ieee.org>	<CABt9es8snhMJ5jg9OkiYVmXU6iX9aj3jAG8_XL1Th_BmJpgonQ@mail.gmail.com>	<537211AD.9070209@ieee.org> <CABt9es_dd3VjuBaHUkM9qRW6aJDujHE3yN1FvkojtXXXQhcsqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:59003 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753555AbaEMRSI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 May 2014 13:18:08 -0400
Received: by mail-ig0-f181.google.com with SMTP id h3so672945igd.14
        for <ceph-devel@vger.kernel.org>; Tue, 13 May 2014 10:18:07 -0700 (PDT)
In-Reply-To: <CABt9es_dd3VjuBaHUkM9qRW6aJDujHE3yN1FvkojtXXXQhcsqQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Hannes Landeholm <hannes@jumpstarter.io>, Ilya Dryomov <ilya.dryomov@inktank.com>, Ceph Development <ceph-devel@vger.kernel.org>
Cc: Thorwald Lundqvist <thorwald@jumpstarter.io>

On 05/13/2014 12:17 PM, Hannes Landeholm wrote:
> On Tue, May 13, 2014 at 2:35 PM, Alex Elder <elder@ieee.org> wrote:
>> On 05/12/2014 12:28 PM, Hannes Landeholm wrote:
>>> We where experimenting to use ZFS as a backend for
>>> CEPH just to see what the performance and storage saving
>>> characteristics was like but we're gonna completely switch to ext4 now
>>> and see if the problem goes away.
>>
>> This is very good to know. Please report back what you find.
> 
> We completely cleansed the server in question from any trace of ZFS
> and ran the same test again with ext4 instead for the ceph backend
> with the same conditions. Everything worked fine. The machine has also
> stopped randomly locking up. We will not touch ZFS again. Maybe in a
> distant future where it actually integrates well with Linux.

That's good news for rbd...  Thanks a lot.	-Alex

> Thank you for your time,
> Hannes
> 

