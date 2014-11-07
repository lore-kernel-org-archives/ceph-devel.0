From: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Subject: Re: PG inconsistency
Date: Fri, 7 Nov 2014 02:19:06 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1411070213510.15135@cobra.newdream.net>
References: <BLU175-W41E1F32E90ED411A4477FFDF840@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <BLU175-W41E1F32E90ED411A4477FFDF840-MsuGFMq8XAE@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: GuangYang <yguang11-1ViLX0X+lBJBDgjK7y7TUQ@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Thu, 6 Nov 2014, GuangYang wrote:
> Hello Cephers,
> Recently we observed a couple of inconsistencies in our Ceph cluster, 
> there were two major patterns leading to inconsistency as I observed: 1) 
> EIO to read the file, 2) the digest is inconsistent (for EC) even there 
> is no read error).
> 
> While ceph has built-in tool sets to repair the inconsistencies, I also 
> would like to check with the community in terms of what is the best ways 
> to handle such issues (e.g. should we run fsck / xfs_repair when such 
> issue happens).
> 
> In more details, I have the following questions:
> 1. When there is inconsistency detected, what is the chance there is 
> some hardware issues which need to be repaired physically, or should I 
> run some disk/filesystem tools to further check?

I'm not really an operator so I'm not as familiar with these tools as I 
should be :(, but I suspect the prodent route is to check the SMART info 
on the disk, and/or trigger a scrub of everything else on the OSD (ceph 
osd scrub N).  For DreamObjects, I think they usually just fail the OSD 
once it starts throwing bad sectors (most of the hardware is already 
reasonably aged).

> 2. Should we use fsck / xfs_repair to fix the inconsistencies, or should 
> we solely relay on Ceph's repair tool sets?

That might not be a bad idea, but I would urge caution if xfs_repair finds 
any issues or makes any changes, as subtle changes to the fs contents can 
confuse ceph-osd.  At an absolute minimum, do a full scrub after, but 
even better would be to fail the OSD.

(FWIW I think we should document a recommended "safe" process for 
failing/replacing an OSD that takes the suspect data offline but waits for 
the cluster to heal before destroying any data.  Simply marking the OSD 
out will work, but then when a fresh drive is added there will be a second 
repair/rebalance event, which isn't ideal.)

sage

> 
> It would be great to hear you experience and suggestions.
> 
> BTW, we are using XFS in the cluster.
> 
> Thanks,
> Guang 		 	   		  N????y????b?????v?????{.n??????z??ay????????j???f????????????????:+v??????????zZ+??????"?!?
