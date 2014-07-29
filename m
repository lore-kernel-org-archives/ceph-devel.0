From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 9/9] uwb/whci: use correct structure type name in sizeof
Date: Tue, 29 Jul 2014 17:16:51 +0200
Message-ID: <1406647011-8543-10-git-send-email-Julia.Lawall@lip6.fr>
References: <1406647011-8543-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1406647011-8543-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-ia64@vger.kernel.org, ceph-devel@vger.kernel.org, toralf.foerster@gmx.de, hmh@hmh.eng.br, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

Correct typo in the name of the type given to sizeof.  Because it is the
size of a pointer that is wanted, the typo has no impact on compilation or
execution.

This problem was found using Coccinelle (http://coccinelle.lip6.fr/).  The
semantic patch used can be found in message 0 of this patch series.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/uwb/whci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/uwb/whci.c b/drivers/uwb/whci.c
index c9df8ba..46b7cfc 100644
--- a/drivers/uwb/whci.c
+++ b/drivers/uwb/whci.c
@@ -175,7 +175,7 @@ static int whci_probe(struct pci_dev *pci, const struct pci_device_id *id)
 
 	err = -ENOMEM;
 	card = kzalloc(sizeof(struct whci_card)
-		       + sizeof(struct whci_dev *) * (n_caps + 1),
+		       + sizeof(struct umc_dev *) * (n_caps + 1),
 		       GFP_KERNEL);
 	if (card == NULL)
 		goto error_kzalloc;
