From: Andrey Korolyov <andrey@xdel.ru>
Subject: Re: ceph-disk triggers XFS kernel bug?
Date: Mon, 29 Jan 2018 19:13:39 +0300
Message-ID: <CABYiri-HRU58Vhc5-_fuBMOZgYpMaNCkLpNECgfs=HEkg4PzFA@mail.gmail.com>
References: <CAGbviv+P9573YaCKhULn3bE-Txz7-wDHoTuvft2vEZGn1xyQ6Q@mail.gmail.com>
 <CAJE9aONOiym_UCbe5GD4wgbhcQSVtTVYt1dJE+gnr6Fvk22=jg@mail.gmail.com>
 <FB9565CD-3BF6-4F99-88BB-458C49C46DBC@flyingcircus.io> <E3CF8663-526C-4C55-96B5-BF121E4F4875@flyingcircus.io>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f174.google.com ([209.85.217.174]:41224 "EHLO
        mail-ua0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750959AbeA2QOA (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Jan 2018 11:14:00 -0500
Received: by mail-ua0-f174.google.com with SMTP id f5so5004702ual.8
        for <ceph-devel@vger.kernel.org>; Mon, 29 Jan 2018 08:13:59 -0800 (PST)
In-Reply-To: <E3CF8663-526C-4C55-96B5-BF121E4F4875@flyingcircus.io>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christian Theune <ct@flyingcircus.io>
Cc: kefu chai <tchaikov@gmail.com>, Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>, Ceph Development <ceph-devel@vger.kernel.org>

It appears that RH fixed that bug on top on their xfs queue:

--- a/fs/xfs/xfs_attr_inactive.c
+++ b/fs/xfs/xfs_attr_inactive.c
@@ -302,6 +302,8 @@
                                                 &bp, XFS_ATTR_FORK);
                        if (error)
                                return error;
+                       node = bp->b_addr;
+                       btree = dp->d_ops->node_tree_p(node);
                        child_fsb = be32_to_cpu(btree[i + 1].before);
                        xfs_trans_brelse(*trans, bp);
                }
