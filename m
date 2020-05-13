From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 21/33] ipv4: add ip_sock_set_mtu_discover
Date: Wed, 13 May 2020 14:17:41 +0100
Message-ID: <3123898.1589375861@warthog.procyon.org.uk>
References: <20200513062649.2100053-22-hch@lst.de>
	<20200513062649.2100053-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <cluster-devel-bounces@redhat.com>
In-Reply-To: <20200513062649.2100053-22-hch@lst.de>
Content-ID: <3123897.1589375861.1@warthog.procyon.org.uk>
List-Unsubscribe: <https://www.redhat.com/mailman/options/cluster-devel>,
	<mailto:cluster-devel-request@redhat.com?subject=unsubscribe>
List-Archive: <https://www.redhat.com/archives/cluster-devel>
List-Post: <mailto:cluster-devel@redhat.com>
List-Help: <mailto:cluster-devel-request@redhat.com?subject=help>
List-Subscribe: <https://www.redhat.com/mailman/listinfo/cluster-devel>,
	<mailto:cluster-devel-request@redhat.com?subject=subscribe>
Sender: cluster-devel-bounces@redhat.com
Errors-To: cluster-devel-bounces@redhat.com
To: Christoph Hellwig <hch@lst.de>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, dhowells@redhat.com, linux-sctp@vger.kernel.org, target-devel@vger.kernel.org, linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org, rds-devel@oss.oracle.com, linux-rdma@vger.kernel.org, cluster-devel@redhat.com, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, linux-block@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, drbd-dev@tron.linbit.com, ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org, Neil Horman <nhorman@tuxdriver.com>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org, Vlad Yasevich <vyasevich@gmail.com>, Eric Dumazet <edumazet@google.com>, Jon Maloy <jmaloy@redhat.com>, Ying Xue <ying.xue@windriver.com>, "David S. Miller" <davem@davemloft.net>, ocfs2-devel@oss.oracle.com
List-Id: ceph-devel.vger.kernel.org

Christoph Hellwig <hch@lst.de> wrote:

> +		ip_sock_set_mtu_discover(conn->params.local->socket->sk,
> +				IP_PMTUDISC_DONT);

Um... The socket in question could be an AF_INET6 socket, not an AF_INET4
socket - I presume it will work in that case.  If so:

Reviewed-by: David Howells <dhowells@redhat.com> [rxrpc bits]
