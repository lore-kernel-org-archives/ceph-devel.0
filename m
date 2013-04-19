From: Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>
Subject: Re: Xen blktap driver for Ceph RBD : Anybody wants to
 test ? :p
Date: Fri, 19 Apr 2013 09:45:24 +0300
Message-ID: <20130419064524.GQ11427@reaktio.net>
References: <CAF6-1L714v7xtXe_Bg396jm+7Fi5ivUoxX79dpZ4dmT8MFj-aA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xen.org>
Content-Disposition: inline
In-Reply-To: <CAF6-1L714v7xtXe_Bg396jm+7Fi5ivUoxX79dpZ4dmT8MFj-aA@mail.gmail.com>
List-Unsubscribe: <http://lists.xen.org/cgi-bin/mailman/options/xen-devel>,
	<mailto:xen-devel-request@lists.xen.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xen.org>
List-Help: <mailto:xen-devel-request@lists.xen.org?subject=help>
List-Subscribe: <http://lists.xen.org/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xen.org?subject=subscribe>
Sender: xen-devel-bounces@lists.xen.org
Errors-To: xen-devel-bounces@lists.xen.org
To: Sylvain Munaut <s.munaut@whatever-company.com>
Cc: ceph-devel@vger.kernel.org, xen-devel@lists.xen.org
List-Id: ceph-devel.vger.kernel.org

On Thu, Apr 18, 2013 at 05:05:29PM +0200, Sylvain Munaut wrote:
> Hi,
>

Hi,
 
> I've been working on getting a working blktap driver allowing to
> access ceph RBD block devices without relying on the RBD kernel driver
> and it finally got to a point where, it works and is testable.
> 

Great! Ceph distributed block storage is cool.

> Some of the advantages are:
>  - Easier to update to newer RBD version
>  - Allows functionality only available in the userspace RBD library
> (write cache, layering, ...)
>  - Less issue when you have OSD as domU on the same dom0
>  - Contains crash to user space :p (they shouldn't happen, but ...)
> 
> It's still an early prototype, but if you want to give it a shot and
> give feedback.
> 
> You can find the code there https://github.com/smunaut/blktap/tree/rbd
>  (rbd branch).
> 
> Currently the username, poolname and image name are hardcoded ...
> (look for FIXME in the code). I'll get to that next, once I figured
> the best format for arguments.
> 

If you have time to write up some lines about steps required to test this,
that'd be nice, it'll help people to test this stuff.

Thanks,

-- Pasi
