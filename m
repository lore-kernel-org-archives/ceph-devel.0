From: Travis Rhoden <trhoden@gmail.com>
Subject: Re: what is the syntax to use to specify xfs in ceph.conf
Date: Tue, 22 Jan 2013 15:01:56 -0500
Message-ID: <CACkq2mqVQYgyFBmT2UjwEcNcHB88qPZhnZO6-_AjW21oLRgkWw@mail.gmail.com>
References: <1358882205.98747.YahooMailNeo@web121906.mail.ne1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f45.google.com ([74.125.83.45]:48064 "EHLO
	mail-ee0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753366Ab3AVUCS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Jan 2013 15:02:18 -0500
Received: by mail-ee0-f45.google.com with SMTP id b57so3562933eek.4
        for <ceph-devel@vger.kernel.org>; Tue, 22 Jan 2013 12:02:17 -0800 (PST)
In-Reply-To: <1358882205.98747.YahooMailNeo@web121906.mail.ne1.yahoo.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Isaac Otsiabah <zmoo76b@yahoo.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

If using mkcephfs, you can just give it a "devs" option.

I"m pretty sure this changed in bobtail (0.56).  I just setup a
cluster on 0.56.1, and used the following.  Worked like a charm:

[osd]
        osd mkfs type = xfs
        osd mkfs options xfs = "-f"
        osd mount options xfs = "rw,noatime,inode64,logbufs=8,logbsize=256k"
[osd.0]
        host = ceph1
        devs = /dev/sdc
        osd journal = /dev/sda5

[osd.1]
        host = ceph1
        devs = /dev/sdd
        osd journal = /dev/sda6


A generic example is in the docs, here:
http://ceph.com/docs/master/rados/configuration/ceph-conf/#example-ceph-conf

Remember to use --mkfs when using mkcephfs.

HTH.

 - Travis

On Tue, Jan 22, 2013 at 2:16 PM, Isaac Otsiabah <zmoo76b@yahoo.com> wrote:
>
>
> When my ceph data drives use btrfs as the underneath fileystem, the devices in my ceph.conf contain the lines "btrfs devs = /dev/sdx" as shown below.
>
>
> ceph.conf
> =======
> .......
> .......
> .......
> ......
>
> [osd.0]
>         host = host1
>         public address = 10.5.0.123
>         cluster address = 10.5.1.123
>         btrfs devs = /dev/sde
>
> [osd.1]
>         host = host2
>         public address = 10.5.0.123
>         cluster address = 10.5.1.123
>         btrfs devs = /dev/sdf
>
> .......
> .......
> ......
>
>
> Now, i want to use xfs as the underneath filesystem so in the ceph.conf file, should the lines "btrfs devs = /dev/sdx" be changed to "xfs devs = /dev/sdx" ?
>
> Isaac
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
