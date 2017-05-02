From: Wido den Hollander <wido-fspyXLx8qC4@public.gmane.org>
Subject: Re: osd and/or filestore tuning for ssds?
Date: Tue, 2 May 2017 05:00:41 +0200 (CEST)
Message-ID: <1457289083.3296.1493694041615@ox.pcextreme.nl>
References: <alpine.DEB.2.11.1704281712110.21526@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.11.1704281712110.21526-qHenpvqtifaMSRpgCs4c+g@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org


> Op 28 april 2017 om 19:14 schreef Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>:
> 
> 
> Hi everyone,
> 
> Are there any osd or filestore options that operators are tuning for 
> all-SSD clusters?  If so (and they make sense) we'd like to introduce them 
> as defaults for ssd-backed OSDs.
> 

osd_op_threads and osd_disk_threads. They can be increased to 2x or 4x to get performance improvments on SSDs.

> BlueStore already has different hdd and ssd default values for many 
> options that it chooses based on the type of device; we'd like to do that 
> for other options in either filestore or the OSD if it makes sense.
> 
> Thanks!
> sage
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
