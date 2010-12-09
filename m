From: "Daniel P. Berrange" <berrange@redhat.com>
Subject: Re: [PATCH v2] add network disk support
Date: Thu, 9 Dec 2010 11:09:25 +0000
Message-ID: <20101209110925.GA5313@redhat.com>
References: <20101202131928.GV2502@redhat.com>
 <1291620249-19645-1-git-send-email-morita.kazutaka@lab.ntt.co.jp>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:1025 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750939Ab0LILJy (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 9 Dec 2010 06:09:54 -0500
Content-Disposition: inline
In-Reply-To: <1291620249-19645-1-git-send-email-morita.kazutaka@lab.ntt.co.jp>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: MORITA Kazutaka <morita.kazutaka@lab.ntt.co.jp>
Cc: libvir-list@redhat.com, sheepdog@lists.wpkg.org, ceph-devel@vger.kernel.org

On Mon, Dec 06, 2010 at 04:24:09PM +0900, MORITA Kazutaka wrote:
> This patch adds network disk support to libvirt/QEMU.  The currently
> supported protocols are nbd, rbd, and sheepdog.  The XML syntax is like
> this:
> 
>     <disk type="network" device="disk">
>       <driver name="qemu" type="raw" />
>       <source protocol='rbd|sheepdog|nbd' name="...some image identifier...">
>         <host name="mon1.example.org" port="6000">
>         <host name="mon2.example.org" port="6000">
>         <host name="mon3.example.org" port="6000">
>       </source>
>       <target dev="vda" bus="virtio" />
>     </disk>
> 
> Signed-off-by: MORITA Kazutaka <morita.kazutaka@lab.ntt.co.jp>
> ---
> 
> Hi,
> 
> Thanks for your comments, Daniel.  Here is a fixed version.
> 
> Changes from v1 to v2 are:
>  - check whether the XML input is valid or not more strictly
>  - fix memory leak in the error path
>  - add NULL check of the return value of strdup()
> 
> Thanks,
> 
> Kazutaka
> 
> 
>  docs/schemas/domain.rng |   31 +++++++
>  src/conf/domain_conf.c  |   95 +++++++++++++++++++-
>  src/conf/domain_conf.h  |   20 ++++
>  src/qemu/qemu_conf.c    |  221 ++++++++++++++++++++++++++++++++++++++++++++++-
>  4 files changed, 358 insertions(+), 9 deletions(-)

ACK

Daniel
