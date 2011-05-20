From: huang jun <hjwsm1989@gmail.com>
Subject: Re: fuse problem
Date: Fri, 20 May 2011 11:13:36 +0800
Message-ID: <BANLkTim7jLQgxwsBoDSJuVaWEZBR2uA_sA@mail.gmail.com>
References: <BANLkTimJGtnfQPa4LkgbfKx5HZ7drG9u5A@mail.gmail.com>
	<BANLkTikndSSH4aUJj9qVvEfwBvSuZteuYA@mail.gmail.com>
	<BANLkTimDUwOxZ-Z0kKuiBeE0uAHoaTNiQA@mail.gmail.com>
	<BANLkTikSWLVJ7FE4Gsi-yh+APYohOMEXZA@mail.gmail.com>
	<BANLkTin8ayOJUWFyDv96y13Oj_rr+PCtdg@mail.gmail.com>
	<BANLkTik_5ch9P6AT3Uvb5bHT4fHKnLO0fA@mail.gmail.com>
	<BANLkTi=3W+JtiqTQ2fbSFxBwBqJ5kevCyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:63831 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932096Ab1ETDNh convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 May 2011 23:13:37 -0400
Received: by wwa36 with SMTP id 36so3544972wwa.1
        for <ceph-devel@vger.kernel.org>; Thu, 19 May 2011 20:13:36 -0700 (PDT)
In-Reply-To: <BANLkTi=3W+JtiqTQ2fbSFxBwBqJ5kevCyA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin Patrick McCabe <colin.mccabe@dreamhost.com>
Cc: ceph-devel@vger.kernel.org, brchrisman@gmail.com

thanks,all
i find the problem, as Brian Chrisman said,the cfuse process exited,so
i need to find why it exits.
the output of debug below:
2011-05-20 11:09:06.531980 b7ff56d0 thread 3086961552 start
2011-05-20 11:09:06.532043 b7ff56d0 thread 3076471696 start
2011-05-20 11:09:06.532061 b7ff56d0 thread 3065981840 start
2011-05-20 11:09:06.532081 b7ff56d0 thread 3055491984 start
2011-05-20 11:09:06.532100 b7ff56d0 thread 3045002128 start
2011-05-20 11:09:06.532319 b7ff56d0 thread 3034512272 start
2011-05-20 11:09:06.533669 b4defb90 thread 3033459600 start
2011-05-20 11:09:06.535570 b7ff56d0 thread 3032406928 start
2011-05-20 11:09:06.536743 b4bedb90 thread 3031354256 start
2011-05-20 11:09:06.541680 b4aecb90 reader got ack seq 1 >=3D 1 on
0x8276cf0 client_session(request_
open) v1
2011-05-20 11:09:06.542535 b4aecb90 reader got ack seq 2 >=3D 2 on
0x8277918 client_session(request_
renewcaps seq 1) v1
2011-05-20 11:09:06.543546 b4aecb90 reader got ack seq 3 >=3D 3 on
0x8277a48 client_request(client41
03:1 getattr pAsLsXsFs #1) v1
2011-05-20 11:09:07.536841 b4aecb90 reader got ack seq 4 >=3D 4 on
0x8276cf0 client_session(request_
renewcaps seq 2) v1
2011-05-20 11:09:20.722233 b4aecb90 reader got ack seq 5 >=3D 5 on
0x8279c08 client_request(client41
03:2 readdir #1) v1
client/Client.cc: In function 'Inode* Client::_ll_get_inode(vinodeno_t)=
':
client/Client.cc:5497: FAILED assert(inode_map.count(vino))
 1: /usr/bin/cfuse [0x80badbf]
 2: (Client::ll_getattr(vinodeno_t, stat*, int, int)+0xce) [0x80e2b1e]
 3: /usr/bin/cfuse [0x80b8867]
 4: /lib/libfuse.so.2 [0xfcb402]
 5: /lib/libfuse.so.2 [0xfcbead]
 6: (fuse_session_process()+0x26) [0xfcd9a6]
 7: (fuse_session_loop()+0x95) [0xfc9925]
 8: (ceph_fuse_ll_main(Client*, int, char const**, int)+0x175) [0x80b6e=
b5]
 9: (main()+0x2d4) [0x8095f24]
 10: (__libc_start_main()+0xdc) [0x68ce9c]
 11: (__gxx_personality_v0()+0x3e9) [0x8095b21]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is
needed to interpret this.
*** Caught signal (Aborted) ***
in thread b7ff56d0

 1: /usr/bin/cfuse [0x81e28a7]
 2: [0x5cb420]
 3: [0x5cb410]
 4: (gsignal()+0x50) [0x69fdf0]
 5: (abort()+0x101) [0x6a1701]
 6: (__gnu_cxx::__verbose_terminate_handler()+0x150) [0x929b50]
 7: /usr/lib/libstdc++.so.6 [0x927555]
 8: /usr/lib/libstdc++.so.6 [0x927592]
 9: /usr/lib/libstdc++.so.6 [0x9276ca]
 a: (ceph::__ceph_assert_fail(char const*, char const*, int, char
const*)+0x264) [0x81ce944]
 b: /usr/bin/cfuse [0x80badbf]
 c: (Client::ll_getattr(vinodeno_t, stat*, int, int)+0xce) [0x80e2b1e]
 d: /usr/bin/cfuse [0x80b8867]
 e: /lib/libfuse.so.2 [0xfcb402]
 f: /lib/libfuse.so.2 [0xfcbead]
 10: (fuse_session_process()+0x26) [0xfcd9a6]
 11: (fuse_session_loop()+0x95) [0xfc9925]
 12: (ceph_fuse_ll_main(Client*, int, char const**, int)+0x175) [0x80b6=
eb5]
 13: (main()+0x2d4) [0x8095f24]
 14: (__libc_start_main()+0xdc) [0x68ce9c]
 15: (__gxx_personality_v0()+0x3e9) [0x8095b21]
(END)

does can be fixed? i'm use cfuse client on centos 5.5
thanks!

2011/5/20 huang jun <hjwsm1989@gmail.com>:
> unfortunately, i tried all what you have told me, but no one
> works.there still nothing
> in /home/client_logfile:
> =A0 =A0 huangjun:/mnt# ll /home/client_logfile
> =A0 =A0 -rwxrwxrwx 1 root root 1 2011-05-19 20:57 /home/client_logfil=
e
> but i think this is not so seriously, i have a problem confused me a =
lot.
> i list what i have done
> 1) [root@localhost /]# cfuse =A0-o nonempty -m 192.168.0.11:6789 /mnt=
/
> =A0 =A0 =A0ARNING: bsdocfs inode numbers are 64 bits wide, and FUSE o=
n
> 32-bit kernels does
> =A0 =A0 =A0 =A0 not cope well with that situation. =A0Expect to crash=
 shortly.
>
> =A0 =A0 cfuse[3771]: starting bsdocfs client
> =A0 =A0 2011-05-20 10:27:06.655823 b7fe16d0 thread 3086879632 start
> =A0 =A0 2011-05-20 10:27:06.656084 b7fe16d0 thread 3076389776 start
> =A0 =A0 2011-05-20 10:27:06.656229 b7fe16d0 thread 3065899920 start
> =A0 =A0 2011-05-20 10:27:06.656345 b7fe16d0 thread 3055410064 start
> =A0 =A0 2011-05-20 10:27:06.656508 b7fe16d0 thread 3044920208 start
> =A0 =A0 2011-05-20 10:27:06.656982 b7fe16d0 thread 3034430352 start
> =A0 =A0 2011-05-20 10:27:06.661384 b4ddbb90 thread 3033377680 start
> =A0 =A0 2011-05-20 10:27:06.663117 b7fe16d0 thread 3032325008 start
> =A0 =A0 2011-05-20 10:27:06.667000 b4bd9b90 thread 3031272336 start
> =A0 =A0 2011-05-20 10:27:06.870996 b4ad8b90 reader got ack seq 1 >=3D=
 1 on
> 0xa1a4d38 =A0 =A0 =A0client_session(request_open) v1
> =A0 =A0 2011-05-20 10:27:07.285882 b4ad8b90 reader got ack seq 3 >=3D=
 2 on
> 0xa1a55c8 client_session(request_renewcaps seq 1) v1
> =A0 =A0 2011-05-20 10:27:07.286002 b4ad8b90 reader got ack seq 3 >=3D=
 3 on
> 0xa1a56f8 =A0client_request(client5467:1 getattr pAsLsXsFs #1) v1
> =A0 =A0 cfuse[3771]: starting fuse
> 2) [root@localhost /]# df -TH
> Filesystem =A0 =A0Type =A0 =A0 Size =A0 Used =A0Avail Use% Mounted on
> /dev/mapper/VolGroup00-LogVol00
> =A0 =A0 =A0 =A0 =A0 =A0 =A0ext3 =A0 =A0 305G =A0 4.2G =A0 285G =A0 2%=
 /
> /dev/sda1 =A0 =A0 ext3 =A0 =A0 104M =A0 =A019M =A0 =A080M =A020% /boo=
t
> tmpfs =A0 =A0 =A0 =A0tmpfs =A0 =A0 2.1G =A0 =A0 =A00 =A0 2.1G =A0 0% =
/dev/shm
> fuse =A0 =A0 =A0 =A0 =A0fuse =A0 =A0 =A012T =A0 =A038G =A0 =A011T =A0=
 1% /mnt
> 3) [root@localhost mnt]# cd /mnt && =A0mkdir ss
> mkdir: cannot create directory `ss': Transport endpoint is not connec=
ted
>
> 4) i ckeck the mon of osd clustrt state
> =A0 T02-MON11:~# ceph =A0-s
> 2011-05-20 10:18:16.120627 =A0 =A0pg v3447: 3960 pgs: 3960 active+cle=
an;
> 35200 MB data, 33363 MB used, 10212 GB / 10246 GB avail
> 2011-05-20 10:18:16.126746 =A0 mds e21: 1/1/1 up {0=3Dup:active}
> 2011-05-20 10:18:16.126772 =A0 osd e469: 14 osds: 14 up, 14 in
> 2011-05-20 10:18:16.126897 =A0 mon e1: 1 mons at {0=3D192.168.0.11:67=
89/0}
>
> so where can i find the wrong point? i just can't do any operation in=
 /mnt
> thank you very much!
>
> 2011/5/20 Colin Patrick McCabe <colin.mccabe@dreamhost.com>:
>> Usually you don't have the ability to create directories or files in
>> /home unless you're root. Perhaps you should create
>> /home/client_logfile and give it the right permissions?
>>
>> If that doesn't work, make sure you are editing the configuration th=
at
>> you are actually using. You can force cfuse to use the configuration
>> you want with -c.
>>
>> regards,
>> Colin
>>
>>
>> On Thu, May 19, 2011 at 6:01 PM, huang jun <hjwsm1989@gmail.com> wro=
te:
>>> hi,colin
>>> i try it as you said, but i can not see anything
>>> =A0[client]
>>> =A0 =A0 log_file =3D /home/client_logfile
>>> =A0 =A0 debug ms =3D 1
>>> =A0 =A0 debug client =3D 10
>>> =A0 =A0 client cache size =3D 1024*1024*100
>>> is there anything wrong with this setting?
>>>
>>> thanks!
>>> 2011/5/20 Colin Patrick McCabe <colin.mccabe@dreamhost.com>:
>>>> Hi Huang,
>>>>
>>>> cfuse is a client, so it will use whatever the logging settings ar=
e for clients.
>>>> you can set this by adding something like this to the [client] sec=
tion
>>>> of your configuration file:
>>>>
>>>> log_file =3D /my_log_file
>>>>
>>>> You can also use this command-line switch to override the configur=
ation:
>>>> --log-file=3D/my/log/file
>>>>
>>>> cheers,
>>>> Colin
>>>>
>>>>
>>>> On Thu, May 19, 2011 at 4:52 PM, huang jun <hjwsm1989@gmail.com> w=
rote:
>>>>> hi,brian
>>>>> my 'ceph -s' shows everything is ok
>>>>> and if i do it =A0on the other machine, i did not find this error=
=2E
>>>>> i trun on the debug on ceph.conf like :
>>>>> =A0 [client]
>>>>> =A0 =A0 =A0 debug ms =3D 1
>>>>> =A0 =A0 =A0 debug client =3D 10
>>>>> but i can't find where does this info goes to ? =A0not in /var/lo=
g/ceph/
>>>>> so where should i look for this debug output?
>>>>>
>>>>> thanks!
>>>>>
>>>>> 2011/5/19 Brian Chrisman <brchrisman@gmail.com>:
>>>>>> On Thu, May 19, 2011 at 4:12 AM, huang jun <hjwsm1989@gmail.com>=
 wrote:
>>>>>>> hi, all
>>>>>>> i just encountered a problem about cfuse:
>>>>>>> i mount cfsue successfully on /mnt by using
>>>>>>> =A0 "cfuse -m 192.168.0.170:6789 /mnt"
>>>>>>> but when i enter /mnt directory, it shows that:
>>>>>>> =A0 [root@localhost mnt]# ll
>>>>>>> =A0 ls: .: Transport endpoint is not connected
>>>>>>
>>>>>> This is a FUSE failure message that generally occurs when your
>>>>>> userspace process (in this case cfuse) has exited (closed its
>>>>>> connection to the FUSE kernel driver).
>>>>>> does 'ceph -s' show that your ceph cluster is up and healthy?
>>>>>> You may want to turn on client debugging to see why cfuse is exi=
ting:
>>>>>> http://ceph.newdream.net/wiki/Debugging
>>>>>>
>>>>>>
>>>>>>> my cfuse client is on centos5, it kernel version is 2.6.18
>>>>>>> and OSD cluster is on debian5, 2.6.35
>>>>>>> i don't know whether it related to SimpleMessenger,so anyone ca=
n give
>>>>>>> me some prompts?
>>>>>>>
>>>>>>> thanks!
>>>>>>> --
>>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-=
devel" in
>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>> More majordomo info at =A0http://vger.kernel.org/majordomo-info=
=2Ehtml
>>>>>>>
>>>>>>
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-de=
vel" in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.h=
tml
>>>>>
>>>>
>>>
>>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
