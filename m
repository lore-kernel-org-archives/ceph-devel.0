From: "Chen, Xiaoxi" <xiaoxi.chen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: Any concern about Ceph on CentOS
Date: Wed, 17 Jul 2013 06:27:52 +0000
Message-ID: <6F3FA899187F0043BA1827A69DA2F7CC01E44584@SHSMSX102.ccr.corp.intel.com>
References: <6F3FA899187F0043BA1827A69DA2F7CC01E43F83@SHSMSX102.ccr.corp.intel.com>
	<20130717061655.GB13122@oder.mch.fsc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <20130717061655.GB13122-tbq9f/Eh0BZ9QGbx8OrcVQ@public.gmane.org>
Content-Language: en-US
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

Hi Dieter,
    Thanks a lot for the information. Could I learn more about your use case ? Would you care performance ?
    And may I know why you want CentOS+ Custom kernel ? I thought people use CentOS for stability concern but if using CentOS + Custom Kernel, why don't you just use Ubuntu or Fedora(although Fedora is usually too aggressive).
                                                                      Xiaoxi

-----Original Message-----
From: ceph-devel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:ceph-devel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Kasper Dieter
Sent: Wednesday, July 17, 2013 2:17 PM
To: Chen, Xiaoxi
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; ceph-users-Qp0mS5GaXlQ@public.gmane.org
Subject: Re: Any concern about Ceph on CentOS

Hi Xiaoxi,

we are really running Ceph on CentOS-6.4
(6 server nodes, 3 client nodes, 160 OSDs).

We put a 3.8.13 Kernel on top and installed the ceph-0.61.4 cluster with mkcephfs, because ceph-deploy seems to be still very buggy and has big dependencies to the newest python.

ceph.ko
rbd.ko
and ceph-fuse are running fast, well and stable (so far ;-) ).

Cheers,
-Dieter

On Wed, Jul 17, 2013 at 03:18:22AM +0200, Chen, Xiaoxi wrote:
> Hi list,
>    I would like to ask if anyone really run Ceph on CentOS/RHEL? 
>    Since the kernel version for Cent/RHEL is much older than that of Ubuntu, 
>    I am thinking about whether we have some known performance/functionality issue?
>    Thanks for everyone could share your insight for Ceph+CentOS.
> 																												Xiaoxi
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" 
> in the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org More majordomo 
> info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
