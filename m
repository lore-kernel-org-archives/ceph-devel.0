From: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: crush tunable docs and straw_calc_version
Date: Mon, 7 Mar 2016 20:26:55 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1603072018520.25897@cpach.fuggernut.com>
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

I rewrote the CRUSH tunable docs after struggling to summarize to a 
customer what the impact would be to migrate a bunch of older clusters to 
the latest tunables:

	https://github.com/ceph/ceph/pull/7964

However, after trying to explain the hammer tunables vs the 
straw_calc_version tunable (which isn't properly part of a tunable 
profile.. mostly) I think we should change that.

To refreshe everyone's memory, right before hammer we discovered a bug in 
the straw bucket weight calculation that made it screw up with 0-weight or 
duplicate-weight items.  What was slightly wonky was that fixing the bug 
didn't change the mapping for current buckets *until* you modified one of 
the weights in the bucket.  So, clients didn't need a new feature bit, and 
you could 'fix' the bug but not incur the data movement until some future 
time when you happened to touch the bucket.

For this reason, we

 * didn't set straw_calc_version=1 when you changed the crush profile to 
hammer.

 * added a crush reweight-all command that would recalculate all teh 
internal weights, so that the admin could set the tunable and then 
force all the data movement to happen at a known time (now).

 * set it to 1 for newly created clusters.

The problem is that an old operator may think they are on hammer (and soon 
jewel) tunables and not realize they are still running with a non-optimal 
option.

Instead, I think we should:

 * make the hammer profile force it to be 1.

 * create a separate health warning if it is ever 0 (with the usual mon 
option to disable the warning).

It's still not perfect, but I think it's less likely to make users unhappy 
than what we currently have.  Objections/thoughts?

sage
