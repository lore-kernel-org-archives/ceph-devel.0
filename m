From: "Zhang, Jian" <jian.zhang@intel.com>
Subject: RE: question on BG# and its performance impact
Date: Mon, 23 Dec 2013 05:29:17 +0000
Message-ID: <51FC7A40FB29414D88A121A7FFEF9A4710D4BD8C@SHSMSX104.ccr.corp.intel.com>
References: <A9F57F2ABA6BB2469F01E127557C6C9B10E7BF1D@SHSMSX104.ccr.corp.intel.com>
 <52A7E371.7050008@inktank.com>
 <51FC7A40FB29414D88A121A7FFEF9A4710D43F45@SHSMSX104.ccr.corp.intel.com>
 <alpine.DEB.2.00.1312102134130.18451@cobra.newdream.net>
 <51FC7A40FB29414D88A121A7FFEF9A4710D43FFC@SHSMSX104.ccr.corp.intel.com>
 <alpine.DEB.2.00.1312102209570.19333@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:13903 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751244Ab3LWF3h convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Dec 2013 00:29:37 -0500
In-Reply-To: <alpine.DEB.2.00.1312102209570.19333@cobra.newdream.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Mark Nelson <mark.nelson@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Sage,
We here is some updates:
1. We tried the 'optimal' crush tunables, but the pg # distribution seems the same as without it. 
  Wondering do you have other suggestions since the pg # gap on different disks is up to 30%. 
2. The performance degradation issue is caused by splitting, the performance is quite good after bypass the splitting. 

Jian 

-----Original Message-----
From: Sage Weil [mailto:sage@inktank.com] 
Sent: Wednesday, December 11, 2013 2:10 PM
To: Zhang, Jian
Cc: Mark Nelson; Duan, Jiangang
Subject: RE: question on BG# and its performance impact

On Wed, 11 Dec 2013, Zhang, Jian wrote:
> Thanks for the suggestions, I will take a look on the ls output.
> No, we didn't use the optimal crush tunables. 

Hopefully that is part of it... try repeating the test with the optimal tunables (now the default in master)!

s


> 
> Jian
> 
> -----Original Message-----
> From: Sage Weil [mailto:sage@inktank.com]
> Sent: Wednesday, December 11, 2013 1:36 PM
> To: Zhang, Jian
> Cc: Mark Nelson; Duan, Jiangang
> Subject: RE: question on BG# and its performance impact
> 
> I might be worthwhile here to get teh actual list of objects (rados -p $pool ls list.txt) and calculate the pg and osd mappings for each of them to verify things are uniform.
> 
> One thing: are you using the 'optimal' crush tunables (ceph osd crush tunables optimal)?
> 
> Also, can we cc ceph-devel?
> 
> sage
> 
> 
> On Wed, 11 Dec 2013, Zhang, Jian wrote:
> 
> > Mark,
> > Thanks for the help. 
> > For the performance dip, I think it should casued by the directory splitting, just check several OSD, it does has many sub directories.
> > For the pg # and distribution, see if I understand you correctly:
> > When you said "a slow trend toward uniformity" do you mean the pg # for each pool is unforim? But from sheet2, the pg # on OSD10 is 103, while the pg # on OSD8 is 72, there is still a 30% gap. And I think that's the reason we saw performance drop of 10M read with 1280 pgs - pg # on the OSD is not balance. 
> > 
> > Thanks
> > Jian
> > 
> > -----Original Message-----
> > From: Mark Nelson [mailto:mark.nelson@inktank.com]
> > Sent: Wednesday, December 11, 2013 12:01 PM
> > To: Duan, Jiangang
> > Cc: Sage Weil (sage@inktank.com); Zhang, Jian
> > Subject: Re: question on BG# and its performance impact
> > 
> > Hi Jiangang,
> > 
> > My results are rather old at this point, but I did similar testing last spring to look at PG distribution and performance (with larger writes) with varying numbers of PGs.  I saw what looked like a slow trend toward uniformity.  Performance however was quite variable.
> > 
> > The performance dip you saw after many hours may have been due to directory splitting on the underlying OSDs.  When this happens depends on the number of objects that are written out and the number of PGs in the pool.  Eventually, when enough objects are written, the filestore will create a deeper nested directory structure to store objects to keep the maximum number of objects per directory below a certain maximum. 
> > This is governed by two settings:
> > 
> > filestore merge threshold = 10
> > 
> > filestore split multiple = 2
> > 
> > The total number of objects per directory is by default 10 * 2 * 16 = 320.  With small PG counts this can cause quite a bit of directory splitting if there are many objects.
> > 
> > I believe that it is likely these defaults are lower than necessary and we could allow more objects per directory, potentially reducing the number of seeks for dentry lookups (though theoretically this should be cached).  We definitely have seen this have a large performance impact with RGW though on clusters with small numbers of PGs.  With more PGs, and more relaxed thresholds, directory splitting doesn't happen until many many millions of objects are written out, and performance degradation as the disk fills up appears to be less severe.
> > 
> > Mark
> > 
> > On 12/10/2013 09:05 PM, Duan, Jiangang wrote:
> > > Sage/mark,
> > >
> > > We find object# unbalance condition in our Ceph setup for both RBD 
> > > and object. Refer to the attached pdf.
> > >
> > > Increase the PG# does increase performance however result in 
> > > unstable issues ?
> > >
> > > Is this a known issue and do you have any BKM to fix this?
> > >
> > > -jiangang
> > >
> > 
> > 
> 
> 
