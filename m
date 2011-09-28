From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: ping_pong test of ceph
Date: Wed, 28 Sep 2011 08:51:31 -0700
Message-ID: <CAF3hT9BEhwGVeiud0fDmBscB2KKc1uAJxvAEGQZ2KAW6pWOhTg@mail.gmail.com>
References: <CAMwsgzPBzcwnJTkhDPAanQemwUirHe-yTHVHE4hMpjc4sgVkKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:36851 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753210Ab1I1Pvc convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 28 Sep 2011 11:51:32 -0400
Received: by iaqq3 with SMTP id q3so7011327iaq.19
        for <ceph-devel@vger.kernel.org>; Wed, 28 Sep 2011 08:51:32 -0700 (PDT)
In-Reply-To: <CAMwsgzPBzcwnJTkhDPAanQemwUirHe-yTHVHE4hMpjc4sgVkKw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: mowang da <whooya.xxl@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Wed, Sep 28, 2011 at 12:33 AM, mowang da <whooya.xxl@gmail.com> wrot=
e:
> hi all:
>
> l used ping_pong tool to test ceph, as shown below :
> 1.If it supports coherent byte range locks between cluster nodes
> 2.How fast it handles lock contention
> 3.If it supports coherent read/write IO between nodes
> 4.How fast it handles contended IO between nodes
> 5.If it supports coherent mmap between nodes
> 6.How fast the mmap coherence works
>
> the ping_pong code is here:
> http://junkcode.samba.org/ftp/unpacked/junkcode/ping_pong.c
>
> l start by running ping_pong on just one of the kernel client mount
> point like this:
>
> ping_pong /mnt/test.dat 3
>
> it lock very fast :
>
> T02-OSD161:/usr/src/ping_pong# ./ping_pong /mnt/test.dat 3
> =A0 =A01664 locks/sec
>
> but when l start a second copy of ping_pong on another kernel client
> node in my cluster, there have been some errors:
>
> T02-OSD186:/usr/src/getosd# ./ping_pong /mnt/test.dat 3
> lock at 0 failed! - Interrupted system call
> lock at 0 failed! - Interrupted system call
> lock at 0 failed! - Interrupted system call
> lock at 2 failed! - Interrupted system call
> lock at 1 failed! - Interrupted system call
> lock at 2 failed! - Interrupted system call
>
> ls this a bug of ceph ,or l do something wrong?
Well, I think locking code generically should be able to handle an EINT=
R return?
But in this case, you are hitting a Ceph bug. It's fixed in the next
and master branches and will be in the next release. :)
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
