From: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 1/1] qemu-img: async write to block device when converting
 image
Date: Mon, 19 Sep 2011 13:01:46 +0200
Message-ID: <4E77211A.2060808@redhat.com>
References: <ea3984c0f16e44c14f8b9352375f6299d8e1b647.1315836010.git.yehuda@hq.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46898 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755087Ab1ISK6v (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 19 Sep 2011 06:58:51 -0400
In-Reply-To: <ea3984c0f16e44c14f8b9352375f6299d8e1b647.1315836010.git.yehuda@hq.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@hq.newdream.net>
Cc: qemu-devel@nongnu.org, ceph-devel@vger.kernel.org, sage@newdream.net, yehudasa@gmail.com

Am 12.09.2011 16:26, schrieb Yehuda Sadeh:
> In order to improve image conversion process, instead of synchronously
> writing the destingation image, we keep a window of async writes.
> 
> Signed-off-by: Yehuda Sadeh <yehuda@hq.newdream.net>

Hm, now that I'm really looking at the code, it seems that I
misunderstood why you're doing here. With this patch applied, qemu-img
will synchronously read in its buffer from the source file and then
write it out in multiple parallel AIO requests. The next buffer is read
in only when all AIO requests have completed.

What I thought it was is that the whole thing is async, including
reading new buffers from the source file while other AIO requests are
still writing. I think that would be much more useful.

> ---
>  qemu-img.c |   47 +++++++++++++++++++++++++++++++++++++++++++----
>  1 files changed, 43 insertions(+), 4 deletions(-)
> 
> diff --git a/qemu-img.c b/qemu-img.c
> index 6a39731..a45f5f2 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -646,6 +646,29 @@ static int compare_sectors(const uint8_t *buf1, const uint8_t *buf2, int n,
>  }
>  
>  #define IO_BUF_SIZE (2 * 1024 * 1024)
> +#define IO_WRITE_WINDOW_THRESHOLD (32 * 1024 * 1024)
> +
> +static int write_window = 0;
> +static int write_ret = 0;
> +
> +struct write_info {
> +    int64_t sector;
> +    QEMUIOVector qiov;
> +};
> +
> +static void img_write_cb(void *opaque, int ret)
> +{
> +    struct write_info *wr = (struct write_info *)opaque;
> +    QEMUIOVector *qiov = &wr->qiov;
> +    if (ret < 0) {
> +        error_report("error while writing sector %" PRId64
> +                     ": %s", wr->sector, strerror(-ret));
> +        write_ret = ret;
> +    }
> +    write_window -=  qiov->iov->iov_len / 512;

I would rather use bytes as unit for write window (especially as
IO_WRITE_WINDOW_THRESHOLD is in bytes).

> +    qemu_iovec_destroy(qiov);
> +    g_free(wr);
> +}
>  
>  static int img_convert(int argc, char **argv)
>  {
> @@ -1019,6 +1042,9 @@ static int img_convert(int argc, char **argv)
>                 should add a specific call to have the info to go faster */
>              buf1 = buf;
>              while (n > 0) {
> +                while (write_window > IO_WRITE_WINDOW_THRESHOLD / 512) {
> +                    qemu_aio_wait();
> +                }
>                  /* If the output image is being created as a copy on write image,
>                     copy all sectors even the ones containing only NUL bytes,
>                     because they may differ from the sectors in the base image.
> @@ -1028,12 +1054,21 @@ static int img_convert(int argc, char **argv)
>                     already there is garbage, not 0s. */
>                  if (!has_zero_init || out_baseimg ||
>                      is_allocated_sectors_min(buf1, n, &n1, min_sparse)) {
> -                    ret = bdrv_write(out_bs, sector_num, buf1, n1);
> -                    if (ret < 0) {
> -                        error_report("error while writing sector %" PRId64
> -                                     ": %s", sector_num, strerror(-ret));
> +                    QEMUIOVector *qiov;
> +                    struct write_info *wr;
> +                    BlockDriverAIOCB *acb;
> +                    wr = g_malloc0(sizeof(struct write_info));
> +                    qiov = &wr->qiov;
> +                    qemu_iovec_init(qiov, 1);
> +                    qemu_iovec_add(qiov, (void *)buf1, n1 * 512);

Casts to void* are unnecessary.

You could use qemu_iovec_init_external in order to avoid the malloc here
(cf. bdrv_read)...

> +                    wr->sector = sector_num;
> +                    acb = bdrv_aio_writev(out_bs, sector_num, qiov, n1, img_write_cb, wr);
> +                    if (!acb) {

...then you wouldn't have the chance to forget qemu_iodev_destroy()
here. :-)

> +                        g_free(wr);
> +                        error_report("I/O error while writing sector %" PRId64, sector_num);
>                          goto out;
>                      }
> +                    write_window += n1;
>                  }
>                  sector_num += n1;
>                  n -= n1;
> @@ -1041,6 +1076,9 @@ static int img_convert(int argc, char **argv)
>              }
>              qemu_progress_print(local_progress, 100);
>          }
> +        while (write_window > 0) {
> +            qemu_aio_wait();
> +        }
>      }
>  out:
>      qemu_progress_end();
> @@ -1048,6 +1086,7 @@ out:
>      free_option_parameters(param);
>      qemu_vfree(buf);
>      if (out_bs) {
> +        bdrv_flush(out_bs);
>          bdrv_delete(out_bs);
>      }
>      if (bs) {

The bdrv_flush() looks unrelated to introducing AIO.

Kevin
