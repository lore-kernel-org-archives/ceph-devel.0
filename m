From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: Rbd map failure in 3.16.0-55
Date: Sat, 12 Dec 2015 12:12:24 +0100
Message-ID: <CAOi1vP9=szuwrgLjaqXa9Pq6CrwLhKu-J0D4_xCQQi_h_-VhYQ@mail.gmail.com>
References: <BLUPR0201MB1908E516F6CE6529654476ECE2EB0@BLUPR0201MB1908.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:38107 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751862AbbLLLMZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 12 Dec 2015 06:12:25 -0500
Received: by wmpp66 with SMTP id p66so4129916wmp.1
        for <ceph-devel@vger.kernel.org>; Sat, 12 Dec 2015 03:12:24 -0800 (PST)
In-Reply-To: <BLUPR0201MB1908E516F6CE6529654476ECE2EB0@BLUPR0201MB1908.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Varada Kari <Varada.Kari@sandisk.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sat, Dec 12, 2015 at 7:56 AM, Varada Kari <Varada.Kari@sandisk.com> wrote:
> Hi all,
>
> We are working on jewel branch on a test cluster to validate some of the fixes. But landed up in the following error when mapping an image using  krbd on Ubuntu 14.04.2 with 3.16.0-55 kernel version.
>
> $ sudo rbd map -p pool1 rbd1
> rbd: sysfs write failed
> rbd: map failed: (5) Input/output error
>
>
> $ uname -a
> Linux 3.16.0-55-generic #74~14.04.1-Ubuntu SMP Tue Nov 17 10:15:59 UTC 2015 x86_64 x86_64 x86_64 GNU/Linux
>
> $dmesg
> ....
> [11082.199006] libceph: read_partial_message bad hdr  crc 2112154322 != expected 0
> [11082.209414] libceph: mon0 x.x.x.x:6789 socket error on read
> [11092.238317] libceph: read_partial_message bad hdr  crc 2112154322 != expected 0
> [11092.248982] libceph: mon0 x.x.x.x:6789 socket error on read
> .....
>
> When I looked at the ceph_msg_header on 3.16 kernel (http://lxr.free-electrons.com/source/include/linux/ceph/msgr.h?v=3.16)
>
> There is one field change from jewel branch
>
> 145 struct ceph_msg_header {
> .......
> 159
> 160         /* oldest code we think can decode this.  unknown if zero. */
> 161         __le16 compat_version; <<< New one, which is present from 3.19 onwards
> 162         __le16 reserved;
> 163         __le32 crc;       /* header crc32c */
> 164 } __attribute__ ((packed));

That's not a problem - those 16 bits used to be reserved.

>
> How can map the image in 3.16 kernel apart from upgrading the kernel? Do we have any branch where I can build the modules with latest changes?

I'm guessing you have ms_crc_header set to false - the kernel client
always checks header (and middle) checksums, hence the mismatch.

Thanks,

                Ilya
