From: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Subject: Re: ghost degraded objects
Date: Fri, 19 Jan 2018 13:14:12 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1801191309430.24931@piezo.novalocal>
References: <CAE63xUN4+fzJFjEOwKU-gXjqk+=8=gugU97V2xA4fx9oBrwvUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAE63xUN4+fzJFjEOwKU-gXjqk+=8=gugU97V2xA4fx9oBrwvUQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Ugis <ugis22-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

On Fri, 19 Jan 2018, Ugis wrote:
> Running Luminous 12.2.2, noticed strange behavior lately.
> When for example setting "ceph osd out X" closer to the reballancing
> end "degraded" objects still show up, but in "pgs:" section of ceph -s
> no degraded pgs are still recovering, just ramapped and no degraded
> pgs can be found in "ceph pg dump"
> 
>   health: HEALTH_WARN
>             355767/30286841 objects misplaced (1.175%)
>             Degraded data redundancy: 28/30286841 objects degraded
> (0.000%), 96 pgs unclean
> 
>   services:
>     ...
>     osd: 38 osds: 38 up, 37 in; 96 remapped pgs
> 
>   data:
>     pools:   19 pools, 4176 pgs
>     objects: 9859k objects, 39358 GB
>     usage:   114 TB used, 120 TB / 234 TB avail
>     pgs:     28/30286841 objects degraded (0.000%)
>              355767/30286841 objects misplaced (1.175%)
>              4080 active+clean
>              81   active+remapped+backfilling
>              15   active+remapped+backfill_wait
> 
> 
> Where those 28 degraded objects come from?

There aren't actually degraded objects.. in this case it's just 
misreporting that there are.

This is a known issue in luminous.  Shortly after release we noticed the 
problem and David has been working on several changes to the stats 
calculation to improve the reporting, but those changes have not been 
backported (and aren't quite complete, either--getting a truly accurate 
number there is nontrivial in some cases it turns out).

> In such cases usually when backfilling is done degraded objects also
> disappear, but normally degraded objects should fix before remapped
> ones by priority.

Yes.

It's unfortunately a scary warning (there shouldn't be degraded 
objects... and generally speaking aren't) that understandably alarms 
users.  We hope to have this sorted out soon!

sage
