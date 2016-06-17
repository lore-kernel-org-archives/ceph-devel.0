From: Wido den Hollander <wido@42on.com>
Subject: Re: Dramatic performance drop at certain number of objects in pool
Date: Fri, 17 Jun 2016 10:49:01 +0200 (CEST)
Message-ID: <1602643738.32.1466153341358@ox.pcextreme.nl>
References: <CA+e22ScW-YrDE0mPABSuiDbDpKL=gYZXv6t2hK8RJxYuMaVLHg@mail.gmail.com>
 <1450235390.2134.1466084299677@ox.pcextreme.nl>
 <CA+e22Seqy-0rQTDt7PhYmYBsUrqqdWiN2QcyBt1RYz6QrBRtPg@mail.gmail.com>
 <CA+e22Sf+=0t868AbAdh_NU3prVxEVzAriTpBG9THajbT5Q4X1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.139]:54464 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752337AbcFQItF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 17 Jun 2016 04:49:05 -0400
In-Reply-To: <CA+e22Sf+=0t868AbAdh_NU3prVxEVzAriTpBG9THajbT5Q4X1g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wade Holler <wade.holler@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>


> Op 16 juni 2016 om 18:08 schreef Wade Holler <wade.holler@gmail.com>:
> 
> 
> Ok.  Of the 202 pgs on this example OSD,
> 
> 65 of them have around ~160k files
> 137 ( the rest ) -have around ~80k files
> 

Are those files in the same directory or spread out over multiple sub directories?

You might want to take a look at: http://docs.ceph.com/docs/jewel/rados/configuration/filestore-config-ref/

"filestore split multiple"

Wido

> 
> 
> On Thu, Jun 16, 2016 at 10:47 AM, Wade Holler <wade.holler@gmail.com> wrote:
> > Wido,
> >
> > I am walking an Example OSD now and counting the files. 3096 PGs for this pool.
> > So far file counts inside the pool.pg_head directories are all coming
> > in around ~80k.
> >
> > Is this an issue ?
> >
> > I will report back with all pg_head file counts in this example OSD
> > once it finishes.
> >
> > Best Regards,
> > Wade
> >
> >
> > On Thu, Jun 16, 2016 at 9:38 AM, Wido den Hollander <wido@42on.com> wrote:
> >>
> >>> Op 16 juni 2016 om 14:14 schreef Wade Holler <wade.holler@gmail.com>:
> >>>
> >>>
> >>> Hi All,
> >>>
> >>> I have a repeatable condition when the object count in a pool gets to
> >>> 320-330 million the object write time dramatically and almost
> >>> instantly increases as much as 10X, exhibited by fs_apply_latency
> >>> going from 10ms to 100s of ms.
> >>>
> >>
> >> My first guess is the filestore splitting and the amount of files per directory.
> >>
> >> You have 3*16=48 OSDs, is that correct? With roughly 100 PGs per OSD you have let's say 4800 PGs in total?
> >>
> >> That means you have ~66k objects per PG.
> >>
> >>> Can someone point me in a direction / have an explanation ?
> >>
> >> If you take a look at one of the OSDs, are there a huge amount of files in a single directory? Look inside the 'current' directory on that OSDs.
> >>
> >> Wido
> >>
> >>>
> >>> I can add a new pool and it performs normally.
> >>>
> >>> Config is generally
> >>> 3 Nodes 24 physical core each, 768GB Ram each, 16 OSD / node , all SSD
> >>> with NVME for journals. Centos 7.2, XFS
> >>>
> >>> Jewell is the release; inserting objects with librados via some Python
> >>> test code.
> >>>
> >>> Best Regards
> >>> Wade
> >>> --
> >>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >>> the body of a message to majordomo@vger.kernel.org
> >>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
