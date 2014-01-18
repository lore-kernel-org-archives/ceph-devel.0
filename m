From: Alexandre Oliva <oliva-mXXj517/zsQ@public.gmane.org>
Subject: Re: v0.75 released
Date: Sat, 18 Jan 2014 04:50:57 -0200
Message-ID: <ord2jpvl4e.fsf@livre.home>
References: <alpine.DEB.2.00.1401141941070.8325@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.1401141941070.8325-vIokxiIdD2AQNTJnQDzGJqxOck334EZe@public.gmane.org> (Sage
	Weil's message of "Tue, 14 Jan 2014 19:42:31 -0800 (PST)")
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

On Jan 15, 2014, Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org> wrote:

>  v0.75 291 files changed, 82713 insertions(+), 33495 deletions(-)

> Upgrading
> ~~~~~~~~~

I suggest adding:

  * All (replicated?) pools will likely fail scrubbing because the
    per-pool dirty object counts, introduced in 0.75, won't match.  This
    inconsistency is cleared by a pg repair; unfortunately this is about
    as expensive as a a deep-scrub, and it's not automatically scheduled
    or retried, like scrubs and deep-scrubs.

I suppose after the dirty counts are brought to sync, the next scrub
won't find inconsistent counts again, but I haven't got to that point
yet.

What surprised me was the huge number of objects marked as dirty!  It
was at least 14k out of 70k objects in each data pool, and even more in
metadata pools, but it's not like I have messed with this many objects
recently.  Could something be amiss there?

-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist     Red Hat Brazil Toolchain Engineer
