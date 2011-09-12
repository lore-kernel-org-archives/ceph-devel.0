From: Yehuda Sadeh Weinraub <yehuda@hq.newdream.net>
Subject: Re: [PATCH 1/1] qemu-img: async write to block device
	when converting image
Date: Mon, 12 Sep 2011 07:24:27 -0700
Message-ID: <CAC-hyiFFk5MJTerw6JhEEzmzbHnG2uhmUxh_v6-A6mD_LR1gRQ@mail.gmail.com>
References: <ea3984c0f16e44c14f8b9352375f6299d8e1b647.1315836010.git.yehuda@hq.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
In-Reply-To: <ea3984c0f16e44c14f8b9352375f6299d8e1b647.1315836010.git.yehuda@hq.newdream.net>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: </archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
To: qemu-devel@nongnu.org, ceph-devel@vger.kernel.org, kwolf@redhat.com
Cc: sage@newdream.net, yehudasa@gmail.com
List-Id: ceph-devel.vger.kernel.org

Note that I assumed qemu-img runs in a single context (like qemu), and
there are no concurrency issues. If that's not the case, the callback,
error handling need to be fixed.

Yehuda

On Mon, Sep 12, 2011 at 7:26 AM, Yehuda Sadeh <yehuda@hq.newdream.net> wrot=
e:
> In order to improve image conversion process, instead of synchronously
> writing the destingation image, we keep a window of async writes.
>
> Signed-off-by: Yehuda Sadeh <yehuda@hq.newdream.net>
> ---
> =A0qemu-img.c | =A0 47 +++++++++++++++++++++++++++++++++++++++++++----
> =A01 files changed, 43 insertions(+), 4 deletions(-)
>
> diff --git a/qemu-img.c b/qemu-img.c
> index 6a39731..a45f5f2 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -646,6 +646,29 @@ static int compare_sectors(const uint8_t *buf1, cons=
t uint8_t *buf2, int n,
> =A0}
>
> =A0#define IO_BUF_SIZE (2 * 1024 * 1024)
> +#define IO_WRITE_WINDOW_THRESHOLD (32 * 1024 * 1024)
> +
> +static int write_window =3D 0;
> +static int write_ret =3D 0;
> +
> +struct write_info {
> + =A0 =A0int64_t sector;
> + =A0 =A0QEMUIOVector qiov;
> +};
> +
> +static void img_write_cb(void *opaque, int ret)
> +{
> + =A0 =A0struct write_info *wr =3D (struct write_info *)opaque;
> + =A0 =A0QEMUIOVector *qiov =3D &wr->qiov;
> + =A0 =A0if (ret < 0) {
> + =A0 =A0 =A0 =A0error_report("error while writing sector %" PRId64
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ": %s", wr->sector, strerror(-r=
et));
> + =A0 =A0 =A0 =A0write_ret =3D ret;
> + =A0 =A0}
> + =A0 =A0write_window -=3D =A0qiov->iov->iov_len / 512;
> + =A0 =A0qemu_iovec_destroy(qiov);
> + =A0 =A0g_free(wr);
> +}
>
> =A0static int img_convert(int argc, char **argv)
> =A0{
> @@ -1019,6 +1042,9 @@ static int img_convert(int argc, char **argv)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0should add a specific call to have the inf=
o to go faster */
> =A0 =A0 =A0 =A0 =A0 =A0 buf1 =3D buf;
> =A0 =A0 =A0 =A0 =A0 =A0 while (n > 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0while (write_window > IO_WRITE_WINDOW_TH=
RESHOLD / 512) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0qemu_aio_wait();
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* If the output image is being created a=
s a copy on write image,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0copy all sectors even the ones con=
taining only NUL bytes,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0because they may differ from the s=
ectors in the base image.
> @@ -1028,12 +1054,21 @@ static int img_convert(int argc, char **argv)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0already there is garbage, not 0s. =
*/
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!has_zero_init || out_baseimg ||
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 is_allocated_sectors_min(buf1, n,=
 &n1, min_sparse)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D bdrv_write(out_bs, secto=
r_num, buf1, n1);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (ret < 0) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0error_report("error whil=
e writing sector %" PRId64
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 ": %s", sector_num, strerror(-ret));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0QEMUIOVector *qiov;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct write_info *wr;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0BlockDriverAIOCB *acb;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0wr =3D g_malloc0(sizeof(struct w=
rite_info));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0qiov =3D &wr->qiov;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0qemu_iovec_init(qiov, 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0qemu_iovec_add(qiov, (void *)buf=
1, n1 * 512);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0wr->sector =3D sector_num;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0acb =3D bdrv_aio_writev(out_bs, =
sector_num, qiov, n1, img_write_cb, wr);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!acb) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0g_free(wr);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0error_report("I/O error =
while writing sector %" PRId64, sector_num);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0write_window +=3D n1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sector_num +=3D n1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 n -=3D n1;
> @@ -1041,6 +1076,9 @@ static int img_convert(int argc, char **argv)
> =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0 =A0 =A0 qemu_progress_print(local_progress, 100);
> =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0while (write_window > 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0qemu_aio_wait();
> + =A0 =A0 =A0 =A0}
> =A0 =A0 }
> =A0out:
> =A0 =A0 qemu_progress_end();
> @@ -1048,6 +1086,7 @@ out:
> =A0 =A0 free_option_parameters(param);
> =A0 =A0 qemu_vfree(buf);
> =A0 =A0 if (out_bs) {
> + =A0 =A0 =A0 =A0bdrv_flush(out_bs);
> =A0 =A0 =A0 =A0 bdrv_delete(out_bs);
> =A0 =A0 }
> =A0 =A0 if (bs) {
> --
> 1.7.5.1
>
>
