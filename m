From: Gregory Farnum <greg@inktank.com>
Subject: Re: Writes to mounted Ceph FS fail silently if client has no write
 capability on data pool
Date: Thu, 5 Jul 2012 13:01:59 -0700
Message-ID: <CAPYLRzhay0Jr9dV5WCR_s07c58Q5aGQ0dWCkTDeL6_oWCb_tRg@mail.gmail.com>
References: <CAPUexz-2R40ZRyEhQeEuq29fzgENDkHk=O+xXF=7jiG7ZP0Xuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:39642 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751383Ab2GEUCB convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Jul 2012 16:02:01 -0400
Received: by lbbgm6 with SMTP id gm6so13378853lbb.19
        for <ceph-devel@vger.kernel.org>; Thu, 05 Jul 2012 13:01:59 -0700 (PDT)
In-Reply-To: <CAPUexz-2R40ZRyEhQeEuq29fzgENDkHk=O+xXF=7jiG7ZP0Xuw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Florian Haas <florian@hastexo.com>
Cc: ceph-devel@vger.kernel.org

On Thu, Jul 5, 2012 at 10:40 AM, Florian Haas <florian@hastexo.com> wro=
te:
> Hi everyone,
>
> please enlighten me if I'm misinterpreting something, but I think the
> Ceph FS layer could handle the following situation better.
>
> How to reproduce (this is on a 3.2.0 kernel):
>
> 1. Create a client, mine is named "test", with the following capabili=
ties:
>
> client.test
> =A0 =A0 =A0 =A0 key: <key>
> =A0 =A0 =A0 =A0 caps: [mds] allow
> =A0 =A0 =A0 =A0 caps: [mon] allow r
> =A0 =A0 =A0 =A0 caps: [osd] allow rw pool=3Dtestpool
>
> Note the client only has access to a single pool, "testpool".
>
> 2. Export the client's secret and mount a Ceph FS.
>
> mount -t ceph -o name=3Dtest,secretfile=3D/etc/ceph/test.secret
> daisy,eric,frank:/ /mnt
>
> This succeeds, despite us not even having read access to the "data" p=
ool.
>
> 3. Write something to a file.
>
> root@alice:/mnt# echo "hello world" > hello.txt
> root@alice:/mnt# cat hello.txt
>
> This too succeeds.
>
> 4. Sync and clear caches.
>
> root@alice:/mnt# sync
> root@alice:/mnt# echo 3 > /proc/sys/vm/drop_caches
>
> 5. Check file size and contents.
>
> root@alice:/mnt# ls -la
> total 5
> drwxr-xr-x =A01 root root =A0 =A00 Jul =A05 17:15 .
> drwxr-xr-x 21 root root 4096 Jun 11 09:03 ..
> -rw-r--r-- =A01 root root =A0 12 Jul =A05 17:15 hello.txt
> root@alice:/mnt# cat hello.txt
> root@alice:/mnt#
>
> Note the reported file size in unchanged, but the file is empty.
>
> Checking the "data" pool with client.admin credentials obviously show=
s
> that that pool is empty, so objects are never written. Interestingly,
> "cephfs hello.txt show_location" does list an object_name, identifyin=
g
> an object which doesn't exist.
>
> Is there any way to make the client fail with -EIO, -EPERM,
> -EOPNOTSUPP or whatever else is appropriate, rather than pretending t=
o
> write when it can't?

There definitely are, but I don't think we're going to fix that until
we get to working seriously on the filesystem. Create a bug! ;)

> Also, going down the rabbit hole, how would this behavior change if I
> used cephfs to set the default layout on some directory to use a
> different pool?

I'm not sure what you're asking here =97=A0if you have access to the
metadata server, you can change the pool that new files go into, and I
think you can set the pool to be whatever you like (and we should
probably harden all this, too). So you can fix it if it's a problem,
but you can also turn it into a problem.
Is that what you were after?
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
