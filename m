From: Tommi Virtanen <tv@inktank.com>
Subject: Re: mds dump
Date: Fri, 8 Jun 2012 12:31:43 -0700
Message-ID: <CADvuQRHR-EL+GpSgFUcSzQa1Jg++2LHvj83ZF3L1T_zT+NUqoA@mail.gmail.com>
References: <Pine.LNX.4.64.1206080857530.8391@cobra.newdream.net> <cacaf6c2-6adf-456e-85b3-b33a4f477cf7@mail.linserv.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:55560 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756309Ab2FHTcD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Jun 2012 15:32:03 -0400
Received: by pbbrp8 with SMTP id rp8so2939156pbb.19
        for <ceph-devel@vger.kernel.org>; Fri, 08 Jun 2012 12:32:03 -0700 (PDT)
In-Reply-To: <cacaf6c2-6adf-456e-85b3-b33a4f477cf7@mail.linserv.se>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin Wilderoth <martin.wilderoth@linserv.se>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Jun 8, 2012 at 12:22 PM, Martin Wilderoth
<martin.wilderoth@linserv.se> wrote:
> I have removed the data and metadata pool. Do I need to create them again, or
> will they be created automaticly.
> Maybe I need the undocumented way of creating the mds map ?. I would like to
> get an empty cephfs to play with again.

Just create them again with rados mkpool, that gets you back to square one.
