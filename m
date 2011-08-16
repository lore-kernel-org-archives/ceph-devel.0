From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: Logging to syslog from clients
Date: Mon, 15 Aug 2011 21:10:32 -0700
Message-ID: <CA+qbEUPB_XQ352aL1FaH=LkacJzqa9iHJuFc1ppFyDofRYFNpQ@mail.gmail.com>
References: <201108160231.53287.szekelyi@niif.hu>
	<CA+qbEUNRwy6c7kDG4rY0mxB1pGKuHJOj5sLacXcWhCgJo+uYPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:50158 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750902Ab1HPEKe convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Aug 2011 00:10:34 -0400
Received: by fxh19 with SMTP id 19so3967076fxh.19
        for <ceph-devel@vger.kernel.org>; Mon, 15 Aug 2011 21:10:33 -0700 (PDT)
In-Reply-To: <CA+qbEUNRwy6c7kDG4rY0mxB1pGKuHJOj5sLacXcWhCgJo+uYPw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?Sz=E9kelyi_Szabolcs?= <szekelyi@niif.hu>
Cc: ceph-devel@vger.kernel.org

2011/8/15 Colin McCabe <cmccabe@alumni.cmu.edu>:
> 2011/8/15 Sz=E9kelyi Szabolcs <szekelyi@niif.hu>:
>> Hi all,
>>
>> I'm running a Ceph cluster with a number of read-only ramdisk based =
clients
>> mounting the filesystem. I'd like to get the logs of the client out =
via syslog.
>> I've seen some posts dealing with logging to syslog, namely the thre=
ad
>> starting at http://www.spinics.net/lists/ceph-devel/msg02876.html . =
I see
>> options like "log to syslog" and "clog to syslog". It's not clear wh=
at they
>> mean, could someone tell me the difference?
>
> "clog" is the center logger, which is a separate subsystem from the
> regular logger. The central log is maintained by the monitors rather
> than being a per-daemon thing like the regular log.
>
>>
>> Anyway, currently my logging settings on the client are
>>
>> [global]
>> log file =3D
>> log dir =3D
>> log to syslog =3D true
>> clog to syslog =3D true
>>
>> But when the filesystem is mounted with the FUSE client, I still get
>>
>> failed to open log file '/var/log/ceph/client.admin.log': error 2: N=
o such file
>> or directory
>>
>> which is surprising. I thought that the above options should have di=
sabled
>> logging to file, but it looks like it still tries to open it. Is thi=
s a bug, or
>> me doing something wrong?
>
> This looks like an actual bug :(
> I'm testing out a fix that will allow users to turn off log files for
> daemons again.

This should be fixed in master by
8072bdcaa4445359051fed443be3d702f20807e0

This should fix it for you.

cheers,
Colin


>
> On an unrelated note: when you log to syslog, you may need to turn
> down the logging a little bit. Syslog tends to drop log messages when
> the load gets heavy, and this makes it harder to figure out what is
> going on.
>
> regards,
> Colin
>
>
>
>>
>> Thanks,
>> --
>> cc
>>
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
