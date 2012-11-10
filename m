From: Stefan Priebe <s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org>
Subject: Re: Limited IOP/s on Dual Xeon KVM Host
Date: Sat, 10 Nov 2012 14:49:11 +0100
Message-ID: <509E5B57.1050004@profihost.ag>
References: <509E0A65.1040903@profihost.ag> <509E5979.3070508@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <pve-devel-bounces-KmHT29P9Uc/4CZzEM2C48g@public.gmane.org>
In-Reply-To: <509E5979.3070508-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <http://pve.proxmox.com/cgi-bin/mailman/options/pve-devel>,
	<mailto:pve-devel-request-KmHT29P9Uc/4CZzEM2C48g@public.gmane.org?subject=unsubscribe>
List-Archive: <http://pve.proxmox.com/pipermail/pve-devel>
List-Post: <mailto:pve-devel-KmHT29P9Uc/4CZzEM2C48g@public.gmane.org>
List-Help: <mailto:pve-devel-request-KmHT29P9Uc/4CZzEM2C48g@public.gmane.org?subject=help>
List-Subscribe: <http://pve.proxmox.com/cgi-bin/mailman/listinfo/pve-devel>,
	<mailto:pve-devel-request-KmHT29P9Uc/4CZzEM2C48g@public.gmane.org?subject=subscribe>
Sender: pve-devel-bounces-KmHT29P9Uc/4CZzEM2C48g@public.gmane.org
Errors-To: pve-devel-bounces-KmHT29P9Uc/4CZzEM2C48g@public.gmane.org
To: Mark Nelson <mark.nelson-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "pve-devel-KmHT29P9Uc/4CZzEM2C48g@public.gmane.org" <pve-devel-KmHT29P9Uc/4CZzEM2C48g@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Am 10.11.2012 14:41, schrieb Mark Nelson:
> On 11/10/2012 02:03 AM, Stefan Priebe wrote:
>> Hello lists,
>>
>> on a dual Xeon KVM Host i get max 6000 IOP/s random 4k writes AND reads.
>> On a Single Xeon KVM Host i get 17.000-18.000 IOP/s write and read. I
>> already tried to pin the kvm process using numactl and also the fio
>> process but it doesn't help on the dual xeon.
>>
>> 10GBE Network is fine. I get 9.8Gbit/s on both hosts. Kernel is also he
>> same on both.
>>
>> Anybody an idea?
>
> When you say KVM host, do you mean the underlying node or the virtual
> machine instance?
Sorry i'm talking about the vm host regarding the HW. The vm instance is 
always the same.

> If you mean underlying node, it could be remote memory access or if you
> are on a last gen xeon if you have dual io hubs, you could be hitting a
> remote io hub for the network card.  I wouldn't think that would cause
> such a big hit, but those are things to look into.

I'm on E5-Xeon. What means io hub?

Stefan
