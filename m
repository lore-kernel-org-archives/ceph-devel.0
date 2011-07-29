From: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <szibis@gmail.com>
Subject: Re: Two questions
Date: Fri, 29 Jul 2011 17:00:53 +0200
Message-ID: <-3666367855446280970@unknownmsgid>
References: <8685614628192678277@unknownmsgid> <1311750865.2751.4.camel@wido-laptop.pcextreme.nl>
 <CAMwB3Ti66BpfdfwPx3XgmVQv2GAQ_Gc2beHRc6pBcWwphf_bhQ@mail.gmail.com>
 <1311763628.2751.34.camel@wido-laptop.pcextreme.nl> <CAMwB3Tgyo1ug7tUUkHJAyoct_T6O=pZY1P78_z5FJiO2D10M7g@mail.gmail.com>
 <CAF3hT9BbWvztQE=Mn3NW5OQ9ktHAe0AoW6m0aC9WqfyY1b7jBQ@mail.gmail.com>
 <-4123305127044475997@unknownmsgid> <CAMwB3TgHx1f_dWWGbDg4uEJyFEZc5vNgPsKVYELaK_X5nKez=Q@mail.gmail.com>
 <CAF3hT9C0BBD+qs4JKxisA=1XQh-juhGrgHX7GgjZQWGmyyY08g@mail.gmail.com>
Mime-Version: 1.0 (iPhone Mail 8G4)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:57836 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751384Ab1G2PCN convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Jul 2011 11:02:13 -0400
Received: by fxh19 with SMTP id 19so2364922fxh.19
        for <ceph-devel@vger.kernel.org>; Fri, 29 Jul 2011 08:02:12 -0700 (PDT)
In-Reply-To: <CAF3hT9C0BBD+qs4JKxisA=1XQh-juhGrgHX7GgjZQWGmyyY08g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Yes i have made a test, and now everything is ok. Thanks for help.

iSS

Dnia 28 lip 2011 o godz. 18:36 Gregory Farnum
<gregory.farnum@dreamhost.com> napisa=C5=82(a):

> 2011/7/28 S=C5=82awomir Skowron <szibis@gmail.com>:
>> Because of my test before i mount ext4 filesystems in /data/osd.(osd
>> id), but /data was a symlink to /var/data/ and i think total used
>> space was higher by a size of var, and there are logs, lots of logs
>> :). Ceph produce many logs in such verbosity. Tell me if im wrong.
>>
>> Now its look like this, and it's looks better :)
>>
>> 2011-07-28 11:44:08.227278    pg v110939: 6986 pgs: 8 active, 6978
>> active+clean; 42441 MB data, 223 GB used, 29457 GB / 31240 GB avail
>>
>> rados df
>> pool name                 KB      objects       clones     degraded
>>  unfound           rd        rd KB           wr        wr KB
>> .log                  694273            6            0            0
>>       0            0            0      3539909      3539909
>> .pool                      1            1            0            0
>>       0            0            0            8            8
>> .rgw                       0            6            0            0
>>       0            0            0            1            0
>> .users                     1            1            0            0
>>       0            0            0            1            1
>> .users.email               1            1            0            0
>>       0            0            0            1            1
>> .users.uid                 2            2            0            0
>>       0            1            0            2            2
>> data                       0            0            0            0
>>       0            0            0            0            0
>> metadata                   0            0            0            0
>>       0            0            0            0            0
>> rbd                        0            0            0            0
>>       0            0            0            0            0
>> sstest              42766318      3483690            0            0
>>       0            0            0     20922736     42892546
>>  total used       234415408      3483707
>>  total avail    30888365376
>>  total space    32757780072
>
> Okay, so now you've got (42766318+694273)*3KB=3D124GB of data, and 22=
3GB
> used. I guess your OSD journals are 512MB each, so that's another
> 16GB, which still leaves more unexplained space usage than I would
> expect.
> But it's probably just some peculiarity of how your system is set up;
> you could check and see how the numbers change when you add new
> objects to the system to make sure it's just a base case rather than
> something to worry about. :)
> -Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
