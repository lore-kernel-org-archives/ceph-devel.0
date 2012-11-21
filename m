From: Stefan Weil <sw@weilnetz.de>
Subject: Re: [PATCH] use int64_t for return values from rbd
 instead of int
Date: Wed, 21 Nov 2012 18:03:42 +0100
Message-ID: <50AD096E.9080002@weilnetz.de>
References: <1353415495-30561-1-git-send-email-s.priebe@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
In-Reply-To: <1353415495-30561-1-git-send-email-s.priebe@profihost.ag>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, pve-devel@pve.proxmox.com, josh.durgin@inktank.com, pbonzini@redhat.com, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Am 20.11.2012 13:44, schrieb Stefan Priebe:
> rbd / rados tends to return pretty often length of writes
> or discarded blocks. These values might be bigger than int.
>
> Signed-off-by: Stefan Priebe <s.priebe@profihost.ag>
> ---
>   block/rbd.c |    4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/block/rbd.c b/block/rbd.c
> index f57d0c6..6bf9c2e 100644
> --- a/block/rbd.c
> +++ b/block/rbd.c
> @@ -69,7 +69,7 @@ typedef enum {
>   typedef struct RBDAIOCB {
>       BlockDriverAIOCB common;
>       QEMUBH *bh;
> -    int ret;
> +    int64_t ret;
>       QEMUIOVector *qiov;
>       char *bounce;
>       RBDAIOCmd cmd;
> @@ -87,7 +87,7 @@ typedef struct RADOSCB {
>       int done;
>       int64_t size;
>       char *buf;
> -    int ret;
> +    int64_t ret;
>   } RADOSCB;
>   
>   #define RBD_FD_READ 0


Why do you use int64_t instead of off_t?
If the value is related to file sizes, off_t would be a good choice.

Stefan W.
