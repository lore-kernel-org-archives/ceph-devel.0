From: Mandell Degerness <mandell@pistoncloud.com>
Subject: Re: ceph osd create
Date: Mon, 20 Aug 2012 15:53:45 -0700
Message-ID: <CA+jddaNNHAEyvD8QKOhKrLQgMGarE47DGnTN6CH60VL8AmU8XA@mail.gmail.com>
References: <CA+jddaMGhVvOReO854qbQM=j2X3rhM2FtbwLu4DOpYLkr5UW_A@mail.gmail.com>
	<CADvuQRGCpKP+ePn4phE_WbvG0nYubKhL_oa3CaqO5D4AuU-5+g@mail.gmail.com>
	<CA+jddaP=-6kO-ewLoNnWeg6b552p=nLA6ycQt_4qoDj7sVHy0w@mail.gmail.com>
	<CADvuQRFTz_xBUuZueNQLuNTEmK7CqZE8cDAD9B6=3hQYbDXyLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:47120 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754289Ab2HTWxq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Aug 2012 18:53:46 -0400
Received: by qcro28 with SMTP id o28so4705181qcr.19
        for <ceph-devel@vger.kernel.org>; Mon, 20 Aug 2012 15:53:46 -0700 (PDT)
In-Reply-To: <CADvuQRFTz_xBUuZueNQLuNTEmK7CqZE8cDAD9B6=3hQYbDXyLQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

We're running Argonaut and it only has the OSD id in the whoami file
and nothing else.

-Mandell

On Mon, Aug 20, 2012 at 1:37 PM, Tommi Virtanen <tv@inktank.com> wrote:
> On Mon, Aug 20, 2012 at 1:30 PM, Mandell Degerness
> <mandell@pistoncloud.com> wrote:
>> Is there now, or will there be a migration path that works to add
>> existing OSDs to the function such that future calls to "ceph osd
>> create <uuid>" return the current OSD number used in an existing
>> configuration?  I am content if it is an undocumented hack that I can
>> run on each OSD to register the information with the monitors (I am
>> assuming that is where the correlation is stored).
>
> Hmm. My understanding is that OSDs have had the uuid for a while, and
> are submitting it to be part of the osdmap, so that *should* just
> start working right if you're running recent code.
>
> It's stored in the "whoami" file in the osd_data dir. Pick an OSD, cat
> its whoami file, run "ceph osd create <uuid>", and if you get back an
> id that doesn't match with what that osd was, say oops and "ceph osd
> rm <new_bad_id>".
