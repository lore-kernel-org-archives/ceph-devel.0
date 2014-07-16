From: James Harper <james-u7/cK5yN3tp/jDykUgYHh4dd74u8MsAO@public.gmane.org>
Subject: Re: v0.80.4 Firefly released
Date: Wed, 16 Jul 2014 08:50:34 +0000
Message-ID: <e7039ceecb224324acb2466f87efff8b@SIXPR04MB304.apcprd04.prod.outlook.com>
References: <alpine.DEB.2.00.1407151634250.21336@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.1407151634250.21336-vIokxiIdD2AQNTJnQDzGJqxOck334EZe@public.gmane.org>
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
To: Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-Qp0mS5GaXlQ@public.gmane.org" <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Can you offer some comments on what the impact is likely to be to the data in an affected cluster? Should all data now be treated with suspicion and restored back to before the firefly upgrade?

James

> -----Original Message-----
> From: ceph-users [mailto:ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org] On Behalf Of
> Sage Weil
> Sent: Wednesday, 16 July 2014 9:46 AM
> To: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; ceph-users-Qp0mS5GaXlQ@public.gmane.org
> Subject: [ceph-users] v0.80.4 Firefly released
> 
> This Firefly point release fixes an potential data corruption problem
> when ceph-osd daemons run on top of XFS and service Firefly librbd
> clients.  A recently added allocation hint that RBD utilizes triggers
> an XFS bug on some kernels (Linux 3.2, and likely others) that leads
> to data corruption and deep-scrub errors (and inconsistent PGs).  This
> release avoids the situation by disabling the allocation hint until we
> can validate which kernels are affected and/or are known to be safe to
> use the hint on.
> 
> We recommend that all v0.80.x Firefly users urgently upgrade,
> especially if they are using RBD.
> 
> Notable Changes
> ---------------
> 
> * osd: disable XFS extsize hint by default (#8830, Samuel Just)
> * rgw: fix extra data pool default name (Yehuda Sadeh)
> 
> For more detailed information, see:
> 
>   http://ceph.com/docs/master/_downloads/v0.80.4.txt
> 
> Getting Ceph
> ------------
> 
> * Git at git://github.com/ceph/ceph.git
> * Tarball at http://ceph.com/download/ceph-0.80.4.tar.gz
> * For packages, see http://ceph.com/docs/master/install/get-packages
> * For ceph-deploy, see http://ceph.com/docs/master/install/install-ceph-
> deploy
> 
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
