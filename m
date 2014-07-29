From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 1/9] drivers/staging/media/davinci_vpfe/vpfe_mc_capture.c: use
 correct structure type name in sizeof
Date: Tue, 29 Jul 2014 17:16:43 +0200
Message-ID: <1406647011-8543-2-git-send-email-Julia.Lawall@lip6.fr>
References: <1406647011-8543-1-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <1406647011-8543-1-git-send-email-Julia.Lawall@lip6.fr>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: Mauro Carvalho Chehab <m.chehab@samsung.com>
Cc: devel@driverdev.osuosl.org, linux-ia64@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, hmh@hmh.eng.br, toralf.foerster@gmx.de, ceph-devel@vger.kernel.org, linux-media@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

Correct typo in the name of the type given to sizeof.  Because it is the
size of a pointer that is wanted, the typo has no impact on compilation or
execution.

This problem was found using Coccinelle (http://coccinelle.lip6.fr/).  The
semantic patch used can be found in message 0 of this patch series.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/staging/media/davinci_vpfe/vpfe_mc_capture.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/davinci_vpfe/vpfe_mc_capture.c b/drivers/staging/media/davinci_vpfe/vpfe_mc_capture.c
index cda8388..255590f 100644
--- a/drivers/staging/media/davinci_vpfe/vpfe_mc_capture.c
+++ b/drivers/staging/media/davinci_vpfe/vpfe_mc_capture.c
@@ -227,7 +227,7 @@ static int vpfe_enable_clock(struct vpfe_device *vpfe_dev)
 		return 0;
 
 	vpfe_dev->clks = kzalloc(vpfe_cfg->num_clocks *
-				   sizeof(struct clock *), GFP_KERNEL);
+				   sizeof(struct clk *), GFP_KERNEL);
 	if (vpfe_dev->clks == NULL) {
 		v4l2_err(vpfe_dev->pdev->driver, "Memory allocation failed\n");
 		return -ENOMEM;
