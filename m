From: Tommi Virtanen <tv@inktank.com>
Subject: Re: uneven placement
Date: Mon, 30 Jul 2012 10:53:06 -0700
Message-ID: <CADvuQRGhtOXt57cXf07Y0y9_v+XNQyC5qudhsdHPp34gdG5FOA@mail.gmail.com>
References: <501292A3.50606@univ-nantes.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:42678 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751841Ab2G3Rx1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Jul 2012 13:53:27 -0400
Received: by vbbff1 with SMTP id ff1so4888919vbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 30 Jul 2012 10:53:26 -0700 (PDT)
In-Reply-To: <501292A3.50606@univ-nantes.fr>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yann Dupont <Yann.Dupont@univ-nantes.fr>
Cc: ceph-devel@vger.kernel.org

On Fri, Jul 27, 2012 at 6:07 AM, Yann Dupont <Yann.Dupont@univ-nantes.fr> wrote:
> My ceph cluster is made of 8 OSD with quite big storage attached.
> All OSD nodes are equal, except 4 OSD have 6,2 TB, 4 have 8 TB storage.

Sounds like you should just set the weights yourself, based on the
capacities you listed here.

Even then, you only have 8 OSDs. The data placement is essentially
stochastic, you may not get perfect balance with a small cluster.
CRUSH evens out on larger clusters quite nicely, but there's still a
lot of statistical variation in the picture.
