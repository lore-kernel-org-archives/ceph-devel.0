From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: v0.38 released
Date: Mon, 21 Nov 2011 09:36:38 -0800
Message-ID: <CAORUGqAWBbY2VS=X2fFq1PNyjJUYD50=-S=BctaALE6Xn+dEtw@mail.gmail.com>
References: <Pine.LNX.4.64.1111102113260.27241@cobra.newdream.net>
 <20111115164254.GJ13394@systemlinux.org> <CAF3hT9AA5zgTsbHb-Gxn5BTeMG+=krGdO2NtRFcHTR_k_3dKgw@mail.gmail.com>
 <20111116095614.GK13394@systemlinux.org> <CAORUGqCGRAK+x4Opzsw4hmjw2gKPWzxSvuVdx4A-2uR4mqQFZg@mail.gmail.com>
 <20111117103524.GL13394@systemlinux.org> <CAORUGqA2HJQFXM01mq29TcSTK9p7OxLDGa9s85OfkbgWALnu7w@mail.gmail.com>
 <20111118150157.GM13394@systemlinux.org> <CAORUGqBNus_UuYOvkjcAtsbz+S1AKbafB1utwqAyq=sB7j8g9w@mail.gmail.com>
 <20111121173254.GN13394@systemlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:43297 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753205Ab1KURhA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Nov 2011 12:37:00 -0500
Received: by eye27 with SMTP id 27so5629600eye.19
        for <ceph-devel@vger.kernel.org>; Mon, 21 Nov 2011 09:36:59 -0800 (PST)
In-Reply-To: <20111121173254.GN13394@systemlinux.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andre Noll <maan@systemlinux.org>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

On Mon, Nov 21, 2011 at 09:32, Andre Noll <maan@systemlinux.org> wrote:
> I believe that code and documentation should be located as close as
> possible, and I'd also prefer to edit and access the documentation
> locally via command line tools rather than through a browser. But
> I don't have a strong opinion on this, so let's go for the web
> documentation.

I agree, and that's a big part of the reasons for choosing the
toolchain I did! All the docs from http://ceph.newdream.net/docs are
in the doc/ directory of the source tree.

> Should I prepare something and post a request for inclusion to the
> web pages on this mailing list, or do you want me to edit the web
> documentation directly?

Submit it like you would submit a code change.

> Are you implying that ceph is only suitable for new clusters with
> homogeneous hardware? I'm asking because our cluster is far from
> homogeneous. There are 8 year old 2-core nodes with small SCSI disks
> as well as 64-core boxes with much larger SATA disks.

8 year old? Wow.

We do intend to fully support clusters with nodes of different
capacity and speed (as I strongly believe most clusters will go
through such a phase in their life). It's just not the default
configuration, and won't be needed by most setups in the beginning.
