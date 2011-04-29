From: Ajit K Jena <ajit@iitb.ac.in>
Subject: Re: Data replication not working
Date: Fri, 29 Apr 2011 13:52:05 +0530
Message-ID: <1304065325.27812.24.camel@indica.cc.iitb.ac.in>
References: <1303980121.11285.3.camel@indica.cc.iitb.ac.in>
	 <BANLkTik5CCdVnLhQZGRiig9sZwsnCDzyjg@mail.gmail.com>
	 <1303987194.12689.4.camel@indica.cc.iitb.ac.in>
	 <BANLkTin1UkKe7P4ZDjMsmoMNekCFJum5BA@mail.gmail.com>
	 <BANLkTikuhGnsH2Xr2C4dAPGgvfkS2TW6cQ@mail.gmail.com>
Reply-To: ajit@iitb.ac.in
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.iitb.ac.in ([59.162.23.13]:57431 "HELO smtp1.iitb.ac.in"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753927Ab1D2IWI (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 29 Apr 2011 04:22:08 -0400
In-Reply-To: <BANLkTikuhGnsH2Xr2C4dAPGgvfkS2TW6cQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Henry Chang <henry.cy.chang@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi Henry,

Where can I find out about the semantics of the different
fields in different maps ? Is there any formal documentation ?

Pl suggest.

--ajit

On Fri, 2011-04-29 at 10:56 +0800, Henry Chang wrote:
> Ahh... After checking your ceph.conf, I think I see the problem. The
> osd ids in your ceph.conf are 1,2,3 but in your crushmap, they are
> 0,1,2. That's why the data never go to osd3.
> 
> 2011/4/29 Henry Chang <henry.cy.chang@gmail.com>:
> > Hmm...... The crushmap looks fine to me. Could you have a pg dump (by
> > ceph pg dump -o -) and check the pg membership to see if the third osd
> > is responsible for some pgs? And as Greg asked, it would be more
> > helpful if you could provide more info/description about this problem.
> >
> > Thanks,
> > Henry
> >
> > 2011/4/28 Ajit K Jena <ajit@iitb.ac.in>:
> >> Hi Henry,
> >>
> >> Thanks for your quick reply. I believe our crushmap is
> >> updated correctly to take care of osd node failures. I
> >> am attaching the text version of the crushmap with this
> >> mail. Pl help us find the mistake if any.
> >>
> >> Regards.
> >>
> >> --ajit
> >>
> >>
> >> On Thu, 2011-04-28 at 17:10 +0800, Henry Chang wrote:
> >>> 2011/4/28 Ajit K Jena <ajit@iitb.ac.in>:
> >>> > Hi All,
> >>> >
> >>> > We have been experimenting with ceph since version 0.24 and
> >>> > found one important issue that is not resolved (or may be
> >>> > we don't know how to configure properly).
> >>> >
> >>> > I will talk about 0.27 since that is the latest release:
> >>> >
> >>> >  We have a one mon, one mds, and two osd setup. The data
> >>> >  stored goes to both the osds. We introduce a third osd.
> >>> >  the ceph status shows "osd: 3 up, 3 in" but no data goes
> >>> >  into the third osd. This remains the case even if we
> >>> >  power off one of the original osds.
> >>> >
> >>> > Data reliability thru replication is one of the major goals
> >>> > of ceph. I am wondering as to what we might be missing to
> >>> > get this feature going. I am attaching the configuration
> >>> > file.
> >>> >
> >>> > Pl help us solve this problem.
> >>> >
> >>> > Regards.
> >>> >
> >>> > --ajit
> >>> >
> >>>
> >>> Hi Ajit,
> >>>
> >>> The symptom looks like the crushmap has not been updated after you
> >>> introduced the third osd, so the data never goes into it. If that is
> >>> the case, you may refer to the wiki page
> >>> (http://ceph.newdream.net/wiki/OSD_cluster_expansion/contraction#Include_the_new_OSD_in_the_data_placement)
> >>> to adjust the crushmap of your cluster.
> >>>
> >>> Cheers,
> >>> --
> >>> Henry
> >>> --
> >>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >>> the body of a message to majordomo@vger.kernel.org
> >>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>
> >>
> >
> >
> >
> > --
> > Henry Chang
> >
> 
> 
> 


