From: Sage Weil <sage@inktank.com>
Subject: Re: crash in rbd_img_request_create
Date: Tue, 13 May 2014 13:58:32 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1405131357250.12608@cobra.newdream.net>
References: <CABt9es_QVVHR30D+VyKyn+gr=0pHahwwvZAbXAvG78ixX9t86w@mail.gmail.com> <536EEA5C.70503@ieee.org> <CALFYKtBXLKhm1HvwK=FGQpJdx_TMaWE_7a0s6Qo7=9vdcsjkkw@mail.gmail.com> <53704F70.3090800@ieee.org> <CABt9es8snhMJ5jg9OkiYVmXU6iX9aj3jAG8_XL1Th_BmJpgonQ@mail.gmail.com>
 <537211AD.9070209@ieee.org> <CABt9es_dd3VjuBaHUkM9qRW6aJDujHE3yN1FvkojtXXXQhcsqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36031 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751596AbaEMU6c (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 May 2014 16:58:32 -0400
In-Reply-To: <CABt9es_dd3VjuBaHUkM9qRW6aJDujHE3yN1FvkojtXXXQhcsqQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Hannes Landeholm <hannes@jumpstarter.io>
Cc: Alex Elder <elder@ieee.org>, Ilya Dryomov <ilya.dryomov@inktank.com>, Ceph Development <ceph-devel@vger.kernel.org>, Thorwald Lundqvist <thorwald@jumpstarter.io>

Hi Hannes,

On Tue, 13 May 2014, Hannes Landeholm wrote:
> On Tue, May 13, 2014 at 2:35 PM, Alex Elder <elder@ieee.org> wrote:
> > On 05/12/2014 12:28 PM, Hannes Landeholm wrote:
> >> We where experimenting to use ZFS as a backend for
> >> CEPH just to see what the performance and storage saving
> >> characteristics was like but we're gonna completely switch to ext4 now
> >> and see if the problem goes away.
> >
> > This is very good to know. Please report back what you find.
> 
> We completely cleansed the server in question from any trace of ZFS
> and ran the same test again with ext4 instead for the ceph backend
> with the same conditions. Everything worked fine. The machine has also
> stopped randomly locking up. We will not touch ZFS again. Maybe in a
> distant future where it actually integrates well with Linux.

Note that there was a patch a week or so ago fixing a problem in RBD when 
running ZFS on top of RBD (IIRC it had to do with length 0 bios or 
something?).  Was this ZFS on RBD or ZFS underneat the ceph-osd daemons?

sage
