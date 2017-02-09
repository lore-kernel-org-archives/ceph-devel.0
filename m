From: Wido den Hollander <wido-fspyXLx8qC4@public.gmane.org>
Subject: Re: would people mind a slow osd restart during
 luminous upgrade?
Date: Thu, 9 Feb 2017 06:57:27 +0100 (CET)
Message-ID: <66796779.9484.1486619847762@ox.pcextreme.nl>
References: <alpine.DEB.2.11.1702090302470.7782@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.11.1702090302470.7782-qHenpvqtifaMSRpgCs4c+g@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: ceph-users-Qp0mS5GaXlQ@public.gmane.org, Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org


> Op 9 februari 2017 om 4:09 schreef Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>:
> 
> 
> Hello, ceph operators...
> 
> Several times in the past we've had to do some ondisk format conversion 
> during upgrade which mean that the first time the ceph-osd daemon started 
> after upgrade it had to spend a few minutes fixing up it's ondisk files.  
> We haven't had to recently, though, and generally try to avoid such 
> things.
> 
> However, there's a change we'd like to make in FileStore for luminous (*) 
> and it would save us a lot of time and complexity if it was a one-shot 
> update during the upgrade.  I would probably take in the neighborhood of 
> 1-5 minutes for a 4-6TB HDD.  That means that when restarting the daemon 
> during the upgrade the OSD would stay down for that period (vs the usual 
> <1 restart time).
> 
> Does this concern anyone?  It probably means the upgrades will take longer 
> if you're going host by host since the time per host will go up.
> 

Not really. When going to Jewel data had to be chowned to ceph:ceph as well. As long as we make sure it's in the Release Notes very clearly we should be OK.

Wido

> sage
> 
> 
> * eliminate 'snapdir' objects, replacing them with a head object + 
> whiteout.
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
