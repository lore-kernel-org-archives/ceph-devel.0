From: Ajit K Jena <ajit@iitb.ac.in>
Subject: Re: Data replication not working
Date: Thu, 28 Apr 2011 16:09:54 +0530
Message-ID: <1303987194.12689.4.camel@indica.cc.iitb.ac.in>
References: <1303980121.11285.3.camel@indica.cc.iitb.ac.in>
	 <BANLkTik5CCdVnLhQZGRiig9sZwsnCDzyjg@mail.gmail.com>
Reply-To: ajit@iitb.ac.in
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-TMjNkvVIUfZpWZvE9Hdz"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.iitb.ac.in ([59.162.23.13]:39712 "HELO smtp1.iitb.ac.in"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754700Ab1D1Kn5 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 28 Apr 2011 06:43:57 -0400
In-Reply-To: <BANLkTik5CCdVnLhQZGRiig9sZwsnCDzyjg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Henry Chang <henry.cy.chang@gmail.com>
Cc: ceph-devel@vger.kernel.org


--=-TMjNkvVIUfZpWZvE9Hdz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi Henry,

Thanks for your quick reply. I believe our crushmap is
updated correctly to take care of osd node failures. I
am attaching the text version of the crushmap with this
mail. Pl help us find the mistake if any.

Regards.

--ajit


On Thu, 2011-04-28 at 17:10 +0800, Henry Chang wrote:
> 2011/4/28 Ajit K Jena <ajit@iitb.ac.in>:
> > Hi All,
> >
> > We have been experimenting with ceph since version 0.24 and
> > found one important issue that is not resolved (or may be
> > we don't know how to configure properly).
> >
> > I will talk about 0.27 since that is the latest release:
> >
> >  We have a one mon, one mds, and two osd setup. The data
> >  stored goes to both the osds. We introduce a third osd.
> >  the ceph status shows "osd: 3 up, 3 in" but no data goes
> >  into the third osd. This remains the case even if we
> >  power off one of the original osds.
> >
> > Data reliability thru replication is one of the major goals
> > of ceph. I am wondering as to what we might be missing to
> > get this feature going. I am attaching the configuration
> > file.
> >
> > Pl help us solve this problem.
> >
> > Regards.
> >
> > --ajit
> >
> 
> Hi Ajit,
> 
> The symptom looks like the crushmap has not been updated after you
> introduced the third osd, so the data never goes into it. If that is
> the case, you may refer to the wiki page
> (http://ceph.newdream.net/wiki/OSD_cluster_expansion/contraction#Include_the_new_OSD_in_the_data_placement)
> to adjust the crushmap of your cluster.
> 
> Cheers,
> --
> Henry
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--=-TMjNkvVIUfZpWZvE9Hdz
Content-Disposition: attachment; filename="crush.txt"
Content-Type: text/plain; name="crush.txt"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

# begin crush map

# devices
device 0 device0
device 1 device1
device 2 device2

# types
type 0 device
type 1 domain
type 2 pool

# buckets
domain root {
	id -1		# do not change unnecessarily
	alg straw
	hash 0	# rjenkins1
	item device0 weight 1.000
	item device1 weight 1.000
	item device2 weight 1.000
}

# rules
rule data {
	ruleset 0
	type replicated
	min_size 1
	max_size 10
	step take root
	step choose firstn 0 type device
	step emit
}
rule metadata {
	ruleset 1
	type replicated
	min_size 1
	max_size 10
	step take root
	step choose firstn 0 type device
	step emit
}
rule casdata {
	ruleset 2
	type replicated
	min_size 1
	max_size 10
	step take root
	step choose firstn 0 type device
	step emit
}
rule rbd {
	ruleset 3
	type replicated
	min_size 1
	max_size 10
	step take root
	step choose firstn 0 type device
	step emit
}

# end crush map

--=-TMjNkvVIUfZpWZvE9Hdz--

