From: Sage Weil <sweil@redhat.com>
Subject: Re: [ceph-users] OSD memory usage
Date: Fri, 22 Sep 2017 15:20:24 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1709221520170.16664@piezo.novalocal>
References: <628a2d8b-43ca-d58b-1427-b68d613526b1@ucalgary.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50656 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752218AbdIVPU1 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 22 Sep 2017 11:20:27 -0400
In-Reply-To: <628a2d8b-43ca-d58b-1427-b68d613526b1@ucalgary.ca>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: bulk.schulz@ucalgary.ca
Cc: ceph-users@lists.ceph.com, ceph-devel@vger.kernel.org

Just a follow-up here:

I'm chasing down a bug with memory accounting.  On my luminous cluster I
am seeing lots of memory usage that is triggered by scrub.  Pretty sure
this is a bluestore cache mempool issue (making it use more memory than it
thinks it is); hopefully I'll have a fix shortly.

Recovery could trigger the same thing, but this might be something
different...

Either way, if you are seeing this usage, please capture a mempool dump:

 ceph daemon osd.NNN dump_mempools

along with the RSS size for the daemon for reference.  This info will help
me sort out whether it's the same problem or not.

Thanks!
sage


On Mon, 11 Sep 2017, bulk.schulz@ucalgary.ca wrote:

> Hi Everyone,
> 
> I wonder if someone out there has a similar problem to this?
> 
> I keep having issues with memory usage.  I have 2 OSD servers wiith 48G memory
> and 12 2TB OSDs.  I seem to have significantly more memory than the minimum
> spec, but these two machines with 2TB drives seem to OOM kill and crash
> periodically -- basically any time the cluster goes into recovery for even 1
> OSD this happens.
> 
> 12 Drives * 2TB = 24 TB.  By using the 1GB RAM per 1TB Disk rule: I should
> need only 24TB or so.
> 
> I am testing and benchmarking at this time so most changes are fine.  I am
> abusing this filesystem considerably by running 14 clients with something that
> is more or less dd each to a different file but that's the point :)
> 
> When it's working, the performance is really good.  3GB/s with 3x replicated
> data pool up to around 10GB/s with 1X replication (just for kicks and giggles)
> My bottleneck is likely the SAS channels to those disks.
> 
> I'm using the 12.2.0 release running on Centos 7
> 
> Testing cephfs with one MDS and 3 montors.  The MON/MDS are not on the servers
> in question.
> 
> Total of around 350 OSDs (all spinning disk) most of which are 1TB drives on
> 15 servers that are a bit older with Xeon E5620's.
> 
> Dual QDR Infiniband (20GBit) fabrics (1 cluster and 1 client).
> 
> Any thoughts?  Am I missing some tuning parameter in /proc or something?
> 
> Thanks
> -Dave
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> 
> 
