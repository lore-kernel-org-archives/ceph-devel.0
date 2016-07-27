From: David Blundell <David.Blundell-7ie3GnOy+6yuWcBOZErdyg@public.gmane.org>
Subject: Re: Listing objects in a specified placement group /
	OSD
Date: Wed, 27 Jul 2016 17:51:34 +0000
Message-ID: <VI1PR0701MB254217851E17951D7FEBE34CA60F0@VI1PR0701MB2542.eurprd07.prod.outlook.com>
References: <VI1PR0701MB25427A0DF5F4308CC5D8C135A60F0@VI1PR0701MB2542.eurprd07.prod.outlook.com>
	<CAN=+7FU2BWDdJd+fRaBEcxOeacK6MqPk+NEpRMmJYqrhm4ckJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAN=+7FU2BWDdJd+fRaBEcxOeacK6MqPk+NEpRMmJYqrhm4ckJA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Samuel Just <sjust-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-Qp0mS5GaXlQ@public.gmane.org" <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Hi Sam,

We're running a program on each OSD host that reads the contents of the objects on that host's OSDs (using LIBRADOS_OPERATION_LOCALIZE_READS when reading as eventual consistency is ok).

At the moment the simplest way of finding out which objects are local is to look in the local filesystem but I want to ensure that the system will work with BlueStore and any future changes so would love to be able to query this e.g. via librados.

Cheers,

David  

> -----Original Message-----
> From: Samuel Just [mailto:sjust-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org]
> Sent: 27 July 2016 17:45
> To: David Blundell <David.Blundell-7ie3GnOy+6yuWcBOZErdyg@public.gmane.org>
> Cc: ceph-users-Qp0mS5GaXlQ@public.gmane.org; ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: Re: [ceph-users] Listing objects in a specified placement group / OSD
> 
> Well, it's kind of deliberately obfuscated because PGs aren't a
> librados-level abstraction.  Why do you want to list the objects in a
> PG?
> -Sam
