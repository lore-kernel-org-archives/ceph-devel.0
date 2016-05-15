From: Blair Bethwaite <blair.bethwaite-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: reweight-by-utilization warning
Date: Mon, 16 May 2016 00:09:01 +1000
Message-ID: <CA+z5DsxSQCVTC6deY91BuDPoGZc9rqzt6SG2vovy+vk3R1A9eA@mail.gmail.com>
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
To: Ceph Development <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Hi all,

IMHO reweight-by-utilization should come with some sort of warning, it
just suddenly reweights everything - no dry run, no confirmation,
apparently no option to see what it's going to do. It also doesn't
appear to consider pools and hence crush rulesets, which I imagine
could result in it making some poor reweighting decisions.

We ran it on a cluster this evening and promptly had over 70% of
objects misplaced - even at 5-7 GB/s that's quite a lot of data
movement when there are half a billion objects in the cluster! I think
we'll stick with Dan's scripts
(https://github.com/cernceph/ceph-scripts/blob/master/tools/crush-reweight-by-utilization.py)
for the moment (thanks Dan!).

-- 
Cheers,
~Blairo
