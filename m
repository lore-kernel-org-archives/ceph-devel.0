From: Avi Kivity <avi@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 1/1] ceph/rbd block driver for qemu-kvm
Date: Mon, 24 May 2010 14:56:29 +0300
Message-ID: <4BFA696D.2060606@redhat.com>
References: <20100519192222.GD61706@ncolin.muc.de>	<AANLkTimXqk7oa4mtcoHX1rKWzi_Nccb0FJu_QDtwJ-sP@mail.gmail.com>	<AANLkTil-aogxdnMallKTDo1bKXj6QmaU0ojJuiZgXaqC@mail.gmail.com>	<4BF5A9D2.5080609@codemonkey.ws>	<4BF91937.2070801@redhat.com>	<87wrutg4dk.wl%morita.kazutaka@lab.ntt.co.jp>	<4BFA5D96.3030603@redhat.com> <lpvdad4jcf.wl%morita.kazutaka@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60947 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756017Ab0EXL4s (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 24 May 2010 07:56:48 -0400
In-Reply-To: <lpvdad4jcf.wl%morita.kazutaka@lab.ntt.co.jp>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: MORITA Kazutaka <morita.kazutaka@lab.ntt.co.jp>
Cc: Anthony Liguori <anthony@codemonkey.ws>, Christian Brunner <chb@muc.de>, Blue Swirl <blauwirbel@gmail.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org, ceph-devel@vger.kernel.org

On 05/24/2010 02:42 PM, MORITA Kazutaka wrote:
>
>> The server would be local and talk over a unix domain socket, perhaps
>> anonymous.
>>
>> nbd has other issues though, such as requiring a copy and no support for
>> metadata operations such as snapshot and file size extension.
>>
>>      
> Sorry, my explanation was unclear.  I'm not sure how running servers
> on localhost can solve the problem.
>    

The local server can convert from the local (nbd) protocol to the remote 
(sheepdog, ceph) protocol.

> What I wanted to say was that we cannot specify the image of VM. With
> nbd protocol, command line arguments are as follows:
>
>   $ qemu nbd:hostname:port
>
> As this syntax shows, with nbd protocol the client cannot pass the VM
> image name to the server.
>    

We would extend it to allow it to connect to a unix domain socket:

   qemu nbd:unix:/path/to/socket

The server at the other end would associate the socket with a filename 
and forward it to the server using the remote protocol.

However, I don't think nbd would be a good protocol.  My preference 
would be for a plugin API, or for a new local protocol that uses 
splice() to avoid copies.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

