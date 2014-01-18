From: Mark Kirkwood <mark.kirkwood-6STWZtX7tXAqAMOr+u8IRA@public.gmane.org>
Subject: Re: v0.75 released
Date: Sat, 18 Jan 2014 19:58:16 +1300
Message-ID: <52DA2608.8080202@catalyst.net.nz>
References: <alpine.DEB.2.00.1401141941070.8325@cobra.newdream.net>
	<ord2jpvl4e.fsf@livre.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <ord2jpvl4e.fsf-o1YuAO9g/txBDLzU/O5InQ@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Alexandre Oliva <oliva-mXXj517/zsQ@public.gmane.org>, Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

On 18/01/14 19:50, Alexandre Oliva wrote:
> On Jan 15, 2014, Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org> wrote:
>
>>   v0.75 291 files changed, 82713 insertions(+), 33495 deletions(-)
>
>> Upgrading
>> ~~~~~~~~~
>
> I suggest adding:
>
>    * All (replicated?) pools will likely fail scrubbing because the
>      per-pool dirty object counts, introduced in 0.75, won't match.  This
>      inconsistency is cleared by a pg repair; unfortunately this is about
>      as expensive as a a deep-scrub, and it's not automatically scheduled
>      or retried, like scrubs and deep-scrubs.
>
> I suppose after the dirty counts are brought to sync, the next scrub
> won't find inconsistent counts again, but I haven't got to that point
> yet.
>
> What surprised me was the huge number of objects marked as dirty!  It
> was at least 14k out of 70k objects in each data pool, and even more in
> metadata pools, but it's not like I have messed with this many objects
> recently.  Could something be amiss there?
>

And stat mis-matches too I think are going to require folk to run repairs.

Regards

Mark
