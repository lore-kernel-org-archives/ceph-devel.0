From: biyan chen <riby.chen@gmail.com>
Subject: Re: ceph authenticate problem
Date: Tue, 24 May 2011 11:25:54 +0800
Message-ID: <BANLkTikq=nY0-CbGgEk_qSgmBVWMkCfNOw@mail.gmail.com>
References: <BANLkTinpu+Gq4CeXzpbZ-V8t8UzOH2trhQ@mail.gmail.com>
	<20110523155631.GA7495@dreamer>
	<BANLkTimzNEbURVnjHFN_NmoBu_tJDi4aFA@mail.gmail.com>
	<BANLkTinsrPxZrwbe9rEYpLOKtAvKaOfRGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:61585 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753893Ab1EXDZz convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 May 2011 23:25:55 -0400
Received: by gxk21 with SMTP id 21so2474277gxk.19
        for <ceph-devel@vger.kernel.org>; Mon, 23 May 2011 20:25:55 -0700 (PDT)
In-Reply-To: <BANLkTinsrPxZrwbe9rEYpLOKtAvKaOfRGg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: huang jun <hjwsm1989@gmail.com>
Cc: Tommi Virtanen <tommi.virtanen@dreamhost.com>, ceph-devel@vger.kernel.org

Thank Yehuda ,Tommi Virtanen  huang jun

 (/use instead of /usr) Is my careless

Repair remains after error!

I try'ed

"cp /data/mon0/admin_keyring.bin /usr/local/etc/ceph/keyring.bin"

But ceph_mon0 server did not find /data/mon0/admin_keyring.bin


[root@ceph_mon0 mon0]# ll
total 60
drwxr-xr-x. 2 root root 4096 May 24 11:18 auth
drwxr-xr-x. 2 root root 4096 May 24 11:18 class
-rw-r--r--. 1 root root   75 May 24 11:18 feature_set
-rw-------. 1 root root    0 May 24 11:18 lock
-rw-r--r--. 1 root root  160 May 24 11:18 log
-rw-r--r--. 1 root root  160 May 24 11:18 log.debug
-rw-r--r--. 1 root root   55 May 24 11:18 log.err
-rw-r--r--. 1 root root  160 May 24 11:18 log.info
drwxr-xr-x. 2 root root 4096 May 24 11:18 logm
-rw-r--r--. 1 root root   55 May 24 11:18 log.warn
-rw-r--r--. 1 root root   21 May 24 11:18 magic
drwxr-xr-x. 2 root root 4096 May 24 11:18 mdsmap
drwxr-xr-x. 2 root root 4096 May 24 11:18 monmap
drwxr-xr-x. 2 root root 4096 May 24 11:18 osdmap
drwxr-xr-x. 2 root root 4096 May 24 11:18 osdmap_full
drwxr-xr-x. 2 root root 4096 May 24 11:18 pgmap
[root@ceph_mon0 mon0]#


=D4=DA 2011=C4=EA5=D4=C224=C8=D5 =C9=CF=CE=E710:30=A3=AChuang jun <hjws=
m1989@gmail.com> =D0=B4=B5=C0=A3=BA
> try "cp /data/mon0/admin_keyring.bin /usr/local/etc/ceph/keyring.bin"
>
> =D4=DA 2011=C4=EA5=D4=C224=C8=D5 =C9=CF=CE=E79:50=A3=ACbiyan chen <ri=
by.chen@gmail.com> =D0=B4=B5=C0=A3=BA
>> My steps =A3=BA
>> mkcephfs -c /usr/local/etc/ceph/ceph.conf --allhosts --mkbtrfs -k
>> /usr/local/etc/ceph/keyring.bin
>> /etc/init.d/ceph -a start
>>
>> Can give me a little more information?
>>
>>
>> 2011/5/23 Tommi Virtanen <tommi.virtanen@dreamhost.com>:
>>> On Mon, May 23, 2011 at 03:48:41PM +0800, biyan chen wrote:
>>>>         keyring =3D /use/local/etc/ceph/keyring.bin
>>>
>>> This might be your problem..
>>>
>>> --
>>> :(){ :|:&};:
>>>
>>
>>
>>
>> --
>> name:Riby
>> mobile:+86 15280267642
>> company: =B0=D9=B4=F3=C1=FA=D2=BB
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
