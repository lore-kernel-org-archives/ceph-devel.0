From: Sage Weil <sage@inktank.com>
Subject: Re: ceph osd create
Date: Wed, 22 Aug 2012 08:32:46 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1208220832090.25274@cobra.newdream.net>
References: <CA+jddaMGhVvOReO854qbQM=j2X3rhM2FtbwLu4DOpYLkr5UW_A@mail.gmail.com> <CADvuQRGCpKP+ePn4phE_WbvG0nYubKhL_oa3CaqO5D4AuU-5+g@mail.gmail.com> <CA+jddaP=-6kO-ewLoNnWeg6b552p=nLA6ycQt_4qoDj7sVHy0w@mail.gmail.com> <CADvuQRFTz_xBUuZueNQLuNTEmK7CqZE8cDAD9B6=3hQYbDXyLQ@mail.gmail.com>
 <CA+jddaNNHAEyvD8QKOhKrLQgMGarE47DGnTN6CH60VL8AmU8XA@mail.gmail.com> <CADvuQRE1gc-sCfTcwhnpJSP8h084KM-XUk6W4Azc6D1DBckZaA@mail.gmail.com> <CA+jddaOy==mTz7WoEcFt+SrFMvQieom69Rs6cMViMR3gaD=+7A@mail.gmail.com> <alpine.DEB.2.00.1208211114370.32470@cobra.newdream.net>
 <CA+jddaPtEv5xBNNOxK1eJHV-AzrTkr8N1wm7qRNsktaLefijEQ@mail.gmail.com> <CA+jddaOfMvTM4-PGFn_qW2jmQbvFi_q9pSUKogd=LWuKW9tf6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47833 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932740Ab2HVPcr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Aug 2012 11:32:47 -0400
In-Reply-To: <CA+jddaOfMvTM4-PGFn_qW2jmQbvFi_q9pSUKogd=LWuKW9tf6Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mandell Degerness <mandell@pistoncloud.com>
Cc: ceph-devel@vger.kernel.org

On Tue, 21 Aug 2012, Mandell Degerness wrote:
> Found it (digging through the source code to find a guess, since it is
> in no way obvious):  --osd-uuid <uuid>

Whoops, sorry, yeah.  It appeared in 0.47.

sage

> 
> On Tue, Aug 21, 2012 at 4:38 PM, Mandell Degerness
> <mandell@pistoncloud.com> wrote:
> > Thanks, Sage.  This is what I was looking for, but what version of
> > ceph do I need for this to work (it isn't there in Argonaut)?  See
> > below:
> >
> > # ceph-osd -c /etc/ceph/ceph.conf --fsid
> > 8296cc23-9c11-44d7-84c1-16866ef9c4f7 -i 50 --mkfs --osd-fsid
> > e1097bd8-c931-4e2e-8ccb-332a954adace
> >   --conf/-c        Read configuration from the given configuration file
> >   -d               Run in foreground, log to stderr.
> >   -f               Run in foreground, log to usual location.
> >   --id/-i          set ID portion of my name
> >   --name/-n        set name (TYPE.ID)
> >   --version        show version and quit
> >
> >   --debug_ms N
> >         set message debug level (e.g. 1)
> > 2012-08-21 23:26:50.774858 7f1be9ac1780 -1 unrecognized arg --osd-fsid
> > 2012-08-21 23:26:50.774864 7f1be9ac1780 -1 usage: ceph-osd -i osdid
> > [--osd-data=path] [--osd-journal=path] [--mkfs] [--mkjournal]
> > [--convert-filestore]
> > 2012-08-21 23:26:50.774915 7f1be9ac1780 -1    --debug_osd N   set
> > debug level (e.g. 10)
> >
> > # ceph --version
> > ceph version 0.48.1argonaut (commit:a7ad701b9bd479f20429f19e6fea7373ca6bba7c)
> >
> > Tommi - Thank you for the suggestion of ceph-disk-prepare and
> > ceph-disk-activate, but they work at too high of a level for our
> > usage.  We need finer control of the block devices.
> >
> > Regards,
> > Mandell Degerness
> >
> > On Tue, Aug 21, 2012 at 11:15 AM, Sage Weil <sage@inktank.com> wrote:
> >> On Tue, 21 Aug 2012, Mandell Degerness wrote:
> >>> OK.  I think I'm getting there.
> >>>
> >>> I want to be able to generate the fsid to be used in the OSD (from the
> >>> file system fsid, if that matters).  Is there a way to inject the fsid
> >>> when initializing the OSD directory?  It doesn't seem to be
> >>> documented.  The alternative would require that we mount the OSD in a
> >>> temp dir to read the fsid file, determine the OSD number, and then
> >>> re-mount it where it belongs, which seems the wrong way to go.
> >>
> >> You can feed in the fsid to ceph-osd --mkfs with --osd-fsid <uuid>.
> >>
> >> sage
> >>
> >>>
> >>> Regards,
> >>> Mandell Degerness
> >>>
> >>> On Mon, Aug 20, 2012 at 4:26 PM, Tommi Virtanen <tv@inktank.com> wrote:
> >>> > On Mon, Aug 20, 2012 at 3:53 PM, Mandell Degerness
> >>> > <mandell@pistoncloud.com> wrote:
> >>> >> We're running Argonaut and it only has the OSD id in the whoami file
> >>> >> and nothing else.
> >>> >
> >>> > My bad, I meant the file "fsid" (note, not "ceph_fsid").
> >>> --
> >>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >>> the body of a message to majordomo@vger.kernel.org
> >>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>>
> >>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
