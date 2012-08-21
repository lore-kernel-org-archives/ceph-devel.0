From: Sage Weil <sage@inktank.com>
Subject: Re: ceph osd create
Date: Tue, 21 Aug 2012 11:15:00 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1208211114370.32470@cobra.newdream.net>
References: <CA+jddaMGhVvOReO854qbQM=j2X3rhM2FtbwLu4DOpYLkr5UW_A@mail.gmail.com> <CADvuQRGCpKP+ePn4phE_WbvG0nYubKhL_oa3CaqO5D4AuU-5+g@mail.gmail.com> <CA+jddaP=-6kO-ewLoNnWeg6b552p=nLA6ycQt_4qoDj7sVHy0w@mail.gmail.com> <CADvuQRFTz_xBUuZueNQLuNTEmK7CqZE8cDAD9B6=3hQYbDXyLQ@mail.gmail.com>
 <CA+jddaNNHAEyvD8QKOhKrLQgMGarE47DGnTN6CH60VL8AmU8XA@mail.gmail.com> <CADvuQRE1gc-sCfTcwhnpJSP8h084KM-XUk6W4Azc6D1DBckZaA@mail.gmail.com> <CA+jddaOy==mTz7WoEcFt+SrFMvQieom69Rs6cMViMR3gaD=+7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42336 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758337Ab2HUSPA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Aug 2012 14:15:00 -0400
In-Reply-To: <CA+jddaOy==mTz7WoEcFt+SrFMvQieom69Rs6cMViMR3gaD=+7A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mandell Degerness <mandell@pistoncloud.com>
Cc: ceph-devel@vger.kernel.org

On Tue, 21 Aug 2012, Mandell Degerness wrote:
> OK.  I think I'm getting there.
> 
> I want to be able to generate the fsid to be used in the OSD (from the
> file system fsid, if that matters).  Is there a way to inject the fsid
> when initializing the OSD directory?  It doesn't seem to be
> documented.  The alternative would require that we mount the OSD in a
> temp dir to read the fsid file, determine the OSD number, and then
> re-mount it where it belongs, which seems the wrong way to go.

You can feed in the fsid to ceph-osd --mkfs with --osd-fsid <uuid>.

sage

> 
> Regards,
> Mandell Degerness
> 
> On Mon, Aug 20, 2012 at 4:26 PM, Tommi Virtanen <tv@inktank.com> wrote:
> > On Mon, Aug 20, 2012 at 3:53 PM, Mandell Degerness
> > <mandell@pistoncloud.com> wrote:
> >> We're running Argonaut and it only has the OSD id in the whoami file
> >> and nothing else.
> >
> > My bad, I meant the file "fsid" (note, not "ceph_fsid").
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
