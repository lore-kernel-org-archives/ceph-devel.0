From: chenanqing@oppo.com
Subject: (unknown)
Date: Fri, 27 Mar 2020 05:20:03 -0400
Message-ID: <5e7dc543.vYG3wru8B/me1sOV%chenanqing@oppo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: chenanqing@oppo.com, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, open-iscsi@googlegroups.com, ceph-devel@vger.kernel.org, martin.petersen@oracle.com, jejb@linux.ibm.com, cleech@redhat.com, lduncan@suse.com
List-Id: ceph-devel.vger.kernel.org

From: Chen Anqing <chenanqing@oppo.com>
To: Lee Duncan <lduncan@suse.com>
Cc: Chris Leech <cleech@redhat.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        ceph-devel@vger.kernel.org,
        open-iscsi@googlegroups.com,
        linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        chenanqing@oppo.com
Subject: [PATCH] scsi: libiscsi: we should take compound page into account =
also
Date: Fri, 27 Mar 2020 05:20:01 -0400
Message-Id: <20200327092001.56879-1-chenanqing@oppo.com>
X-Mailer: git-send-email 2.18.2

the patch is occur at a real crash,which slab is
come from a compound page,so we need take the compound page
into account also.
fixed commit 08b11eaccfcf ("scsi: libiscsi: fall back to
sendmsg for slab pages").

Signed-off-by: Chen Anqing <chenanqing@oppo.com>
---
 drivers/scsi/libiscsi_tcp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/libiscsi_tcp.c b/drivers/scsi/libiscsi_tcp.c
index 6ef93c7af954..98304e5e1f6f 100644
--- a/drivers/scsi/libiscsi_tcp.c
+++ b/drivers/scsi/libiscsi_tcp.c
@@ -128,7 +128,8 @@ static void iscsi_tcp_segment_map(struct iscsi_segment =
*segment, int recv)
         * coalescing neighboring slab objects into a single frag which
         * triggers one of hardened usercopy checks.
         */
-       if (!recv && page_count(sg_page(sg)) >=3D 1 && !PageSlab(sg_page(sg=
)))
+       if (!recv && page_count(sg_page(sg)) >=3D 1 &&
+           !PageSlab(compound_head(sg_page(sg))))
                return;

        if (recv) {
--
2.18.2

________________________________
OPPO

=E6=9C=AC=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=
=BB=B6=E5=90=AB=E6=9C=89OPPO=E5=85=AC=E5=8F=B8=E7=9A=84=E4=BF=9D=E5=AF=86=
=E4=BF=A1=E6=81=AF=EF=BC=8C=E4=BB=85=E9=99=90=E4=BA=8E=E9=82=AE=E4=BB=B6=E6=
=8C=87=E6=98=8E=E7=9A=84=E6=94=B6=E4=BB=B6=E4=BA=BA=E4=BD=BF=E7=94=A8=EF=BC=
=88=E5=8C=85=E5=90=AB=E4=B8=AA=E4=BA=BA=E5=8F=8A=E7=BE=A4=E7=BB=84=EF=BC=89=
=E3=80=82=E7=A6=81=E6=AD=A2=E4=BB=BB=E4=BD=95=E4=BA=BA=E5=9C=A8=E6=9C=AA=E7=
=BB=8F=E6=8E=88=E6=9D=83=E7=9A=84=E6=83=85=E5=86=B5=E4=B8=8B=E4=BB=A5=E4=BB=
=BB=E4=BD=95=E5=BD=A2=E5=BC=8F=E4=BD=BF=E7=94=A8=E3=80=82=E5=A6=82=E6=9E=9C=
=E6=82=A8=E9=94=99=E6=94=B6=E4=BA=86=E6=9C=AC=E9=82=AE=E4=BB=B6=EF=BC=8C=E8=
=AF=B7=E7=AB=8B=E5=8D=B3=E4=BB=A5=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=E9=80=
=9A=E7=9F=A5=E5=8F=91=E4=BB=B6=E4=BA=BA=E5=B9=B6=E5=88=A0=E9=99=A4=E6=9C=AC=
=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=BB=B6=E3=80=82

This e-mail and its attachments contain confidential information from OPPO,=
 which is intended only for the person or entity whose address is listed ab=
ove. Any use of the information contained herein in any way (including, but=
 not limited to, total or partial disclosure, reproduction, or disseminatio=
n) by persons other than the intended recipient(s) is prohibited. If you re=
ceive this e-mail in error, please notify the sender by phone or email imme=
diately and delete it!
