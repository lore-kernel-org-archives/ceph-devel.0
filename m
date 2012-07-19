From: Tommi Virtanen <tv@inktank.com>
Subject: Re: Ceph doesn't update the block device size while a rbd image is mounted
Date: Thu, 19 Jul 2012 08:39:59 -0700
Message-ID: <CADvuQRF8ZN+HuxcCPmA04Z_8vZOkFTEQUBR0iMvgdAs3mU2AFg@mail.gmail.com>
References: <CAOLwVUkWUrjQTxQw5-umpWnY6G-AjReCwLTyQCOdCyNT175KgA@mail.gmail.com>
 <CAOLwVUm-31QzWb2fnZP+tsntunXEJOcaFLRenqJtAQ9nYPmLyA@mail.gmail.com>
 <50082476.4020109@widodh.nl> <CAOLwVUm+NnB-ooMiCDx+rkHJhn7tCE7xM67wY6mmMckG87CrQQ@mail.gmail.com>
 <CADvuQRH05NnF_-a34R2mWfLomhpnyrbek9-63poKZA_zvP5BUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:59417 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750942Ab2GSPkU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Jul 2012 11:40:20 -0400
Received: by pbbrp8 with SMTP id rp8so4541884pbb.19
        for <ceph-devel@vger.kernel.org>; Thu, 19 Jul 2012 08:40:20 -0700 (PDT)
In-Reply-To: <CADvuQRH05NnF_-a34R2mWfLomhpnyrbek9-63poKZA_zvP5BUw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?Q?S=C3=A9bastien_Han?= <han.sebastien@gmail.com>
Cc: Wido den Hollander <wido@widodh.nl>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Jul 19, 2012 at 8:38 AM, Tommi Virtanen <tv@inktank.com> wrote:
> Do your LVM volumes have partition tables inside them? That might be
> the difference.
>
> Of course, you can put your filesystem straight on the RBD; that would
> be a good experiment to run.

Oops, I see you did put your fs straight on the RBD already; seeing
"fdisk" tripped my brain.
