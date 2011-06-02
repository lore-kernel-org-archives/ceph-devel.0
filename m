From: biyan chen <riby.chen@gmail.com>
Subject: Re: File only read, can't write, problem
Date: Thu, 2 Jun 2011 11:47:46 +0800
Message-ID: <BANLkTimYt9wUQYWkOoUcdj3tCvuZaEN6Sg@mail.gmail.com>
References: <BANLkTi=2KDBCNxyrr9Nnhx=FBH0yrPY7XQ@mail.gmail.com>
	<BANLkTinzTcnxHAFUeTe2KTbdjMSRuQdJhw@mail.gmail.com>
	<BANLkTi=8-u4Rn0LBdvQa_+bFpzkedCNZ=w@mail.gmail.com>
	<BANLkTi=H4H3EJ0=NjAr43eyYyVNu-U35sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:59071 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754452Ab1FBDrr convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Jun 2011 23:47:47 -0400
Received: by gxk21 with SMTP id 21so199339gxk.19
        for <ceph-devel@vger.kernel.org>; Wed, 01 Jun 2011 20:47:46 -0700 (PDT)
In-Reply-To: <BANLkTi=H4H3EJ0=NjAr43eyYyVNu-U35sg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregf@hq.newdream.net>
Cc: ceph-devel@vger.kernel.org

Thanks;


[root@ceph_client /]# df
=46ilesystem           1K-blocks      Used Available Use% Mounted on
/dev/sda1            472658192  20200436 428448080   5% /
tmpfs                  1984548         0   1984548   0% /dev/shm
/dev/loop0             3351190   3351190         0 100% /mnt/cdrom
192.168.0.211:6789:/ 158047232    315392 155611136   1% /1
[root@ceph_client /]# umount /1
[root@ceph_client /]# mount -t ceph 192.168.0.211:6789:/ /1 -vv -o
name=3Dadmin,secret=3DAQCfY+ZN+FrTGhAAFBefW2HD598ijL+C3OKhUw=3D=3D
192.168.0.211:6789:/ on /1 type ceph
(rw,name=3Dadmin,secret=3DAQCfY+ZN+FrTGhAAFBefW2HD598ijL+C3OKhUw=3D=3D)
[root@ceph_client /]# df
=46ilesystem           1K-blocks      Used Available Use% Mounted on
/dev/sda1            472658192  20200436 428448080   5% /
tmpfs                  1984548         0   1984548   0% /dev/shm
/dev/loop0             3351190   3351190         0 100% /mnt/cdrom
192.168.0.211:6789:/ 158047232    315392 155611136   1% /1
[root@ceph_client /]# cd /1
[root@ceph_client 1]# ls -al
total 9
drwxr-xr-x.  1 root root   48 Jun  2 00:08 .
dr-xr-xr-x. 28 root root 4096 Jun  1 23:49 ..
-rw-r--r--.  1 root root   48 Jun  2 00:09 1.txt
[root@ceph_client 1]# echo "1">>1.txt
[root@ceph_client 1]# echo "1">>2.txt
-bash: 2.txt: Permission denied
[root@ceph_client 1]#


1. TXT I cfuse mount up through after created files =A3=A1



=D4=DA 2011=C4=EA6=D4=C22=C8=D5 =C9=CF=CE=E712:22=A3=ACGregory Farnum <=
gregf@hq.newdream.net> =D0=B4=B5=C0=A3=BA
> Can you ls -la on the mounted directory and send us the output? FUSE
> can be funny with permissions and usually they're set to root on
> mount, but yours might be set to a special FUSE user or something...
> (in which case you just need to chmod the mountpoint)
> -Greg
>
> 2011/5/31 biyan chen <riby.chen@gmail.com>:
>> I have mount on ceph file system, but, after entering directory cann=
ot
>> read documents.
>>
>>
>> [root@ceph_client 1]# df
>> Filesystem           1K-blocks      Used Available Use% Mounted on
>> /dev/sda1            472658192  20199408 428449108   5% /
>> tmpfs                  1984548         0   1984548   0% /dev/shm
>> /dev/loop0             3351190   3351190         0 100% /mnt/cdrom
>> 192.168.0.211:6789:/ 158047232     81920 155843584   1% /1
>> [root@ceph_client 1]# echo "1">>1.txt
>> -bash: 1.txt: Permission denied
>> [root@ceph_client 1]# ll
>> total 0
>> [root@ceph_client 1]# cd /
>> [root@ceph_client /]# ll
>> total 112
>> drwxr-xr-x.   1 root root     0 Jun  1 20:05 1
>>
>>
>> I to execute the command :
>> mount -o remount, rw /1
>>
>> Still hint without permission
>>
>>
>> 2011/5/27 Gregory Farnum <gregf@hq.newdream.net>:
>>> I'm not quite sure what you're saying here -- can you give a more
>>> precise description of the problem?
>>>
>>> On Tue, May 24, 2011 at 12:44 AM, biyan chen <riby.chen@gmail.com> =
wrote:
>>>> mkcephfs -c /usr/local/etc/ceph/ceph.conf --allhosts --mkbtrfs -k
>>>> /usr/local/etc/ceph/keyring.bin
>>>> /etc/init.d/ceph -a start
>>>>
>>>> Startup ceph
>>>>
>>>>
>>>>
>>>> mount -t ceph 192.168.0.211:6789:/ /1 -vv
>>>>
>>>> This command  File only read, can't write!!
>>>>
>>>> cfuse -m  ceph_mon0:6789 /1 -c /usr/local/etc/ceph/ceph.conf
>>>> Can read could write
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>>
>>
>>
>>
>> --
>> name:Riby
>> mobile:+86 15280267642
>> company: =B0=D9=B4=F3=C1=FA=D2=BB
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
