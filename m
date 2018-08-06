From: Ilya Dryomov <idryomov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: a little question about rbd_discard parameter len
Date: Mon, 6 Aug 2018 15:06:29 +0200
Message-ID: <CAOi1vP-6Z7ziNNnwEmkq5QdLLojv2ww9y9naX9Euvd1PJgtA7w@mail.gmail.com>
References: <CAGOEmcM3PC_jV7kEk83F3zEORmX1COM57ws8Q9sDcGkDXZfqLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAGOEmcM3PC_jV7kEk83F3zEORmX1COM57ws8Q9sDcGkDXZfqLQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: zhao6305-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, Ceph Development <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Mon, Aug 6, 2018 at 9:10 AM Will Zhao <zhao6305-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>
> Hi all: extern "C" int rbd_discard(rbd_image_t image, uint64_t ofs,
> uint64_t len)
> {
> librbd::ImageCtx *ictx = (librbd::ImageCtx *)image;
> tracepoint(librbd, discard_enter, ictx, ictx->name.c_str(),
> ictx->snap_name.c_str(), ictx->read_only, ofs, len);
> if (len > std::numeric_limits<int>::max()) {
> tracepoint(librbd, discard_exit, -EINVAL);
> return -EINVAL;
> }
> int r = ictx->io_work_queue->discard(ofs, len, ictx->skip_partial_discard);
> tracepoint(librbd, discard_exit, r);
> return r;
> }
> I tried to call rbd python api, rbd.Image.discard , and I found there
> is limit to the parameter len , it is a uint64, but is limited by
> std::numeric_limits<int>::max(), so that I can't discard too large
> space at a time. So I wonder what the considerations are about this?

rbd_discard() returns the number of bytes discarded or a negative error
code.  The return type is just an int though, so the range is capped at
INT_MAX to avoid overflow.

On top of that, current librbd doesn't rate limit on OSD requests in
all cases, so huge discards would need to be rejected anyway (although
the limit would probably be higher than ~2G).  Once that is fixed,
a new version of rbd_discard() with an updated signature could be
added.

Thanks,

                Ilya
