From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 06/33] net: add sock_set_timestamps
Date: Wed, 13 May 2020 14:27:05 +0100
Message-ID: <3124744.1589376425@warthog.procyon.org.uk>
References: <20200513062649.2100053-7-hch@lst.de> <20200513062649.2100053-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45666 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727832AbgEMN1W (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 13 May 2020 09:27:22 -0400
In-Reply-To: <20200513062649.2100053-7-hch@lst.de>
Content-ID: <3124743.1589376425.1@warthog.procyon.org.uk>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: dhowells@redhat.com, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Eric Dumazet <edumazet@google.com>, linux-nvme@lists.infradead.org, linux-sctp@vger.kernel.org, target-devel@vger.kernel.org, linux-afs@lists.infradead.org, drbd-dev@lists.linbit.com, linux-cifs@vger.kernel.org, rds-devel@oss.oracle.com, linux-rdma@vger.kernel.org, cluster-devel@redhat.com, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, linux-block@vger.kernel.org, ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org, Neil Horman <nhorman@tuxdriver.com>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org, Vlad Yasevich <vyasevich@gmail.com>, linux-kernel@vger.kernel.org, Jon Maloy <jmaloy@redhat.com>, Ying Xue <ying>

Christoph Hellwig <hch@lst.de> wrote:

> Add a helper to directly set the SO_TIMESTAMP* sockopts from kernel space
> without going through a fake uaccess.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: David Howells <dhowells@redhat.com>
