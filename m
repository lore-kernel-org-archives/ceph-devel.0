From: Miklos Szeredi <miklos-sUDqSbJrdHQHWmgEVkV9KA@public.gmane.org>
Subject: Re: [PATCH v3 0/2] iov_iter: allow iov_iter_get_pages_alloc to
 allocate more pages per call
Date: Sat, 4 Feb 2017 23:11:27 +0100
Message-ID: <CAJfpegtVb8PKNnKe5wGMd0u0WzgLpjpVtVpqDScbrBJShLAfGw@mail.gmail.com>
References: <20170124212327.14517-1-jlayton@redhat.com> <20170125133205.21704-1-jlayton@redhat.com>
 <20170202095125.GF27291@ZenIV.linux.org.uk> <20170204030842.GL27291@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170204030842.GL27291-3bDd1+5oDREiFSDQTTA3OLVCufUGDwFn@public.gmane.org>
Sender: linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Al Viro <viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org>
Cc: linux-fsdevel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux NFS list <linux-nfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lustre-devel-aLEFhgZF4x6X6Mz3xDxJMA@public.gmane.org, v9fs-developer-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Jan Kara <jack-AlSwsSmVLrQ@public.gmane.org>, Chris Wilson <chris-Y6uKTt2uX1cEflXRtASbqLVCufUGDwFn@public.gmane.org>, "Kirill A. Shutemov" <kirill.shutemov-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jeff Layton <jlayton-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Sat, Feb 4, 2017 at 4:08 AM, Al Viro <viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org> wrote:
> On Thu, Feb 02, 2017 at 09:51:25AM +0000, Al Viro wrote:
>
>>       * fuse_copy_fill().  I'm not at all sure that iov_iter_get_pages()
>> is a good idea there - fuse_copy_do() could bloody well just use
>> copy_{to,from}_iter().
>
> Miklos, could you explain why does lock_request() prohibit page faults until
> the matching unlock_request()?  All it does is setting FR_LOCKED on
> our request and the only thing that even looks at that is fuse_abort_conn(),
> which doesn't (AFAICS) wait for anything.
>
> Where does the deadlock come from, and if it's not a deadlock - what is
> it?  Or is that comment stale since "fuse: simplify request abort"?

Well, it's not historical; at least not yet.  The deadlock is there
alright: mmap fuse file to addr; read byte from mapped page -> page
locked; this triggeres read request served in same process but
separate thread; write addr-headerlen to fuse dev; trying to lock same
page -> deadlock.

The deadlock can be broken by aborting or force unmounting: return
error for original read request; page unlocked; device write can get
page lock and return.

The reason we need to prohibit pagefault while copying is that when
request is aborted and the caller returns the memory in the request
may become invalid (e.g. data from stack).

Another solution would be to copy all data and keep a ref on the copy
by the request even after being aborted.  This is the plan for the
future.

Thanks,
Miklos
--
To unsubscribe from this list: send the line "unsubscribe linux-nfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
