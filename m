From: Tommi Virtanen <tv@inktank.com>
Subject: Re: ceph osd create
Date: Tue, 21 Aug 2012 11:13:21 -0700
Message-ID: <CADvuQRELuBb4PCr=jN08EdZRmkmd8NbuK8FtuG6XynWcMdKX_g@mail.gmail.com>
References: <CA+jddaMGhVvOReO854qbQM=j2X3rhM2FtbwLu4DOpYLkr5UW_A@mail.gmail.com>
 <CADvuQRGCpKP+ePn4phE_WbvG0nYubKhL_oa3CaqO5D4AuU-5+g@mail.gmail.com>
 <CA+jddaP=-6kO-ewLoNnWeg6b552p=nLA6ycQt_4qoDj7sVHy0w@mail.gmail.com>
 <CADvuQRFTz_xBUuZueNQLuNTEmK7CqZE8cDAD9B6=3hQYbDXyLQ@mail.gmail.com>
 <CA+jddaNNHAEyvD8QKOhKrLQgMGarE47DGnTN6CH60VL8AmU8XA@mail.gmail.com>
 <CADvuQRE1gc-sCfTcwhnpJSP8h084KM-XUk6W4Azc6D1DBckZaA@mail.gmail.com> <CA+jddaOy==mTz7WoEcFt+SrFMvQieom69Rs6cMViMR3gaD=+7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:65043 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932196Ab2HUSSt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Aug 2012 14:18:49 -0400
Received: by vcbfk26 with SMTP id fk26so120535vcb.19
        for <ceph-devel@vger.kernel.org>; Tue, 21 Aug 2012 11:18:48 -0700 (PDT)
In-Reply-To: <CA+jddaOy==mTz7WoEcFt+SrFMvQieom69Rs6cMViMR3gaD=+7A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mandell Degerness <mandell@pistoncloud.com>
Cc: ceph-devel@vger.kernel.org

On Tue, Aug 21, 2012 at 11:01 AM, Mandell Degerness
<mandell@pistoncloud.com> wrote:
> I want to be able to generate the fsid to be used in the OSD (from the
> file system fsid, if that matters).  Is there a way to inject the fsid
> when initializing the OSD directory?  It doesn't seem to be
> documented.  The alternative would require that we mount the OSD in a
> temp dir to read the fsid file, determine the OSD number, and then
> re-mount it where it belongs, which seems the wrong way to go.

It's just a uuid.

Oh and you don't have to read the files if you don't want to get your
hands dirty; these days ceph-osd has --get-cluster-fsid,
--get-osd-fsid, --get-journal-fsid options:
http://ceph.com/docs/master/man/8/ceph-osd/

You can set the osd uuid at ceph-osd --mkfs time, just pass in --osd-uuid.

Sounds like you want to explore the world of OSD hotplugging. It comes
down to these two guys:

1. ceph-disk-prepare will take a block device, create a partition
table from scratch, and put the right stuff in place for the disk to
later become an active osd.

2. ceph-disk-activate, triggered by udev->upstart, or manually (later
udev->other init systems), will ceph-osd --mkfs the disk and start an
osd for it (currently upstart only).

https://github.com/ceph/ceph/blob/master/src/ceph-disk-activate
https://github.com/ceph/ceph/blob/master/src/ceph-disk-prepare

I'll happily explain this more, but I'd recommend you take a couple of
Ubuntu 12.04 virtual machines and run through the Chef installation
scenario in
http://ceph.com/docs/master/install/chef/
http://ceph.com/docs/master/config-cluster/
-- that'll probably help you understand the components better. None of
the underlying functionality is tied to Chef, that's just the first
thing getting ready.
