From: huang jun <hjwsm1989@gmail.com>
Subject: Re: fuse problem
Date: Fri, 20 May 2011 07:52:10 +0800
Message-ID: <BANLkTimDUwOxZ-Z0kKuiBeE0uAHoaTNiQA@mail.gmail.com>
References: <BANLkTimJGtnfQPa4LkgbfKx5HZ7drG9u5A@mail.gmail.com>
	<BANLkTikndSSH4aUJj9qVvEfwBvSuZteuYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:39499 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934202Ab1ESXwN convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 May 2011 19:52:13 -0400
Received: by wya21 with SMTP id 21so2358895wya.19
        for <ceph-devel@vger.kernel.org>; Thu, 19 May 2011 16:52:11 -0700 (PDT)
In-Reply-To: <BANLkTikndSSH4aUJj9qVvEfwBvSuZteuYA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brian Chrisman <brchrisman@gmail.com>
Cc: ceph-devel@vger.kernel.org

hi,brian
my 'ceph -s' shows everything is ok
and if i do it  on the other machine, i did not find this error.
i trun on the debug on ceph.conf like :
   [client]
       debug ms =3D 1
       debug client =3D 10
but i can't find where does this info goes to ?  not in /var/log/ceph/
so where should i look for this debug output?

thanks!

2011/5/19 Brian Chrisman <brchrisman@gmail.com>:
> On Thu, May 19, 2011 at 4:12 AM, huang jun <hjwsm1989@gmail.com> wrot=
e:
>> hi, all
>> i just encountered a problem about cfuse:
>> i mount cfsue successfully on /mnt by using
>> =A0 "cfuse -m 192.168.0.170:6789 /mnt"
>> but when i enter /mnt directory, it shows that:
>> =A0 [root@localhost mnt]# ll
>> =A0 ls: .: Transport endpoint is not connected
>
> This is a FUSE failure message that generally occurs when your
> userspace process (in this case cfuse) has exited (closed its
> connection to the FUSE kernel driver).
> does 'ceph -s' show that your ceph cluster is up and healthy?
> You may want to turn on client debugging to see why cfuse is exiting:
> http://ceph.newdream.net/wiki/Debugging
>
>
>> my cfuse client is on centos5, it kernel version is 2.6.18
>> and OSD cluster is on debian5, 2.6.35
>> i don't know whether it related to SimpleMessenger,so anyone can giv=
e
>> me some prompts?
>>
>> thanks!
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
