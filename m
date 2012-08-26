From: Wido den Hollander <wido@widodh.nl>
Subject: Re: About sparse images
Date: Sun, 26 Aug 2012 21:53:34 +0200
Message-ID: <503A7EBE.1060500@widodh.nl>
References: <CAOLwVUnGz4ZvWdNo6JKHuS06YZYCeT7WjaDdGiDipRv8UZVLhA@mail.gmail.com> <649A15670E764B2E9397EDA1919205C7@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:46332 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751636Ab2HZTx2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 26 Aug 2012 15:53:28 -0400
In-Reply-To: <649A15670E764B2E9397EDA1919205C7@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: =?UTF-8?B?U8OpYmFzdGllbiBIYW4=?= <han.sebastien@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>



On 08/26/2012 09:42 PM, Gregory Farnum wrote:
> On Sunday, August 26, 2012 at 11:11 AM, S=C3=A9bastien Han wrote:
>> Hi all!
>>
>> I know that ceph images (rbd) are sparse. It's good but I have some
>> interrogations about the ceph -s (-w) output. Let's say your create =
a
>> 10G image, map it, format it and mount it. Finally you filled up the
>> entire space available. You notice that the 'data' and 'used' space
>> had grown. Now delete the content of your image but **not** this
>> image, not now. You notice that nothing changed from the ceph output=
,
>> it's not surprising because of the sparse capability. At this point =
of
>> time the output from the command ceph is neither right nor wrong. It
>> only shows the space used by the sparse image, but it doesn't mean
>> that you have 'real' data in it, just a simple object allocation. It=
's
>> not so relevant, the only solution is to remove the image (obviously=
).
>> My feeling is that we should be careful about the ceph's output, it'=
s
>> not a good indicator for 'real' data. Ok Ceph won't replace a
>> monitoring system but I'll be happy to trust the ceph output at 100%
>> :)
>
> The output of ceph -s is intended to describe the amount of space all=
ocated by RADOS across the OSDs. As far as any part of the Ceph project=
 knows, the objects in those RBD images are real data and can't be remo=
ved.
> If you're interested in removing them, subsets of the RBD clients do =
support TRIM operations, which will remove the objects themselves. Josh=
 or somebody will have to speak about which clients, though.
> -Greg
>

As far as I know TRIM / Discard only works with KVM and SCSI disks,=20
VirtIO still seems to lack this functionality, not sure about kernel RB=
D.

On the filesystem side, ext4 with the "discard" mount option does this.

But it's important (like Greg already said) to note that RBD/RADOS can'=
t=20
know which object is still important and which isn't. When you unlink a=
=20
file the filesystem doesn't zero that particular block, it just clears=20
all references to it so the freed up space can be used again.

Wido

> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
