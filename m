From: Gregory Farnum <gfarnum-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Initial performance cluster SimpleMessenger vs
	AsyncMessenger results
Date: Mon, 12 Oct 2015 21:12:59 -0700
Message-ID: <CAJ4mKGYOOgL7WPzFtkO6r12B7kL+mTekC-OUayckA2bdV7P1qg@mail.gmail.com>
References: <561BE4E3.7050404@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <561BE4E3.7050404-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Mark Nelson <mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Mon, Oct 12, 2015 at 9:50 AM, Mark Nelson <mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> Hi Guy,
>
> Given all of the recent data on how different memory allocator
> configurations improve SimpleMessenger performance (and the effect of memory
> allocators and transparent hugepages on RSS memory usage), I thought I'd run
> some tests looking how AsyncMessenger does in comparison.  We spoke about
> these a bit at the last performance meeting but here's the full write up.
> The rough conclusion as of right now appears to be:
>
> 1) AsyncMessenger performance is not dependent on the memory allocator like
> with SimpleMessenger.
>
> 2) AsyncMessenger is faster than SimpleMessenger with TCMalloc + 32MB (ie
> default) thread cache.
>
> 3) AsyncMessenger is consistently faster than SimpleMessenger for 128K
> random reads.
>
> 4) AsyncMessenger is sometimes slower than SimpleMessenger when memory
> allocator optimizations are used.
>
> 5) AsyncMessenger currently uses far more RSS memory than SimpleMessenger.
>
> Here's a link to the paper:
>
> https://drive.google.com/file/d/0B2gTBZrkrnpZS1Q4VktjZkhrNHc/view

Can you clarify these tests a bit more? I can't make the number of
nodes, OSDs, and SSDs work out properly. Were the FIO jobs 256
concurrent ops per job, or in aggregate? Is there any more info that
might suggest why the 128KB rand-read (but not read nor write, and not
4k rand-read) was so asymmetrical?
