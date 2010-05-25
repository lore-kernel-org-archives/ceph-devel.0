From: Avi Kivity <avi@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 1/1] ceph/rbd block driver for qemu-kvm
Date: Tue, 25 May 2010 16:57:45 +0300
Message-ID: <4BFBD759.40601@redhat.com>
References: <20100519192222.GD61706@ncolin.muc.de>	 <AANLkTimXqk7oa4mtcoHX1rKWzi_Nccb0FJu_QDtwJ-sP@mail.gmail.com>	 <AANLkTil-aogxdnMallKTDo1bKXj6QmaU0ojJuiZgXaqC@mail.gmail.com>	 <4BF5A9D2.5080609@codemonkey.ws> <4BF91937.2070801@redhat.com>	 <87wrutg4dk.wl%morita.kazutaka@lab.ntt.co.jp>	 <4BFA5D96.3030603@redhat.com>	 <lpvdad4jcf.wl%morita.kazutaka@lab.ntt.co.jp>	 <4BFA696D.2060606@redhat.com>	 <lphblxiele.wl%morita.kazutaka@lab.ntt.co.jp> <AANLkTilHGvaCDjeRSG3al2GOC7ts9uXGZ9DOGwBU5MEy@mail.gmail.com> <4BFAD59E.2010706@codemonkey.ws> <4BFB94D9.5080904@redhat.com> <4BFBCDD9.4070104@codemonkey.ws> <4BFBCFB9.6020104@redhat.com> <4BFBD0C6.9000105@codemonkey.ws> <4BFBD261.9040908@redhat.com> <4BFBD693.2030108@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:30100 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754873Ab0EYN57 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 25 May 2010 09:57:59 -0400
In-Reply-To: <4BFBD693.2030108@codemonkey.ws>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: Christian Brunner <chb@muc.de>, MORITA Kazutaka <morita.kazutaka@lab.ntt.co.jp>, Blue Swirl <blauwirbel@gmail.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org, ceph-devel@vger.kernel.org

On 05/25/2010 04:54 PM, Anthony Liguori wrote:
> On 05/25/2010 08:36 AM, Avi Kivity wrote:
>>
>> We'd need a kernel-level generic snapshot API for this eventually.
>>
>>> or (2) implement BUSE to complement FUSE and CUSE to enable proper 
>>> userspace block devices.
>>
>> Likely slow due do lots of copying.  Also needs a snapshot API.
>
> The kernel could use splice.

Still can't make guest memory appear in (A)BUSE process memory without 
either mmu tricks (vmsplice in reverse) or a copy.  May be workable for 
an (A)BUSE driver that talks over a network, and thus can splice() its 
way out.

-- 
error compiling committee.c: too many arguments to function

