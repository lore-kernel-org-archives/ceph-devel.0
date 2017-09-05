From: Gregory Farnum <gfarnum-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: a question about use of CEPH_IOC_SYNCIO in write
Date: Tue, 5 Sep 2017 13:29:02 -0700
Message-ID: <CAJ4mKGadR69K7xunZ32XvTfRzyJGXJcOPJuHpSZ76-xtey6eeg@mail.gmail.com>
References: <22be9a24.45942.15e3dd4a1bf.Coremail.sa514164@mail.ustc.edu.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <22be9a24.45942.15e3dd4a1bf.Coremail.sa514164-fOMaevN1BEbsJZF79Ady7g@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: sa514164-fOMaevN1BEbsJZF79Ady7g@public.gmane.org
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Fri, Sep 1, 2017 at 7:24 AM,  <sa514164-fOMaevN1BEbsJZF79Ady7g@public.gmane.org> wrote:
> Hi:
>         I want to ask a question about CEPH_IOC_SYNCIO flag.
>         I know that when using O_SYNC flag or O_DIRECT flag, write call executes in other two code paths different than using CEPH_IOC_SYNCIO flag.
>         And I find the comments about CEPH_IOC_SYNCIO here:
>
>         /*
>          * CEPH_IOC_SYNCIO - force synchronous IO
>          *
>          * This ioctl sets a file flag that forces the synchronous IO that
>          * bypasses the page cache, even if it is not necessary.  This is
>          * essentially the opposite behavior of IOC_LAZYIO.  This forces the
>          * same read/write path as a file opened by multiple clients when one
>          * or more of those clients is opened for write.
>          *
>          * Note that this type of sync IO takes a different path than a file
>          * opened with O_SYNC/D_SYNC (writes hit the page cache and are
>          * immediately flushed on page boundaries).  It is very similar to
>          * O_DIRECT (writes bypass the page cache) except that O_DIRECT writes
>          * are not copied (user page must remain stable) and O_DIRECT writes
>          * have alignment restrictions (on the buffer and file offset).
>          */
>         #define CEPH_IOC_SYNCIO _IO(CEPH_IOCTL_MAGIC, 5)
>
>         My question is:
>         1."This forces the same read/write path as a file opened by multiple clients when one or more of those clients is opened for write." -- Does this mean multiple clients can execute in the same code path when they all use the CEPH_IOC_SYNCIO flag? Will the use of CEPH_IOC_SYNCIO in all clients bring effects such as coherency and performance?

If you're just using the normal interfaces, you don't need to play
around with this. I *think* this ioctl is only so that if you are
using lazyio (which disables the usual cache coherence), you can still
get get data IO which is coordinated with other clients.

>         2."...except that O_DIRECT writes are not copied (user page must remain stable)" -- As I know when threads write with CEPH_IOC_SYNCIO flag, the write call will block until ceph osd and mds send back responses. So even with CEPH_IOC_SYNCIO flag(the user pages are not locked here, I guess), but the user cannot use these pages. How can the use of CEPH_IOC_SYNCIO flag make better use of user space memory?

I'm not very familiar with these mechanisms, but I think it's saying
that if you use CEPH_IOC_SYNCIO in an async IO interface, once the
async write returns then it will have done an internal copy and can
use the pages again?
Not really sure...
-Greg
