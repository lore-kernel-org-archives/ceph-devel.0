From: Mandell Degerness <mandell@pistoncloud.com>
Subject: Re: ceph osd create
Date: Tue, 21 Aug 2012 11:01:07 -0700
Message-ID: <CA+jddaOy==mTz7WoEcFt+SrFMvQieom69Rs6cMViMR3gaD=+7A@mail.gmail.com>
References: <CA+jddaMGhVvOReO854qbQM=j2X3rhM2FtbwLu4DOpYLkr5UW_A@mail.gmail.com>
	<CADvuQRGCpKP+ePn4phE_WbvG0nYubKhL_oa3CaqO5D4AuU-5+g@mail.gmail.com>
	<CA+jddaP=-6kO-ewLoNnWeg6b552p=nLA6ycQt_4qoDj7sVHy0w@mail.gmail.com>
	<CADvuQRFTz_xBUuZueNQLuNTEmK7CqZE8cDAD9B6=3hQYbDXyLQ@mail.gmail.com>
	<CA+jddaNNHAEyvD8QKOhKrLQgMGarE47DGnTN6CH60VL8AmU8XA@mail.gmail.com>
	<CADvuQRE1gc-sCfTcwhnpJSP8h084KM-XUk6W4Azc6D1DBckZaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:62492 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755894Ab2HUSBI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Aug 2012 14:01:08 -0400
Received: by qcro28 with SMTP id o28so70083qcr.19
        for <ceph-devel@vger.kernel.org>; Tue, 21 Aug 2012 11:01:08 -0700 (PDT)
In-Reply-To: <CADvuQRE1gc-sCfTcwhnpJSP8h084KM-XUk6W4Azc6D1DBckZaA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

OK.  I think I'm getting there.

I want to be able to generate the fsid to be used in the OSD (from the
file system fsid, if that matters).  Is there a way to inject the fsid
when initializing the OSD directory?  It doesn't seem to be
documented.  The alternative would require that we mount the OSD in a
temp dir to read the fsid file, determine the OSD number, and then
re-mount it where it belongs, which seems the wrong way to go.

Regards,
Mandell Degerness

On Mon, Aug 20, 2012 at 4:26 PM, Tommi Virtanen <tv@inktank.com> wrote:
> On Mon, Aug 20, 2012 at 3:53 PM, Mandell Degerness
> <mandell@pistoncloud.com> wrote:
>> We're running Argonaut and it only has the OSD id in the whoami file
>> and nothing else.
>
> My bad, I meant the file "fsid" (note, not "ceph_fsid").
