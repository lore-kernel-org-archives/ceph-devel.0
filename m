From: Tommi Virtanen <tv@inktank.com>
Subject: Re: ceph osd create
Date: Mon, 20 Aug 2012 16:26:35 -0700
Message-ID: <CADvuQRE1gc-sCfTcwhnpJSP8h084KM-XUk6W4Azc6D1DBckZaA@mail.gmail.com>
References: <CA+jddaMGhVvOReO854qbQM=j2X3rhM2FtbwLu4DOpYLkr5UW_A@mail.gmail.com>
 <CADvuQRGCpKP+ePn4phE_WbvG0nYubKhL_oa3CaqO5D4AuU-5+g@mail.gmail.com>
 <CA+jddaP=-6kO-ewLoNnWeg6b552p=nLA6ycQt_4qoDj7sVHy0w@mail.gmail.com>
 <CADvuQRFTz_xBUuZueNQLuNTEmK7CqZE8cDAD9B6=3hQYbDXyLQ@mail.gmail.com> <CA+jddaNNHAEyvD8QKOhKrLQgMGarE47DGnTN6CH60VL8AmU8XA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:47571 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752167Ab2HTXbv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Aug 2012 19:31:51 -0400
Received: by vbbff1 with SMTP id ff1so5924692vbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 20 Aug 2012 16:31:50 -0700 (PDT)
In-Reply-To: <CA+jddaNNHAEyvD8QKOhKrLQgMGarE47DGnTN6CH60VL8AmU8XA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mandell Degerness <mandell@pistoncloud.com>
Cc: ceph-devel@vger.kernel.org

On Mon, Aug 20, 2012 at 3:53 PM, Mandell Degerness
<mandell@pistoncloud.com> wrote:
> We're running Argonaut and it only has the OSD id in the whoami file
> and nothing else.

My bad, I meant the file "fsid" (note, not "ceph_fsid").
