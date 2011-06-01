From: biyan chen <riby.chen@gmail.com>
Subject: Re: File only read, can't write, problem
Date: Wed, 1 Jun 2011 14:34:39 +0800
Message-ID: <BANLkTi=8-u4Rn0LBdvQa_+bFpzkedCNZ=w@mail.gmail.com>
References: <BANLkTi=2KDBCNxyrr9Nnhx=FBH0yrPY7XQ@mail.gmail.com>
	<BANLkTinzTcnxHAFUeTe2KTbdjMSRuQdJhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:34998 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753390Ab1FAGek convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Jun 2011 02:34:40 -0400
Received: by gyd10 with SMTP id 10so2084668gyd.19
        for <ceph-devel@vger.kernel.org>; Tue, 31 May 2011 23:34:40 -0700 (PDT)
In-Reply-To: <BANLkTinzTcnxHAFUeTe2KTbdjMSRuQdJhw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregf@hq.newdream.net>
Cc: ceph-devel@vger.kernel.org

I have mount on ceph file system, but, after entering directory cannot
read documents.


[root@ceph_client 1]# df
=46ilesystem           1K-blocks      Used Available Use% Mounted on
/dev/sda1            472658192  20199408 428449108   5% /
tmpfs                  1984548         0   1984548   0% /dev/shm
/dev/loop0             3351190   3351190         0 100% /mnt/cdrom
192.168.0.211:6789:/ 158047232     81920 155843584   1% /1
[root@ceph_client 1]# echo "1">>1.txt
-bash: 1.txt: Permission denied
[root@ceph_client 1]# ll
total 0
[root@ceph_client 1]# cd /
[root@ceph_client /]# ll
total 112
drwxr-xr-x.   1 root root     0 Jun  1 20:05 1


I to execute the command :
mount -o remount, rw /1

Still hint without permission


2011/5/27 Gregory Farnum <gregf@hq.newdream.net>:
> I'm not quite sure what you're saying here -- can you give a more
> precise description of the problem?
>
> On Tue, May 24, 2011 at 12:44 AM, biyan chen <riby.chen@gmail.com> wr=
ote:
>> mkcephfs -c /usr/local/etc/ceph/ceph.conf --allhosts --mkbtrfs -k
>> /usr/local/etc/ceph/keyring.bin
>> /etc/init.d/ceph -a start
>>
>> Startup ceph
>>
>>
>>
>> mount -t ceph 192.168.0.211:6789:/ /1 -vv
>>
>> This command  File only read, can't write!!
>>
>> cfuse -m  ceph_mon0:6789 /1 -c /usr/local/etc/ceph/ceph.conf
>> Can read could write
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>



--=20
name:Riby
mobile:+86 15280267642
company: =B0=D9=B4=F3=C1=FA=D2=BB
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
