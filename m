From: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Subject: Re: scubbing for a long time and not finished
Date: Thu, 19 Mar 2015 06:33:30 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1503190629530.7043@cobra.newdream.net>
References: <CANE=7sWwheXa3WZb_+b3G57MBuhcdMssJJqVjR9y9yRHu6vFEQ@mail.gmail.com>
	<da34275f64ad3e2960322516f488fd@ip-10-0-3-214>
	<CANE=7sWbh9aJHp603BuFZivtLJ5a-axDq7CyHCfwaDWMRw7wAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CANE=7sWbh9aJHp603BuFZivtLJ5a-axDq7CyHCfwaDWMRw7wAg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Xinze Chi <xmdxcxz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Thu, 19 Mar 2015, Xinze Chi wrote:
> Currently, users do not know  when some pg do scrubbing for a long time.
> I think whether we could give some warming if it happend (defined as
> osd_scrub_max_time).
> It would tell the user something may be wrong in cluster.

This should be pretty straightforward to add along with the other "stuck 
x" warnings based on the pg_stat_t state timestamps.  On the otherhead, 
that may be a somewhat heavyweight approach (each new warning bloats the 
stat structure a bit); open to other ideas!

sage
