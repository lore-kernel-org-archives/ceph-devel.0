From: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>
Subject: Re: Empty directory size greater than zero and can't remove
Date: Wed, 19 Dec 2012 15:13:01 +1300
Message-ID: <50D122AD.4070609@catalyst.net.nz>
References: <CAJiejCRi8QOfQB5Y0rN5vQz-xiTeA1SKdku=8Xa_+3CZAjysLA@mail.gmail.com> <CAJiejCQWQK2RKvMJ-08WW+3Y+23oaghFYTWQ+u7-37grF+Liug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:36869 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754186Ab2LSCTt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 18 Dec 2012 21:19:49 -0500
In-Reply-To: <CAJiejCQWQK2RKvMJ-08WW+3Y+23oaghFYTWQ+u7-37grF+Liug@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Drunkard Zhang <gongfan193@gmail.com>
Cc: maillist-linux <ceph-devel@vger.kernel.org>

On 19/12/12 14:44, Drunkard Zhang wrote:
> 2012/12/16 Drunkard Zhang <gongfan193@gmail.com>:
>> I couldn't rm files in ceph, which was backuped files of one osd. It
>> reports direcory not empty, but there's nothing under that directory=
,
>> just the directory itself held some spaces. How could I shoot down t=
he
>> problem ?
>>
>> log30 /mnt/bc # ls -aR osd.28/
>> osd.28/:
>> .  ..  osd.28
>>
>> osd.28/osd.28:
>> .  ..  current
>>
>> osd.28/osd.28/current:
>> .  ..  0.537_head
>>
>> osd.28/osd.28/current/0.537_head:
>> .  ..
>> log30 /mnt/bc # ls -lhd osd.28/osd.28/current/0.537_head
>> drwxr-xr-x 1 root root 119M Dec 14 19:22 osd.28/osd.28/current/0.537=
_head
>> log30 /mnt/bc #
>> log30 /mnt/bc # rm -rf osd.28/
>> rm: cannot remove =E2=80=98osd.28/osd.28/current/0.537_head=E2=80=99=
: Directory not empty
>> log30 /mnt/bc # rm -rf osd.28/osd.28/current/0.537_head
>> rm: cannot remove =E2=80=98osd.28/osd.28/current/0.537_head=E2=80=99=
: Directory not empty
>>
>> The cluster seems health:
>> log3 ~ # ceph -s
>>     health HEALTH_OK
>>     monmap e1: 3 mons at
>> {log21=3D10.205.118.21:6789/0,log3=3D10.205.119.2:6789/0,squid86-log=
12=3D150.164.100.218:6789/0},
>> election epoch 640, quorum 0,1,2 log21,log3,squid86-log12
>>     osdmap e1864: 45 osds: 45 up, 45 in
>>      pgmap v163907: 9224 pgs: 9224 active+clean; 3168 GB data, 9565 =
GB
>> used, 111 TB / 120 TB avail
>>     mdsmap e134: 1/1/1 up {0=3Dlog14=3Dup:active}, 1 up:standby
>>
> After mds restart, I got this error message:
> 2012-12-19 09:16:24.837045 mds.0 [ERR] unmatched fragstat size on
> single dirfrag 100000006c7, inode has f(v6 m2012-11-24 23:18:34.94726=
6
> 1773=3D1773+0), dirfrag has f(v6 m2012-12-17 12:43:52.203358
> 2038=3D2038+0)
>
> How can I fix this?
>

Is it a btrfs filesystem? If so will have sub volumes hiding in there=20
you need to remove 1st.

Cheers

Mark
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
