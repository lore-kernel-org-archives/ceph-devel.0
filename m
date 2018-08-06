From: Will Zhao <zhao6305-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: a little question about rbd_discard parameter len
Date: Mon, 6 Aug 2018 15:10:36 +0800
Message-ID: <CAGOEmcM3PC_jV7kEk83F3zEORmX1COM57ws8Q9sDcGkDXZfqLQ@mail.gmail.com>
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
To: Ceph Users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

Hi all: extern "C" int rbd_discard(rbd_image_t image, uint64_t ofs,
uint64_t len)
{
librbd::ImageCtx *ictx = (librbd::ImageCtx *)image;
tracepoint(librbd, discard_enter, ictx, ictx->name.c_str(),
ictx->snap_name.c_str(), ictx->read_only, ofs, len);
if (len > std::numeric_limits<int>::max()) {
tracepoint(librbd, discard_exit, -EINVAL);
return -EINVAL;
}
int r = ictx->io_work_queue->discard(ofs, len, ictx->skip_partial_discard);
tracepoint(librbd, discard_exit, r);
return r;
}
I tried to call rbd python api, rbd.Image.discard , and I found there
is limit to the parameter len , it is a uint64, but is limited by
std::numeric_limits<int>::max(), so that I can't discard too large
space at a time. So I wonder what the considerations are about this?
