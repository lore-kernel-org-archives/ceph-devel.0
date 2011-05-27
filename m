From: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v6 0/4] rbd improvements
Date: Fri, 27 May 2011 08:45:37 +0200
Message-ID: <4DDF4891.8070402@redhat.com>
References: <1306451254-25864-1-git-send-email-josh.durgin@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
In-Reply-To: <1306451254-25864-1-git-send-email-josh.durgin@dreamhost.com>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: </archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
To: Josh Durgin <josh.durgin@dreamhost.com>
Cc: ceph-devel@vger.kernel.org, qemu-devel@nongnu.org, kvm@vger.kernel.org, Christian Brunner <chb@muc.de>
List-Id: ceph-devel.vger.kernel.org

Am 27.05.2011 01:07, schrieb Josh Durgin:
> This patchset moves the complexity of the rbd format into librbd and
> adds truncation support.
> 
> Changes since v5:
>  * compare full string, not prefix, with "conf" in 2/4
>  * when truncate fails, just return librbd's error
> 
> Changes since v4:
>  * fixed cosmetic issues pointed out by Christian Brunner
> 
> Changes since v3:
>  * trivially rebased
>  * updated copyright header
> 
> Changes since v2:
>  * return values are checked in rbd_aio_rw_vector
>  * bdrv_truncate added
> 
> Josh Durgin (4):
>   rbd: use the higher level librbd instead of just librados
>   rbd: allow configuration of rados from the rbd filename
>   rbd: check return values when scheduling aio
>   rbd: Add bdrv_truncate implementation
> 
>  block/rbd.c       |  896 +++++++++++++++++++----------------------------------
>  block/rbd_types.h |   71 -----
>  configure         |   33 +--
>  3 files changed, 334 insertions(+), 666 deletions(-)
>  delete mode 100644 block/rbd_types.h

Thanks, applied to the block branch.

Kevin
