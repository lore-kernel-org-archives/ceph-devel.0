From: Yonggang Liu <myidpt@gmail.com>
Subject: Re: ceph-client-standalone bug update ,make,WARNING: "task_dirty_inc"
 ,ubuntu10.10 Linux-2.6.35-22-generic
Date: Thu, 28 Oct 2010 12:54:21 -0400
Message-ID: <AANLkTik5J8KAAnV67U4gkgEC9E8_C+z8ivaz2vB8Hg-4@mail.gmail.com>
References: <AANLkTikqKtEC4pQP0-DKgyz+VD_14iRFL6JtSY7Y=3Nb@mail.gmail.com>
	<Pine.LNX.4.64.1010081159120.7262@cobra.newdream.net>
	<AANLkTininb3-EF1__WjB9CA4w2uPxW=wUFODg=L6U2X5@mail.gmail.com>
	<Pine.LNX.4.64.1010102108410.25037@cobra.newdream.net>
	<1288259734.2621.23.camel@osd1>
	<AANLkTikwQG6EWdr_kqmCGHR0iBnsQFWXZ8V+r7Vy+EjM@mail.gmail.com>
	<AANLkTinS72oaJK4GLkFC675PkV40EsFjCeJPRuLwJ_7J@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:54256 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758675Ab0J1QyW convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Oct 2010 12:54:22 -0400
Received: by ewy7 with SMTP id 7so1673643ewy.19
        for <ceph-devel@vger.kernel.org>; Thu, 28 Oct 2010 09:54:21 -0700 (PDT)
In-Reply-To: <AANLkTinS72oaJK4GLkFC675PkV40EsFjCeJPRuLwJ_7J@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregf@hq.newdream.net>, ceph-devel@vger.kernel.org

Solved. Thank you Gregory!
I used the branck rbd-backport and it works perfectly.

Regards,

On Thu, Oct 28, 2010 at 11:55 AM, Gregory Farnum <gregf@hq.newdream.net=
> wrote:
> The ceph-client tree is always maintained against the latest rc from
> Linus. For any other kernel you need to use the -backports branches.
> It looks like this is what's causing both your troubles. :)
> -Greg
>
> On Thu, Oct 28, 2010 at 8:20 AM, Yonggang Liu <myidpt@gmail.com> wrot=
e:
>> The same thing happens here, I was using Debian 5.0 with kernel 2.6.=
32-5-686.
>> I had the following error message:
>> client:~/ceph-client-standalone# insmod ceph.ko
>> insmod: error inserting 'ceph.ko': -1 Unknown symbol in module
>> client:~/ceph-client-standalone# dmesg -c
>> [ 4295.877555] ceph: Unknown symbol task_dirty_inc
>>
>> Any ideas?
>>
>> On Thu, Oct 28, 2010 at 5:55 AM, Jeff Wu <cpwu@tnsoft.com.cn> wrote:
>>> Hi ,all
>>>
>>> At Ubuntu 10.10 x86_64 , kernel : Linux-2.6.35-22-generic ,
>>>
>>> I git Lastest ceph-client-standalone source codes from
>>> git://ceph.newdream.net/ceph-client-standalone.git
>>>
>>> it make fail, get the warning messages: "account_page_dirtied"
>>>
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Logs =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>
>>> jeff@cephserver:~/work/ceph-client-standalone$ make
>>>
>>> =A0...................................
>>>
>>> CC [M] =A0/home/jeff/work/ceph-client-standalone/ceph_hash.o
>>> =A0CC [M] =A0/home/jeff/work/ceph-client-standalone/ceph_frag.o
>>> =A0LD [M] =A0/home/jeff/work/ceph-client-standalone/ceph.o
>>> =A0Building modules, stage 2.
>>> =A0MODPOST 1 modules
>>> WARNING:
>>> "account_page_dirtied" [/home/jeff/work/ceph-client-standalone/ceph=
=2Eko]
>>> undefined!
>>> =A0CC =A0 =A0 =A0/home/jeff/work/ceph-client-standalone/ceph.mod.o
>>> =A0LD [M] =A0/home/jeff/work/ceph-client-standalone/ceph.ko
>>> make[1]: Leaving directory `/usr/src/linux-headers-2.6.35-22-generi=
c'
>>> jeff@cephserver:~/work/ceph-client-standalone$
>>>
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>>>
>>> then =A0i change to master-backport, to make it ,
>>> still get a warning messages : "task_dirty_inc" .
>>>
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dlogs=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>>>
>>> jeff@cephserver:~/work/ceph-client-standalone$ git checkout -b
>>> master-backport origin/master-backport
>>> Branch master-backport set up to track remote branch master-backpor=
t
>>> from origin.
>>> Switched to a new branch 'master-backport'
>>> jeff@cephserver:~/work/ceph-client-standalone$ git pull
>>> Already up-to-date.
>>>
>>> jeff@cephserver:~/work/ceph-client-standalone$ make
>>>
>>> .........................................
>>>
>>> =A0CC [M] =A0/home/jeff/work/ceph-client-standalone/osdmap.o
>>> =A0CC [M] =A0/home/jeff/work/ceph-client-standalone/debugfs.o
>>> =A0CC [M] =A0/home/jeff/work/ceph-client-standalone/auth.o
>>> =A0LD [M] =A0/home/jeff/work/ceph-client-standalone/ceph.o
>>> =A0Building modules, stage 2.
>>> =A0MODPOST 1 modules
>>> WARNING:
>>> "task_dirty_inc" [/home/jeff/work/ceph-client-standalone/ceph.ko]
>>> undefined!
>>> =A0CC =A0 =A0 =A0/home/jeff/work/ceph-client-standalone/ceph.mod.o
>>> =A0LD [M] =A0/home/jeff/work/ceph-client-standalone/ceph.ko
>>> make[1]: Leaving directory `/usr/src/linux-headers-2.6.35-22-generi=
c'
>>> jeff@cephserver:~/work/ceph-client-standalone$
>>>
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>
>>> Is it a bug ? or i git wrong source package ?
>>>
>>> Thanks,
>>> Jeff,Wu
>>>
>>>
>>>
>>>
>>>
>>>
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
l
>>>
>>
>>
>>
>> --
>> Yonggang Liu
>> Advanced Computing and Information Systems Laboratory
>> University of Florida
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>



--=20
Yonggang Liu
Advanced Computing and Information Systems Laboratory
University of Florida
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
