From: Wido den Hollander <wido-fspyXLx8qC4@public.gmane.org>
Subject: Re: who is using nfs-ganesha and cephfs?
Date: Thu, 9 Nov 2017 08:10:36 +0100 (CET)
Message-ID: <1266641622.4498.1510211437247@ox.pcextreme.nl>
References: <alpine.DEB.2.11.1711082140180.29217@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.11.1711082140180.29217-qHenpvqtifaMSRpgCs4c+g@public.gmane.org>
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


> Op 8 november 2017 om 22:41 schreef Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>:
> 
> 
> Who is running nfs-ganesha's FSAL to export CephFS?  What has your 
> experience been?
> 

A customer of mine is going this. They are running Ubuntu and my experience is that getting Ganesha compiled is already a pain sometimes.

When it runs it runs just fine. I don't hear a lot of complaints from their side with Ganesha or NFS not working.

Wido

> (We are working on building proper testing and support for this into 
> Mimic, but the ganesha FSAL has been around for years.)
> 
> Thanks!
> sage
> 
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
