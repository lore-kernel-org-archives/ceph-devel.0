From: Colin Patrick McCabe <colin.mccabe@dreamhost.com>
Subject: Re: fuse problem
Date: Thu, 19 May 2011 17:47:34 -0700
Message-ID: <BANLkTikSWLVJ7FE4Gsi-yh+APYohOMEXZA@mail.gmail.com>
References: <BANLkTimJGtnfQPa4LkgbfKx5HZ7drG9u5A@mail.gmail.com>
	<BANLkTikndSSH4aUJj9qVvEfwBvSuZteuYA@mail.gmail.com>
	<BANLkTimDUwOxZ-Z0kKuiBeE0uAHoaTNiQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64010 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753053Ab1ETArf convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 May 2011 20:47:35 -0400
Received: by fxm17 with SMTP id 17so2371698fxm.19
        for <ceph-devel@vger.kernel.org>; Thu, 19 May 2011 17:47:34 -0700 (PDT)
In-Reply-To: <BANLkTimDUwOxZ-Z0kKuiBeE0uAHoaTNiQA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: huang jun <hjwsm1989@gmail.com>
Cc: Brian Chrisman <brchrisman@gmail.com>, ceph-devel@vger.kernel.org

Hi Huang,

cfuse is a client, so it will use whatever the logging settings are for=
 clients.
you can set this by adding something like this to the [client] section
of your configuration file:

log_file =3D /my_log_file

You can also use this command-line switch to override the configuration=
:
--log-file=3D/my/log/file

cheers,
Colin


On Thu, May 19, 2011 at 4:52 PM, huang jun <hjwsm1989@gmail.com> wrote:
> hi,brian
> my 'ceph -s' shows everything is ok
> and if i do it =A0on the other machine, i did not find this error.
> i trun on the debug on ceph.conf like :
> =A0 [client]
> =A0 =A0 =A0 debug ms =3D 1
> =A0 =A0 =A0 debug client =3D 10
> but i can't find where does this info goes to ? =A0not in /var/log/ce=
ph/
> so where should i look for this debug output?
>
> thanks!
>
> 2011/5/19 Brian Chrisman <brchrisman@gmail.com>:
>> On Thu, May 19, 2011 at 4:12 AM, huang jun <hjwsm1989@gmail.com> wro=
te:
>>> hi, all
>>> i just encountered a problem about cfuse:
>>> i mount cfsue successfully on /mnt by using
>>> =A0 "cfuse -m 192.168.0.170:6789 /mnt"
>>> but when i enter /mnt directory, it shows that:
>>> =A0 [root@localhost mnt]# ll
>>> =A0 ls: .: Transport endpoint is not connected
>>
>> This is a FUSE failure message that generally occurs when your
>> userspace process (in this case cfuse) has exited (closed its
>> connection to the FUSE kernel driver).
>> does 'ceph -s' show that your ceph cluster is up and healthy?
>> You may want to turn on client debugging to see why cfuse is exiting=
:
>> http://ceph.newdream.net/wiki/Debugging
>>
>>
>>> my cfuse client is on centos5, it kernel version is 2.6.18
>>> and OSD cluster is on debian5, 2.6.35
>>> i don't know whether it related to SimpleMessenger,so anyone can gi=
ve
>>> me some prompts?
>>>
>>> thanks!
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
l
>>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
