From: Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Subject: Re: 0.61 Cuttlefish / ceph-deploy missing
Date: Wed, 15 May 2013 08:48:22 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1305150846330.14301@cobra.newdream.net>
References: <alpine.DEB.2.00.1305061744430.9909@cobra.newdream.net>
	<20130515110842.GA28468@oder.mch.fsc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <20130515110842.GA28468-tbq9f/Eh0BZ9QGbx8OrcVQ@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Kasper Dieter <dieter.kasper-RJz4owOZxyXQFUHtdCDX3A@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-Qp0mS5GaXlQ@public.gmane.org" <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Wed, 15 May 2013, Kasper Dieter wrote:
> Hi Sage,
> I'm a little bit confused about 'ceph-deploy' in 0.61:
> 
> . the 0.61 release note says: "ceph-deploy: our new deployment tool to replace 'mkcephfs'"
> . http://ceph.com/docs/master/rados/deployment/mkcephfs/
> 	says "To deploy a test or development cluster, you can use the mkcephfs tool. 
> 	We do not recommend using this tool for production environments."

Adjustd this in the docs, thanks!

> . http://ceph.com/docs/master/rados/deployment/
> 	says "MKCEPHFS (DEPRECATED)
> 	(...) As of Ceph v0.60, it is deprecated in favor of ceph-deploy."
> 
> But, /usr/sbin/mkcephfs is provided by the ceph*0.61.2*rpm(s)
> whereas ceph-deploy is missing.

ceph-deploy is packaged separately as it is designed to deploy any version 
of Ceph (>= bobtail).  The ceph-deploy package should be in the same repos 
as the ceph packages; if they are missing, let us know.  We are still 
streamlining the build process for that package so that updates and fixes 
(for the deployment tool) get published more quickly.

> The only way to get ceph-deploy seems to be using git:
> git clone https://github.com/ceph/ceph-deploy.git

This also works.

Thanks!
sage


> 
> 
> Is this the way it should be ?
> When will ceph-deploy be included in the Cuttlefish rpms ?
> 
> 
> Best Regards,
> -Dieter
> 
> 
> On Tue, May 07, 2013 at 04:51:25AM +0200, Sage Weil wrote:
> > Spring has arrived (at least for some of us), and a new stable release of 
> > Ceph is ready!  Thank you to everyone who has contributed to this release!
> > 
> > Bigger ticket items since v0.56.x "Bobtail":
> > 
> >  * ceph-deploy: our new deployment tool to replace 'mkcephfs'
> (...)
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
