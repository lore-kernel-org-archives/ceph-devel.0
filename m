From: Stefan Priebe - Profihost AG <s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org>
Subject: Re: [Qemu-devel] [PATCH] use int64_t for return values
 from rbd instead of int
Date: Wed, 21 Nov 2012 09:33:08 +0100
Message-ID: <50AC91C4.4070900@profihost.ag>
References: <1353415495-30561-1-git-send-email-s.priebe@profihost.ag>
	<20121120162922.GA8665@stefanha-thinkpad.redhat.com>
	<50ABD713.3050300@profihost.ag>
	<CAJSP0QXcjaRdeQ55GSPtSqam+WHUGPAz4+ohajTCMR8f+4oKrQ@mail.gmail.com>
	<50AC8704.2020407@profihost.ag>
	<20121121082616.GB13504@stefanha-thinkpad.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <pve-devel-bounces-KmHT29P9Uc/4CZzEM2C48g@public.gmane.org>
In-Reply-To: <20121121082616.GB13504-lxVrvc10SDTaErKTczak/Dh473NlOPsLVpNB7YpNyf8@public.gmane.org>
List-Unsubscribe: <http://pve.proxmox.com/cgi-bin/mailman/options/pve-devel>,
	<mailto:pve-devel-request-KmHT29P9Uc/4CZzEM2C48g@public.gmane.org?subject=unsubscribe>
List-Archive: <http://pve.proxmox.com/pipermail/pve-devel>
List-Post: <mailto:pve-devel-KmHT29P9Uc/4CZzEM2C48g@public.gmane.org>
List-Help: <mailto:pve-devel-request-KmHT29P9Uc/4CZzEM2C48g@public.gmane.org?subject=help>
List-Subscribe: <http://pve.proxmox.com/cgi-bin/mailman/listinfo/pve-devel>,
	<mailto:pve-devel-request-KmHT29P9Uc/4CZzEM2C48g@public.gmane.org?subject=subscribe>
Sender: pve-devel-bounces-KmHT29P9Uc/4CZzEM2C48g@public.gmane.org
Errors-To: pve-devel-bounces-KmHT29P9Uc/4CZzEM2C48g@public.gmane.org
To: Stefan Hajnoczi <stefanha-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Paolo Bonzini <pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, qemu-devel <qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org>, pve-devel-KmHT29P9Uc/4CZzEM2C48g@public.gmane.org, josh.durgin-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

Am 21.11.2012 09:26, schrieb Stefan Hajnoczi:
> On Wed, Nov 21, 2012 at 08:47:16AM +0100, Stefan Priebe - Profihost AG wrote:
>> Am 21.11.2012 07:41, schrieb Stefan Hajnoczi:
> We're going in circles here.  I know the types are wrong in the code and
> your patch fixes it, that's why I said it looks good in my first reply.

Sorry not so familiar with processes like these.


> QEMU is currently in hard freeze and only critical patches should go in.
> Providing steps to reproduce the bug helps me decide that this patch
> should still be merged for QEMU 1.3-rc1.
>
> Anyway, the patch is straightforward, I have applied it to my block tree
> and it will be in QEMU 1.3-rc1:
> https://github.com/stefanha/qemu/commits/block

Thanks!

The steps to reproduce are:
mkfs.xfs -f a whole device bigger than int in bytes. mkfs.xfs sends a 
discard. Important is that you use scsi-hd and set 
discard_granularity=512. Otherwise rbd disabled discard support.

Might you have a look at my other rbd fix too? It fixes a race between 
task cancellation and writes. The same race was fixed in iscsi this summer.

Greets,
Stefan
