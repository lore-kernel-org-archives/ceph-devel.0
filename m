From: Stefan Priebe - Profihost AG <s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org>
Subject: Re: [Qemu-devel] [PATCH] use int64_t for return values
 from rbd instead of int
Date: Thu, 22 Nov 2012 10:08:24 +0100
Message-ID: <50ADEB88.2090100@profihost.ag>
References: <1353415495-30561-1-git-send-email-s.priebe@profihost.ag>
	<50AD096E.9080002@weilnetz.de>
	<CAFEAcA-cAx88UZRQjHT7uk_oj8P+tXBJ+hb9v0N1Wym8FUMkHQ@mail.gmail.com>
	<50ADE115.4060707@profihost.ag>
	<CAFEAcA86AomWmobTObpw80rMNWM30JzAKqHZXWxmB48+GU3VYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <pve-devel-bounces-KmHT29P9Uc/4CZzEM2C48g@public.gmane.org>
In-Reply-To: <CAFEAcA86AomWmobTObpw80rMNWM30JzAKqHZXWxmB48+GU3VYQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://pve.proxmox.com/cgi-bin/mailman/options/pve-devel>,
	<mailto:pve-devel-request-KmHT29P9Uc/4CZzEM2C48g@public.gmane.org?subject=unsubscribe>
List-Archive: <http://pve.proxmox.com/pipermail/pve-devel>
List-Post: <mailto:pve-devel-KmHT29P9Uc/4CZzEM2C48g@public.gmane.org>
List-Help: <mailto:pve-devel-request-KmHT29P9Uc/4CZzEM2C48g@public.gmane.org?subject=help>
List-Subscribe: <http://pve.proxmox.com/cgi-bin/mailman/listinfo/pve-devel>,
	<mailto:pve-devel-request-KmHT29P9Uc/4CZzEM2C48g@public.gmane.org?subject=subscribe>
Sender: pve-devel-bounces-KmHT29P9Uc/4CZzEM2C48g@public.gmane.org
Errors-To: pve-devel-bounces-KmHT29P9Uc/4CZzEM2C48g@public.gmane.org
To: Peter Maydell <peter.maydell-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Stefan Hajnoczi <stefanha-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Stefan Weil <sw-QDXxdeohBKYb1SvskN2V4Q@public.gmane.org>, qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org, pve-devel-KmHT29P9Uc/4CZzEM2C48g@public.gmane.org, pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, josh.durgin-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

Hello,

i send a new patch using ssize_t. (Subject [PATCH] overflow of int ret: 
use ssize_t for ret)

Stefan

Am 22.11.2012 09:40, schrieb Peter Maydell:
> On 22 November 2012 08:23, Stefan Priebe - Profihost AG
> <s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org> wrote:
>> Am 21.11.2012 23:32, schrieb Peter Maydell:
>>> Looking at the librbd API (which is what the size and ret
>>> values come from), it uses size_t and ssize_t for these.
>>> So I think probably ssize_t is the right type for ret
>>> (and size) in our structs here.
>>
>>
>> This sounds reasonable but does ssize_t support negative values? For error
>> values.
>
> Yes, the first 's' in ssize_t means 'signed' and is the
> difference between it and size_t.
>
> -- PMM
>
