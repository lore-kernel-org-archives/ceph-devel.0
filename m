From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 2/2] block-rbd: One function call less in
 rbd_dev_probe_parent() after error detection
Date: Wed, 25 Nov 2015 18:26:44 +0300
Message-ID: <20151125152644.GB18797@mwanda>
References: <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net>
 <56536BAD.4000309@users.sourceforge.net>
 <56536D12.4000308@users.sourceforge.net>
 <CAOi1vP_t6-vw-sesRwpgfbqLVRyevOP4uvhbj05b3PPg=oHD6Q@mail.gmail.com>
 <5654B91D.4040808@users.sourceforge.net>
 <CAOi1vP-Z2yfJVcpqZN8EOf6rYsd41ixOOQWVva_xkKmA6PLrhg@mail.gmail.com>
 <20151125115512.GA18797@mwanda>
 <CAOi1vP_zf6q=Dzy8F_OCUTDCHp2KXU2nv5DSjJXAKekcStXQgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOi1vP_zf6q=Dzy8F_OCUTDCHp2KXU2nv5DSjJXAKekcStXQgw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ilya Dryomov <idryomov@gmail.com>
Cc: SF Markus Elfring <elfring@users.sourceforge.net>, Alex Elder <elder@kernel.org>, Sage Weil <sage@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: ceph-devel.vger.kernel.org

Ah... I see now.  Thanks.

regards,
dan carpenter
