From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v5 12/29] compat_ioctl: move drivers to compat_ptr_ioctl
Date: Tue, 30 Jul 2019 14:43:29 -0700 (PDT)
Message-ID: <20190730.144329.2267958732987589628.davem@davemloft.net>
References: <20190730192552.4014288-1-arnd@arndb.de>
        <20190730195227.742215-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190730195227.742215-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: arnd@arndb.de
Cc: viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, mst@redhat.com, jarkko.sakkinen@linux.intel.com, jgg@mellanox.com, jkosina@suse.cz, stefanha@redhat.com, linux-integrity@vger.kernel.org, linux1394-devel@lists.sourceforge.net, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org, netdev@vger.kernel.org, devel@driverdev.osuosl.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 30 Jul 2019 21:50:28 +0200

> Each of these drivers has a copy of the same trivial helper function to
> convert the pointer argument and then call the native ioctl handler.
> 
> We now have a generic implementation of that, so use it.
> 
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
> Reviewed-by: Jiri Kosina <jkosina@suse.cz>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I assume this has to go via your series, thus:

Acked-by: David S. Miller <davem@davemloft.net>
