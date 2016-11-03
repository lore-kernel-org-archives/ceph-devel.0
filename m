From: Sage Weil <sweil@redhat.com>
Subject: RE: ceph, XioMessenger issue
Date: Thu, 3 Nov 2016 14:22:32 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1611031421330.20331@piezo.us.to>
References: <FEC85B105C5F644CA51BDB90657EEA98281CB374@ddsm-mbx01.digdes.com> <alpine.DEB.2.11.1611022003390.20331@piezo.us.to> <DB5PR05MB1607074AA7D7B7E04076A241A9A30@DB5PR05MB1607.eurprd05.prod.outlook.com> <1286081286.93716669.1478177382304.JavaMail.zimbra@redhat.com>
 <DB5PR05MB160708C3D1918AA60BC183FEA9A30@DB5PR05MB1607.eurprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49522 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756233AbcKCOWg (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 3 Nov 2016 10:22:36 -0400
In-Reply-To: <DB5PR05MB160708C3D1918AA60BC183FEA9A30@DB5PR05MB1607.eurprd05.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Avner Ben Hanoch <avnerb@mellanox.com>
Cc: Matt Benjamin <mbenjamin@redhat.com>, Marov Aleksey <Marov.A@raidix.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

It's merged now.  In the future if you have a lingering PR like this 
please harass someone on IRC on ceph-devel.  No reason to be blocked for 4 
months!  :)

sage


On Thu, 3 Nov 2016, Avner Ben Hanoch wrote:

> HI Matt,
> 
> Thanks for your suggestion, we'll consider it.
> In general, we don't submit PRs in parallel because we want control on their acceptance order since many times one Xio PR is based on the other.
> 
> Regards,
> Avner
> 
> > -----Original Message-----
> > From: Matt Benjamin [mailto:mbenjamin@redhat.com]
> > Sent: Thursday, November 03, 2016 14:50
> > Subject: Re: ceph, XioMessenger issue
> > 
> > Hi Avner,
> > 
> > Please make your work visible by creating PRs for your pipeline of commits.  If
> > many commits are of a similar type, such as this 1-line cleanup, please
> > consider batching them into a smaller number of PRs.
> > 
> > Regards,
> > 
> > Matt
> > 
> > ----- Original Message -----
> > > From: "Avner Ben Hanoch" <avnerb@mellanox.com>
> > > To: "Sage Weil" <sweil@redhat.com>, "Marov Aleksey"
> > > <Marov.A@raidix.com>
> > > Cc: ceph-devel@vger.kernel.org
> > > Sent: Thursday, November 3, 2016 3:27:40 AM
> > > Subject: RE: ceph, XioMessenger issue
> > >
> > > We (in Mellanox) build with Xio on a regular basis.  We have a bunch
> > > of commits in the pipe that we are submitting 1 after the other.
> > > Currently, the pipe is blocked by this PR
> > > https://github.com/ceph/ceph/pull/9444
> > > After we complete releasing new version here we'll struggle with the
> > > needed merges
> > >
> > > > -----Original Message-----
> > > > From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> > > > owner@vger.kernel.org] On Behalf Of Sage Weil
> > > > Sent: Wednesday, November 02, 2016 22:07
> > > > To: Marov Aleksey
> > > >
> > > >
> > > > It sounds like nobody else has hit this yet except you, so
> > > > apparently others also are building with[out] xio in their dev
> > > > environments.  :(
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> > > in the body of a message to majordomo@vger.kernel.org More majordomo
> > > info at  http://vger.kernel.org/majordomo-info.html
> > >
> > 
> > --
> > Matt Benjamin
> > Red Hat, Inc.
> > 315 West Huron Street, Suite 140A
> > Ann Arbor, Michigan 48103
> > 
> > http://www.redhat.com/en/technologies/storage
> > 
> > tel.  734-707-0660
> > fax.  734-769-8938
> > cel.  734-216-5309
> 
