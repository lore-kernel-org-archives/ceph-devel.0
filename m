From: Travis Rhoden <trhoden@gmail.com>
Subject: Re: can "rbd unmap" detect if device is mounted?
Date: Mon, 16 Jul 2012 23:34:16 -0400
Message-ID: <CACkq2mqqcyVeKaQz+GSfORbfjCFo2RLRQ1f2j_gyrBaK+m-4bQ@mail.gmail.com>
References: <CACkq2mqt5ae4U_-yhNM94GYQnE_negqXqHTf3JaSZ0zsxya9Yw@mail.gmail.com>
 <500498FC.9070806@inktank.com> <CADvuQREm_PCatUUdgUjsUNMNBNEtB9_z9LTvo9D0Gyq7dR8XeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:49016 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753112Ab2GQDei (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Jul 2012 23:34:38 -0400
Received: by lbbgm6 with SMTP id gm6so46914lbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 16 Jul 2012 20:34:36 -0700 (PDT)
In-Reply-To: <CADvuQREm_PCatUUdgUjsUNMNBNEtB9_z9LTvo9D0Gyq7dR8XeQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tv@inktank.com>
Cc: Josh Durgin <josh.durgin@inktank.com>, ceph-devel@vger.kernel.org

On Mon, Jul 16, 2012 at 7:37 PM, Tommi Virtanen <tv@inktank.com> wrote:
>
> [0 tv@dreamer ~]$ sudo mount /dev/loop0 /mnt
> [0 tv@dreamer ~]$ sudo losetup -d /dev/loop0
> loop: can't delete device /dev/loop0: Device or resource busy
> [1 tv@dreamer ~]$ sudo umount /mnt
> [0 tv@dreamer ~]$ sudo losetup -d /dev/loop0
> [0 tv@dreamer ~]$

Thanks for the ingenious loop device example, Tommi.  You illustrated
my point better than I ever could have.  Sounds like you guys have a
handle on the situation.

 - Travis
