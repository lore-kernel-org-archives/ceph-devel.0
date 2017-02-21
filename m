From: Jeff Cody <jcody@redhat.com>
Subject: Re: [RFC v6] RBD: Add support readv,writev for rbd
Date: Mon, 20 Feb 2017 23:50:21 -0500
Message-ID: <20170221045021.GN19045@localhost.localdomain>
References: <20170221034336.10097-1-jazeltq@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <qemu-block-bounces+gceqb-qemu-block=m.gmane.org@nongnu.org>
Content-Disposition: inline
In-Reply-To: <20170221034336.10097-1-jazeltq@gmail.com>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-block>,
	<mailto:qemu-block-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-block/>
List-Post: <mailto:qemu-block@nongnu.org>
List-Help: <mailto:qemu-block-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-block>,
	<mailto:qemu-block-request@nongnu.org?subject=subscribe>
Errors-To: qemu-block-bounces+gceqb-qemu-block=m.gmane.org@nongnu.org
Sender: "Qemu-block"
	<qemu-block-bounces+gceqb-qemu-block=m.gmane.org@nongnu.org>
To: jazeltq@gmail.com
Cc: kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com, tianqing <tianqing@unitedstack.com>, ceph-devel@vger.kernel.org, dillaman@redhat.com
List-Id: ceph-devel.vger.kernel.org

On Tue, Feb 21, 2017 at 11:43:36AM +0800, jazeltq@gmail.com wrote:
> From: tianqing <tianqing@unitedstack.com>
> 
> Rbd can do readv and writev directly, so wo do not need to transform
> iov to buf or vice versa any more.
> 
> Signed-off-by: tianqing <tianqing@unitedstack.com>
> ---
>  block/rbd.c | 79 ++++++++++++++++++++++++++++++++++++++++++-------------------
>  1 file changed, 54 insertions(+), 25 deletions(-)
> 


[...]

>      case RBD_AIO_WRITE:
> -        r = rbd_aio_write(s->image, off, size, buf, c);
> +        if(!LIBRBD_USE_IOVEC)
> +            r = rbd_aio_write(s->image, off, size, rcb->buf, c);
> +        else
> +            r = rbd_aio_writev(s->image, qiov->iov, qiov->niov, off, c);
>          break;
>      case RBD_AIO_READ:
> -        r = rbd_aio_read(s->image, off, size, buf, c);
> +        if(!LIBRBD_USE_IOVEC)
> +            r = rbd_aio_read(s->image, off, size, rcb->buf, c);
> +        else
> +            r = rbd_aio_readv(s->image, qiov->iov, qiov->niov, off, c);

These will need to stay #ifdef's since they are new symbols.

>          break;
>      case RBD_AIO_DISCARD:
>          r = rbd_aio_discard_wrapper(s->image, off, size, c);
> @@ -712,14 +740,15 @@ static BlockAIOCB *rbd_start_aio(BlockDriverState *bs,
>      if (r < 0) {
>          goto failed_completion;
>      }
> -
>      return &acb->common;
>  
>  failed_completion:
>      rbd_aio_release(c);
>  failed:
>      g_free(rcb);
> -    qemu_vfree(acb->bounce);
> +    if(!LIBRBD_USE_IOVEC)
> +        qemu_vfree(acb->bounce);
> +
>      qemu_aio_unref(acb);
>      return NULL;
>  }
> -- 
> 2.10.2
>

(Also code formatting as pointed out by patchew)
