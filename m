From: Gregory Farnum <greg@gregs42.com>
Subject: Re: Slow file creating and deleting using bonnie ++ on Hammer
Date: Wed, 20 May 2015 11:22:19 -0700
Message-ID: <CAC6JEv9ZjK6nn0tK7HpQWMkMcYhn=Kbg77_+J1NxKTq0WWfJOQ@mail.gmail.com>
References: <CAMzumdYUsO2jh8Xk1bpQLrOR7NiLcR5FzL15ve9=jiQ9Bz64wQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:37990 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751818AbbETSWV convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 May 2015 14:22:21 -0400
Received: by igcau1 with SMTP id au1so46514685igc.1
        for <ceph-devel@vger.kernel.org>; Wed, 20 May 2015 11:22:20 -0700 (PDT)
Received: from mail-ie0-f181.google.com (mail-ie0-f181.google.com. [209.85.223.181])
        by mx.google.com with ESMTPSA id a74sm12892434ioe.36.2015.05.20.11.22.19
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 May 2015 11:22:20 -0700 (PDT)
Received: by iebgx4 with SMTP id gx4so45736316ieb.0
        for <ceph-devel@vger.kernel.org>; Wed, 20 May 2015 11:22:19 -0700 (PDT)
In-Reply-To: <CAMzumdYUsO2jh8Xk1bpQLrOR7NiLcR5FzL15ve9=jiQ9Bz64wQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Barclay Jameson <almightybeeij@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, May 20, 2015 at 11:15 AM, Barclay Jameson
<almightybeeij@gmail.com> wrote:
> I am trying to find out why boniee++ is choking at the creating files
> sequentially and deleting sequentially on cephfs.
> I enabled mds debug for about 30 seconds and I find a bunch of lines
> like the following:
>
> 2015-05-19 15:54:12.930829 7f6de4ecf700  1 -- 192.168.40.3:6800/46175=
6
> --> 192.168.40.100:0/1741116310 -- client_caps(grant ino 10000004ca9
> 19656 seq 2 caps=3DpAsxLsXsxFsxcrwb dirty=3D- wanted=3DpAsxXsxFxwb fo=
llows 0
> size 0/4194304 ts 1 mtime 2015-05-19 15:54:09.098825) v5 -- ?+0
> 0x557a800 con 0x4fdeca0
>
> Is this statement showing that it takes 4 seconds to create an inode?

I'm not sure where you're getting that from just this line =E2=80=94 ar=
e you
comparing mtime and the log timestamp?
This particular message is just a message going to the client about
what access capabilities (caps) it has on that inode.

>
> Watching ( watch --interval=3D.2 -d 'ceph df') ceph df, rados df, and
> ceph osd pool stats seems to show that an object is being created or
> deleted about every 4 seconds.

A 4 second file create sounds much slower than it should be. What does
your cluster look like? Can you upload the output of ceph -s and your
MDS log somewhere?
-Greg

>
> The test is now running for over 24 hours with the following bonnie++=
 comand:
>
> ~/bonnie++-1.03e/bonnie++ -u root:root -s 256g -r 131072 -d /cephfs/
> -m CephBench -f -b
>
> I can give more log output if needed.
>
> OSD + MON/MDS
> CentOS 7
> ceph version 0.94.1 (e4bfad3a3c51054df7e537a724c8d0bf9be972ff)
> kernel version : 3.10.0-229.el7.x86_64
>
> Client
> CentOS 6
> ceph version 0.94.1 (e4bfad3a3c51054df7e537a724c8d0bf9be972ff)
> kernel version : 4.0.0-1.el6.elrepo.x86_64
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
