From: huang jun <hjwsm1989@gmail.com>
Subject: Re: fuse problem
Date: Fri, 20 May 2011 10:31:34 +0800
Message-ID: <BANLkTi=3W+JtiqTQ2fbSFxBwBqJ5kevCyA@mail.gmail.com>
References: <BANLkTimJGtnfQPa4LkgbfKx5HZ7drG9u5A@mail.gmail.com>
	<BANLkTikndSSH4aUJj9qVvEfwBvSuZteuYA@mail.gmail.com>
	<BANLkTimDUwOxZ-Z0kKuiBeE0uAHoaTNiQA@mail.gmail.com>
	<BANLkTikSWLVJ7FE4Gsi-yh+APYohOMEXZA@mail.gmail.com>
	<BANLkTin8ayOJUWFyDv96y13Oj_rr+PCtdg@mail.gmail.com>
	<BANLkTik_5ch9P6AT3Uvb5bHT4fHKnLO0fA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:35793 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757078Ab1ETCbg convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 May 2011 22:31:36 -0400
Received: by wya21 with SMTP id 21so2411383wya.19
        for <ceph-devel@vger.kernel.org>; Thu, 19 May 2011 19:31:35 -0700 (PDT)
In-Reply-To: <BANLkTik_5ch9P6AT3Uvb5bHT4fHKnLO0fA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin Patrick McCabe <colin.mccabe@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

unfortunately, i tried all what you have told me, but no one
works.there still nothing
in /home/client_logfile:
     huangjun:/mnt# ll /home/client_logfile
     -rwxrwxrwx 1 root root 1 2011-05-19 20:57 /home/client_logfile
but i think this is not so seriously, i have a problem confused me a lo=
t.
i list what i have done
1) [root@localhost /]# cfuse  -o nonempty -m 192.168.0.11:6789 /mnt/
      ARNING: bsdocfs inode numbers are 64 bits wide, and FUSE on
32-bit kernels does
         not cope well with that situation.  Expect to crash shortly.

     cfuse[3771]: starting bsdocfs client
     2011-05-20 10:27:06.655823 b7fe16d0 thread 3086879632 start
     2011-05-20 10:27:06.656084 b7fe16d0 thread 3076389776 start
     2011-05-20 10:27:06.656229 b7fe16d0 thread 3065899920 start
     2011-05-20 10:27:06.656345 b7fe16d0 thread 3055410064 start
     2011-05-20 10:27:06.656508 b7fe16d0 thread 3044920208 start
     2011-05-20 10:27:06.656982 b7fe16d0 thread 3034430352 start
     2011-05-20 10:27:06.661384 b4ddbb90 thread 3033377680 start
     2011-05-20 10:27:06.663117 b7fe16d0 thread 3032325008 start
     2011-05-20 10:27:06.667000 b4bd9b90 thread 3031272336 start
     2011-05-20 10:27:06.870996 b4ad8b90 reader got ack seq 1 >=3D 1 on
0xa1a4d38      client_session(request_open) v1
     2011-05-20 10:27:07.285882 b4ad8b90 reader got ack seq 3 >=3D 2 on
0xa1a55c8 client_session(request_renewcaps seq 1) v1
     2011-05-20 10:27:07.286002 b4ad8b90 reader got ack seq 3 >=3D 3 on
0xa1a56f8  client_request(client5467:1 getattr pAsLsXsFs #1) v1
     cfuse[3771]: starting fuse
2) [root@localhost /]# df -TH
=46ilesystem    Type     Size   Used  Avail Use% Mounted on
/dev/mapper/VolGroup00-LogVol00
              ext3     305G   4.2G   285G   2% /
/dev/sda1     ext3     104M    19M    80M  20% /boot
tmpfs        tmpfs     2.1G      0   2.1G   0% /dev/shm
fuse          fuse      12T    38G    11T   1% /mnt
3) [root@localhost mnt]# cd /mnt &&  mkdir ss
mkdir: cannot create directory `ss': Transport endpoint is not connecte=
d

4) i ckeck the mon of osd clustrt state
   T02-MON11:~# ceph  -s
2011-05-20 10:18:16.120627    pg v3447: 3960 pgs: 3960 active+clean;
35200 MB data, 33363 MB used, 10212 GB / 10246 GB avail
2011-05-20 10:18:16.126746   mds e21: 1/1/1 up {0=3Dup:active}
2011-05-20 10:18:16.126772   osd e469: 14 osds: 14 up, 14 in
2011-05-20 10:18:16.126897   mon e1: 1 mons at {0=3D192.168.0.11:6789/0=
}

so where can i find the wrong point? i just can't do any operation in /=
mnt
thank you very much!

2011/5/20 Colin Patrick McCabe <colin.mccabe@dreamhost.com>:
> Usually you don't have the ability to create directories or files in
> /home unless you're root. Perhaps you should create
> /home/client_logfile and give it the right permissions?
>
> If that doesn't work, make sure you are editing the configuration tha=
t
> you are actually using. You can force cfuse to use the configuration
> you want with -c.
>
> regards,
> Colin
>
>
> On Thu, May 19, 2011 at 6:01 PM, huang jun <hjwsm1989@gmail.com> wrot=
e:
>> hi,colin
>> i try it as you said, but i can not see anything
>> =A0[client]
>> =A0 =A0 log_file =3D /home/client_logfile
>> =A0 =A0 debug ms =3D 1
>> =A0 =A0 debug client =3D 10
>> =A0 =A0 client cache size =3D 1024*1024*100
>> is there anything wrong with this setting?
>>
>> thanks!
>> 2011/5/20 Colin Patrick McCabe <colin.mccabe@dreamhost.com>:
>>> Hi Huang,
>>>
>>> cfuse is a client, so it will use whatever the logging settings are=
 for clients.
>>> you can set this by adding something like this to the [client] sect=
ion
>>> of your configuration file:
>>>
>>> log_file =3D /my_log_file
>>>
>>> You can also use this command-line switch to override the configura=
tion:
>>> --log-file=3D/my/log/file
>>>
>>> cheers,
>>> Colin
>>>
>>>
>>> On Thu, May 19, 2011 at 4:52 PM, huang jun <hjwsm1989@gmail.com> wr=
ote:
>>>> hi,brian
>>>> my 'ceph -s' shows everything is ok
>>>> and if i do it =A0on the other machine, i did not find this error.
>>>> i trun on the debug on ceph.conf like :
>>>> =A0 [client]
>>>> =A0 =A0 =A0 debug ms =3D 1
>>>> =A0 =A0 =A0 debug client =3D 10
>>>> but i can't find where does this info goes to ? =A0not in /var/log=
/ceph/
>>>> so where should i look for this debug output?
>>>>
>>>> thanks!
>>>>
>>>> 2011/5/19 Brian Chrisman <brchrisman@gmail.com>:
>>>>> On Thu, May 19, 2011 at 4:12 AM, huang jun <hjwsm1989@gmail.com> =
wrote:
>>>>>> hi, all
>>>>>> i just encountered a problem about cfuse:
>>>>>> i mount cfsue successfully on /mnt by using
>>>>>> =A0 "cfuse -m 192.168.0.170:6789 /mnt"
>>>>>> but when i enter /mnt directory, it shows that:
>>>>>> =A0 [root@localhost mnt]# ll
>>>>>> =A0 ls: .: Transport endpoint is not connected
>>>>>
>>>>> This is a FUSE failure message that generally occurs when your
>>>>> userspace process (in this case cfuse) has exited (closed its
>>>>> connection to the FUSE kernel driver).
>>>>> does 'ceph -s' show that your ceph cluster is up and healthy?
>>>>> You may want to turn on client debugging to see why cfuse is exit=
ing:
>>>>> http://ceph.newdream.net/wiki/Debugging
>>>>>
>>>>>
>>>>>> my cfuse client is on centos5, it kernel version is 2.6.18
>>>>>> and OSD cluster is on debian5, 2.6.35
>>>>>> i don't know whether it related to SimpleMessenger,so anyone can=
 give
>>>>>> me some prompts?
>>>>>>
>>>>>> thanks!
>>>>>> --
>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-d=
evel" in
>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.=
html
>>>>>>
>>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.ht=
ml
>>>>
>>>
>>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
