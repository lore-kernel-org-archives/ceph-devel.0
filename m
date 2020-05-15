From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 27/33] sctp: export sctp_setsockopt_bindx
Date: Fri, 15 May 2020 16:20:02 +0100
Message-ID: <129070.1589556002@warthog.procyon.org.uk>
References: <20200514062820.GC8564@lst.de>
	<20200513062649.2100053-1-hch@lst.de>
	<20200513062649.2100053-28-hch@lst.de>
	<20200513180058.GB2491@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <cluster-devel-bounces@redhat.com>
In-Reply-To: <20200514062820.GC8564@lst.de>
Content-ID: <129069.1589556002.1@warthog.procyon.org.uk>
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
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, dhowells@redhat.com, linux-sctp@vger.kernel.org, target-devel@vger.kernel.org, linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org, rds-devel@oss.oracle.com, linux-rdma@vger.kernel.org, cluster-devel@redhat.com, Jakub Kicinski <kuba@kernel.org>, linux-block@vger.kernel.org, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, drbd-dev@tron.linbit.com, ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org, Neil Horman <nhorman@tuxdriver.com>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org, Vlad Yasevich <vyasevich@gmail.com>, Eric Dumazet <edumazet@google.com>, Jon Maloy <jmaloy@redhat.com>, Ying Xue <ying.xue@windriver.com>, "David S. Miller" <davem@davemloft.net>, ocfs2-devel@oss.oracle.com
List-Id: ceph-devel.vger.kernel.org

Christoph Hellwig <hch@lst.de> wrote:

> > The advantage on using kernel_setsockopt here is that sctp module will
> > only be loaded if dlm actually creates a SCTP socket.  With this
> > change, sctp will be loaded on setups that may not be actually using
> > it. It's a quite big module and might expose the system.
> 
> True.  Not that the intent is to kill kernel space callers of setsockopt,
> as I plan to remove the set_fs address space override used for it.

For getsockopt, does it make sense to have the core kernel load optval/optlen
into a buffer before calling the protocol driver?  Then the driver need not
see the userspace pointer at all.

Similar could be done for setsockopt - allocate a buffer of the size requested
by the user inside the kernel and pass it into the driver, then copy the data
back afterwards.

David
