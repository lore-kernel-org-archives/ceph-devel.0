From: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: AIX and Solaris port of librados
Date: Wed, 27 Jan 2016 15:15:48 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1601271511220.6524@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

We've recently merged changes to librados to allow it to run on AIX and 
Solaris.  This work was generously funded by Bloomberg.

If you're interested in either of these platforms, please take a look.  
The AIX build process is a bit of a snowflake (unsurprisingly) but the 
resulting library passes the librados API functional tests.

On the solaris side it's possible to eventually support server-side 
functionality too, although that work is far from complete.

Interested parties should make themselves known.  In particular, it would 
be great to have some ongoing CI tests on these platforms so that they 
don't break.  We have space in the community lab to host such hardware, 
but no hands to manage the boxes, set up testing, and watch for failures.

Thanks!
sage
