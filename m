From: Tommi Virtanen <tv@inktank.com>
Subject: Re: ceph osd create
Date: Mon, 20 Aug 2012 13:37:15 -0700
Message-ID: <CADvuQRFTz_xBUuZueNQLuNTEmK7CqZE8cDAD9B6=3hQYbDXyLQ@mail.gmail.com>
References: <CA+jddaMGhVvOReO854qbQM=j2X3rhM2FtbwLu4DOpYLkr5UW_A@mail.gmail.com>
 <CADvuQRGCpKP+ePn4phE_WbvG0nYubKhL_oa3CaqO5D4AuU-5+g@mail.gmail.com> <CA+jddaP=-6kO-ewLoNnWeg6b552p=nLA6ycQt_4qoDj7sVHy0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:48257 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751255Ab2HTUhg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Aug 2012 16:37:36 -0400
Received: by vcbfk26 with SMTP id fk26so5386885vcb.19
        for <ceph-devel@vger.kernel.org>; Mon, 20 Aug 2012 13:37:35 -0700 (PDT)
In-Reply-To: <CA+jddaP=-6kO-ewLoNnWeg6b552p=nLA6ycQt_4qoDj7sVHy0w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mandell Degerness <mandell@pistoncloud.com>
Cc: ceph-devel@vger.kernel.org

On Mon, Aug 20, 2012 at 1:30 PM, Mandell Degerness
<mandell@pistoncloud.com> wrote:
> Is there now, or will there be a migration path that works to add
> existing OSDs to the function such that future calls to "ceph osd
> create <uuid>" return the current OSD number used in an existing
> configuration?  I am content if it is an undocumented hack that I can
> run on each OSD to register the information with the monitors (I am
> assuming that is where the correlation is stored).

Hmm. My understanding is that OSDs have had the uuid for a while, and
are submitting it to be part of the osdmap, so that *should* just
start working right if you're running recent code.

It's stored in the "whoami" file in the osd_data dir. Pick an OSD, cat
its whoami file, run "ceph osd create <uuid>", and if you get back an
id that doesn't match with what that osd was, say oops and "ceph osd
rm <new_bad_id>".
