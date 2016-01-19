From: Sage Weil <sweil@redhat.com>
Subject: Re: /var/lib/ceph/*/*/config
Date: Tue, 19 Jan 2016 11:46:32 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1601191144150.28274@cpach.fuggernut.com>
References: <alpine.DEB.2.11.1601191009320.28274@cpach.fuggernut.com> <CACJqLyaMC-UaAhTnzCeUqPCoY3HcoqLwHg3tpWW0H-+6AN6C7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-43724043-1453221995=:28274"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41526 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753626AbcASQqZ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 19 Jan 2016 11:46:25 -0500
In-Reply-To: <CACJqLyaMC-UaAhTnzCeUqPCoY3HcoqLwHg3tpWW0H-+6AN6C7Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomaiwang@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-43724043-1453221995=:28274
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 19 Jan 2016, Haomai Wang wrote:
> On Tue, Jan 19, 2016 at 11:15 PM, Sage Weil <sweil@redhat.com> wrote:
>       I think we should add an optional 'config' file location to the
>       config
>       search path.  This would allow you to put customized options for
>       an
>       individual daemon in the daemon data directory.  Or, you could
>       avoid
>       putting a config in /etc/ceph entirely, so that the daemon data
>       is
>       completely self-contained on the device.  That would streamline
>       boot disk
>       failure (just reinstall OS and ceph package) or drive swaps
>       between failed
>       host hardware.
> 
>       What do you think?
> 
> 
> Totally agreed!
> 
> Actually we have implemented alike thing downstream, ceph-osd,ceph-mon will
> check ceph.conf in the local dir(/var/lib/ceph/*/*/ceph.conf) then overwrite
> existing config values. That's said, it will load system ceph
> config(/etc/ceph/ceph.conf) file then load local ceph.conf.

The one reservation about this direction is that there are a few devices 
where I'm not sure how to attach the metadata (keyring, conf, and other 
random bits in the osd_data dir) to the device: the SPDK NVMe driver, and 
kinetic.  These are somewhat obscure, but I'm curious if there are other 
ideas floating around about how this should be approached...

sage
--8323329-43724043-1453221995=:28274--
