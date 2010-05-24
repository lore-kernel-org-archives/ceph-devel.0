From: Avi Kivity <avi@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 1/1] ceph/rbd block driver for qemu-kvm
Date: Mon, 24 May 2010 14:05:58 +0300
Message-ID: <4BFA5D96.3030603@redhat.com>
References: <20100519192222.GD61706@ncolin.muc.de>	<AANLkTimXqk7oa4mtcoHX1rKWzi_Nccb0FJu_QDtwJ-sP@mail.gmail.com>	<AANLkTil-aogxdnMallKTDo1bKXj6QmaU0ojJuiZgXaqC@mail.gmail.com>	<4BF5A9D2.5080609@codemonkey.ws>	<4BF91937.2070801@redhat.com> <87wrutg4dk.wl%morita.kazutaka@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55936 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754919Ab0EXLGY (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 24 May 2010 07:06:24 -0400
In-Reply-To: <87wrutg4dk.wl%morita.kazutaka@lab.ntt.co.jp>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: MORITA Kazutaka <morita.kazutaka@lab.ntt.co.jp>
Cc: Anthony Liguori <anthony@codemonkey.ws>, Christian Brunner <chb@muc.de>, Blue Swirl <blauwirbel@gmail.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org, ceph-devel@vger.kernel.org

On 05/24/2010 10:12 AM, MORITA Kazutaka wrote:
> At Sun, 23 May 2010 15:01:59 +0300,
> Avi Kivity wrote:
>    
>> On 05/21/2010 12:29 AM, Anthony Liguori wrote:
>>      
>>> I'd be more interested in enabling people to build these types of
>>> storage systems without touching qemu.
>>>
>>> Both sheepdog and ceph ultimately transmit I/O over a socket to a
>>> central daemon, right?
>>>        
>> That incurs an extra copy.
>>
>>      
>>> So could we not standardize a protocol for this that both sheepdog and
>>> ceph could implement?
>>>        
>> The protocol already exists, nbd.  It doesn't support snapshotting etc.
>> but we could extend it.
>>
>>      
> I have no objection to use another protocol for Sheepdog support, but
> I think nbd protocol is unsuitable for the large storage pool with
> many VM images.  It is because nbd protocol doesn't support specifing
> a file name to open.  If we use nbd with such a storage system, the
> server needs to listen ports as many as the number of VM images.  As
> far as I see the protocol, It looks difficult to extend it without
> breaking backward compatibility.
>    

The server would be local and talk over a unix domain socket, perhaps 
anonymous.

nbd has other issues though, such as requiring a copy and no support for 
metadata operations such as snapshot and file size extension.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

