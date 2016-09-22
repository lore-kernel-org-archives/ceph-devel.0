From: Josh Durgin <jdurgin@redhat.com>
Subject: Re: [PATCH] rbd : disable
 rbd_cache_writethrough_until_flush for cache=unsafe
Date: Wed, 21 Sep 2016 18:01:44 -0700
Message-ID: <796706e6-9acc-181d-5a73-65d2367dd263@redhat.com>
References: <1469622402-8634-1-git-send-email-aderumier@odiso.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
In-Reply-To: <1469622402-8634-1-git-send-email-aderumier@odiso.com>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: "Qemu-devel" <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
To: Alexandre Derumier <aderumier@odiso.com>, qemu-devel@nongnu.org
Cc: ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On 07/27/2016 05:26 AM, Alexandre Derumier wrote:
> ceph force writethrough until a flush is detected.
> With cache=unsafe, we never send flush.
> So we need to tell to ceph
> to set rbd_cache_writethrough_until_flush=false in this case.
>
> This speedup a lot qemu-img convert which use cache=unsafe by default
>
> Signed-off-by: Alexandre Derumier <aderumier@odiso.com>

Sorry for the delay - this is correct and needed since this option
appeared by default in Ceph hammer.

Reviewed-by: Josh Durgin <jdurgin@redhat.com>

> ---
>  block/rbd.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/block/rbd.c b/block/rbd.c
> index 0106fea..f3af6c8 100644
> --- a/block/rbd.c
> +++ b/block/rbd.c
> @@ -552,6 +552,10 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
>          rados_conf_set(s->cluster, "rbd_cache", "true");
>      }
>
> +    if (flags & BDRV_O_NO_FLUSH) {
> +        rados_conf_set(s->cluster, "rbd_cache_writethrough_until_flush", "false");
> +    }
> +
>      r = rados_connect(s->cluster);
>      if (r < 0) {
>          error_setg_errno(errp, -r, "error connecting");
>
