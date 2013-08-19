From: Sage Weil <sage@inktank.com>
Subject: RE: [ceph-users] large memory leak on scrubbing
Date: Mon, 19 Aug 2013 08:55:37 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1308190853590.11018@cobra.newdream.net>
References: <ADBDB4FFB0814748AF32D0A1EE6E10AF228322C75B@MXMBON06.grupa.onet> <alpine.DEB.2.00.1308170808070.1479@cobra.newdream.net> <ADBDB4FFB0814748AF32D0A1EE6E10AF228322C852@MXMBON06.grupa.onet>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46621 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750820Ab3HSPzi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Aug 2013 11:55:38 -0400
In-Reply-To: <ADBDB4FFB0814748AF32D0A1EE6E10AF228322C852@MXMBON06.grupa.onet>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mostowiec Dominik <Dominik.Mostowiec@grupaonet.pl>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, =?ISO-8859-2?Q?Studzi=F1ski_Krzysztof?= <krzysztof.studzinski@grupaonet.pl>, Sydor Bohdan <Bohdan.Sydor@grupaonet.pl>

On Mon, 19 Aug 2013, Mostowiec Dominik wrote:
> Thanks for your response.
> Great.
> 
> In latest cuttlefish it is also fixed I think?
> 
> We have two problems with scrubbing:
> - memory leaks
> - slow requests and wrongly mark osd with bucket index down (when scrubbing)

The slow requests can trigger if you have very large objects (including 
a very large rgw bucket index object).  But the message you quote below is 
for a scrub-reserve operation, which should really be excluded from the op 
warnings entirely.  Is that the only slow request message you see?

> Now we decided to turn off scrubbing and trigger it on maintenance window.
> I noticed that "ceph osd scrub", or "ceph osd deep-scrub" trigger scrub on osd but not for all PG.
> It is possible to trigger scrubbing all PG on one osd?

It should trigger a scrub on all PGs that are clean.  If a PG is 
recovering it will be skipped.

sage


> 
> --
> Regards 
> Dominik
> 
> 
> -----Original Message-----
> From: Sage Weil [mailto:sage@inktank.com] 
> Sent: Saturday, August 17, 2013 5:11 PM
> To: Mostowiec Dominik
> Cc: ceph-devel@vger.kernel.org; ceph-users@lists.ceph.com; Studzi?ski Krzysztof; Sydor Bohdan
> Subject: Re: [ceph-users] large memory leak on scrubbing
> 
> Hi Dominic,
> 
> There is a bug fixed a couple of months back that fixes excessive memory consumption during scrub.  You can upgrade to the latest 'bobtail' branch.  
> See
> 
>  http://ceph.com/docs/master/install/debian/#development-testing-packages
> 
> Installing that package should clear this up.
> 
> sage
> 
> 
> On Fri, 16 Aug 2013, Mostowiec Dominik wrote:
> 
> > Hi,
> > We noticed some issues on CEPH/S3 cluster, I think it related with scrubbing: large memory leaks.
> > 
> > Logs 09.xx: 
> > https://www.dropbox.com/s/4z1fzg239j43igs/ceph-osd.4.log_09xx.tar.gz
> > >From 09.30 to 09.44 (14 minutes) osd.4 proces grows up to 28G. 
> > 
> > I think this is something curious:
> > 2013-08-16 09:43:48.801331 7f6570d2e700  0 log [WRN] : slow request 
> > 32.794125 seconds old, received at 2013-08-16 09:43:16.007104: 
> > osd_sub_op(unknown.0.0:0 16.113d 0//0//-1 [scrub-reserve] v 0'0 
> > snapset=0=[]:[] snapc=0=[]) v7 currently no flag points reached
> > 
> > We have large rgw index and a lot of large files than on this cluster.
> > ceph version 0.56.6 (95a0bda7f007a33b0dc7adf4b330778fa1e5d70c)
> > Setup: 
> > - 12 servers x 12 OSD
> > - 3 mons
> > Default scrubbing settings.
> > Journal and filestore settings:
> >         journal aio = true
> >         filestore flush min = 0
> >         filestore flusher = false
> >         filestore fiemap = false
> >         filestore op threads = 4
> >         filestore queue max ops = 4096
> >         filestore queue max bytes = 10485760
> >         filestore queue committing max bytes = 10485760
> >         journal max write bytes = 10485760
> >         journal queue max bytes = 10485760
> >         ms dispatch throttle bytes = 10485760
> >         objecter infilght op bytes = 10485760
> > 
> > Is this a known bug in this version?
> > (Do you know some workaround to fix this?)
> > 
> > ---
> > Regards
> > Dominik
> > 
> > _______________________________________________
> > ceph-users mailing list
> > ceph-users@lists.ceph.com
> > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> > 
> > 
> 
> 
