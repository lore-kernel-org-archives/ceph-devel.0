From: Avi Kivity <avi@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 1/1] ceph/rbd block driver for qemu-kvm
Date: Tue, 25 May 2010 12:19:05 +0300
Message-ID: <4BFB9609.1070002@redhat.com>
References: <20100519192222.GD61706@ncolin.muc.de>	<AANLkTimXqk7oa4mtcoHX1rKWzi_Nccb0FJu_QDtwJ-sP@mail.gmail.com>	<AANLkTil-aogxdnMallKTDo1bKXj6QmaU0ojJuiZgXaqC@mail.gmail.com>	<4BF5A9D2.5080609@codemonkey.ws>	<4BF91937.2070801@redhat.com>	<87wrutg4dk.wl%morita.kazutaka@lab.ntt.co.jp>	<4BFA5D96.3030603@redhat.com> <lpvdad4jcf.wl%morita.kazutaka@lab.ntt.co.jp> <4BFA696D.2060606@redhat.com> <4BFAD090.3000203@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:21023 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932169Ab0EYJTT (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 25 May 2010 05:19:19 -0400
In-Reply-To: <4BFAD090.3000203@codemonkey.ws>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: MORITA Kazutaka <morita.kazutaka@lab.ntt.co.jp>, Christian Brunner <chb@muc.de>, Blue Swirl <blauwirbel@gmail.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org, ceph-devel@vger.kernel.org

On 05/24/2010 10:16 PM, Anthony Liguori wrote:
> On 05/24/2010 06:56 AM, Avi Kivity wrote:
>> On 05/24/2010 02:42 PM, MORITA Kazutaka wrote:
>>>
>>>> The server would be local and talk over a unix domain socket, perhaps
>>>> anonymous.
>>>>
>>>> nbd has other issues though, such as requiring a copy and no 
>>>> support for
>>>> metadata operations such as snapshot and file size extension.
>>>>
>>> Sorry, my explanation was unclear.  I'm not sure how running servers
>>> on localhost can solve the problem.
>>
>> The local server can convert from the local (nbd) protocol to the 
>> remote (sheepdog, ceph) protocol.
>>
>>> What I wanted to say was that we cannot specify the image of VM. With
>>> nbd protocol, command line arguments are as follows:
>>>
>>>   $ qemu nbd:hostname:port
>>>
>>> As this syntax shows, with nbd protocol the client cannot pass the VM
>>> image name to the server.
>>
>> We would extend it to allow it to connect to a unix domain socket:
>>
>>   qemu nbd:unix:/path/to/socket
>
> nbd is a no-go because it only supports a single, synchronous I/O 
> operation at a time and has no mechanism for extensibility.
>
> If we go this route, I think two options are worth considering.  The 
> first would be a purely socket based approach where we just accepted 
> the extra copy.
>
> The other potential approach would be shared memory based.  We export 
> all guest ram as shared memory along with a small bounce buffer pool.  
> We would then use a ring queue (potentially even using virtio-blk) and 
> an eventfd for notification.

We can't actually export guest memory unless we allocate it as a shared 
memory object, which has many disadvantages.  The only way to export 
anonymous memory now is vmsplice(), which is fairly limited.


>
>> The server at the other end would associate the socket with a 
>> filename and forward it to the server using the remote protocol.
>>
>> However, I don't think nbd would be a good protocol.  My preference 
>> would be for a plugin API, or for a new local protocol that uses 
>> splice() to avoid copies.
>
> I think a good shared memory implementation would be preferable to 
> plugins.  I think it's worth attempting to do a plugin interface for 
> the block layer but I strongly suspect it would not be sufficient.
>
> I would not want to see plugins that interacted with BlockDriverState 
> directly, for instance.  We change it far too often.  Our main loop 
> functions are also not terribly stable so I'm not sure how we would 
> handle that (unless we forced all block plugins to be in a separate 
> thread).

If we manage to make a good long-term stable plugin API, it would be a 
good candidate for the block layer itself.

Some OSes manage to have a stable block driver ABI, so it should be 
possible, if difficult.

-- 
error compiling committee.c: too many arguments to function

