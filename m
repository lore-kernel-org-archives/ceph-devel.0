From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: Modifying RBD image changes it's snapshot
Date: Wed, 26 Jun 2013 11:15:34 -0700
Message-ID: <51CB2FC6.6070803@inktank.com>
References: <1805042.yIbHV06QAO@karol-esprimo-p5925>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:35374 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751383Ab3FZSQP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 26 Jun 2013 14:16:15 -0400
Received: by mail-pd0-f175.google.com with SMTP id 4so1600564pdd.34
        for <ceph-devel@vger.kernel.org>; Wed, 26 Jun 2013 11:16:15 -0700 (PDT)
In-Reply-To: <1805042.yIbHV06QAO@karol-esprimo-p5925>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Karol Jurak <karol.jurak@gmail.com>
Cc: ceph-devel@vger.kernel.org

On 06/26/2013 05:40 AM, Karol Jurak wrote:
> Hi,
>
> I'm using ceph 0.56.6 and kernel 3.9.7 and it looks like modifying RBD image
> also changes it's snapshot. I can reproduce this as follows:
>
> # create and map an image
> rbd create --size 128 test-1
> rbd map test-1
>
> # write some data to the image
> dd if=/dev/zero of=/dev/rbd/rbd/test-1 bs=1M count=128
>
> # create and map a snapshot
> rbd snap create test-1@snap-1
> rbd map test-1@snap-1
>
> # verify that image and snapshot are identical
> md5sum /dev/rbd/rbd/test-1 /dev/rbd/rbd/test-1@snap-1
> fde9e0818281836e4fc0edfede2b8762  /dev/rbd/rbd/test-1
> fde9e0818281836e4fc0edfede2b8762  /dev/rbd/rbd/test-1@snap-1
>
> # modify the image
> dd if=/dev/urandom of=/dev/rbd/rbd/test-1 bs=512 count=1
>
> # compare checksums again
> md5sum /dev/rbd/rbd/test-1 /dev/rbd/rbd/test-1@snap-1
> 1d942c8a5bc7480cecb945ea0d020eed  /dev/rbd/rbd/test-1
> 1d942c8a5bc7480cecb945ea0d020eed  /dev/rbd/rbd/test-1@snap-1
>
> Checksums are identical although the snapshot isn't supposed to be modified.
>

Just reproduced on 3.10-rc7 as well. It seems the snapshot context
loading is broken for format 1 a t least, since unmapping and mapping
after the snapshot exists still has the same problem. I added
http://tracker.ceph.com/issues/5464 to track this.

Apparently the regression test for this hasn't been running, or we
would've caught this sooner.

Josh

