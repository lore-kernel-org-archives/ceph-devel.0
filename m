From: Gregory Farnum <greg-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Subject: Re: How many Pipe per Ceph OSD daemon will keep?
Date: Thu, 6 Jun 2013 15:45:47 -0700
Message-ID: <CAPYLRzhcXGFvz+4mK45f738xbSSjhxi4veUZZ9vURtLWW=8mag@mail.gmail.com>
References: <6F3FA899187F0043BA1827A69DA2F7CC01E172F6@SHSMSX102.ccr.corp.intel.com>
	<CAPYLRzjLtvcp3ZDmtT4YRH7itYz1o_1P92uUKMeGj1mETscEJw@mail.gmail.com>
	<4D5925EB-1AE8-4641-8369-0ED8881476F1@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <4D5925EB-1AE8-4641-8369-0ED8881476F1-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: "Chen, Xiaoxi" <xiaoxi.chen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Thu, Jun 6, 2013 at 3:37 PM, Chen, Xiaoxi <xiaoxi.chen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> But in ceph_user,Mark, and some users are really discussing some supermicro chassis that can have 24 spindles per 2u or 36/48 spindles per 4U
>
> even with 20 osds per node,the thread num will more than 5000,and if take internal heartbeat/replication pipe into account, it should be around 10K threads. This is still too high for 8 core or 16 core cpu/cpus and will waste a lot of cycles in context switchinh.

If it makes you feel better, these messenger threads spend most of
their time sleeping on poll() or a condition variable. They will
certainly turn out to be a problem at some point and we're prepared to
handle that, but like I said, it's just not an issue anybody's hit yet
and we have a lot of other feature work to be getting on with. If
somebody would like to contribute code the Pipe stuff, while
complicated, is at least relatively isolated, and we'd be more than
happy to go over it!
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
