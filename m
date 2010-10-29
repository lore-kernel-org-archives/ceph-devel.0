From: Yonggang Liu <myidpt@gmail.com>
Subject: Re: ceph-client-standalone bug update ,make,WARNING: "task_dirty_inc"
 ,ubuntu10.10 Linux-2.6.35-22-generic
Date: Fri, 29 Oct 2010 13:44:06 -0400
Message-ID: <AANLkTin9s4ce_RCNx93DX6Wok3ZQ=rdxP5M8dPi7zQ=4@mail.gmail.com>
References: <AANLkTikqKtEC4pQP0-DKgyz+VD_14iRFL6JtSY7Y=3Nb@mail.gmail.com>
	<Pine.LNX.4.64.1010081159120.7262@cobra.newdream.net>
	<AANLkTininb3-EF1__WjB9CA4w2uPxW=wUFODg=L6U2X5@mail.gmail.com>
	<Pine.LNX.4.64.1010102108410.25037@cobra.newdream.net>
	<1288259734.2621.23.camel@osd1>
	<AANLkTikwQG6EWdr_kqmCGHR0iBnsQFWXZ8V+r7Vy+EjM@mail.gmail.com>
	<AANLkTinS72oaJK4GLkFC675PkV40EsFjCeJPRuLwJ_7J@mail.gmail.com>
	<AANLkTik5J8KAAnV67U4gkgEC9E8_C+z8ivaz2vB8Hg-4@mail.gmail.com>
	<1288318077.2332.3.camel@osd1>
	<Pine.LNX.4.64.1010291018120.17302@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:51020 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932379Ab0J2RoH convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Oct 2010 13:44:07 -0400
Received: by ewy7 with SMTP id 7so2434093ewy.19
        for <ceph-devel@vger.kernel.org>; Fri, 29 Oct 2010 10:44:06 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1010291018120.17302@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

Thank you Sage,

I tried the master-backport, and it works now.

On Fri, Oct 29, 2010 at 1:29 PM, Sage Weil <sage@newdream.net> wrote:
> On Fri, 29 Oct 2010, Jeff Wu wrote:
>> Thank you Gregory and Yonggang,i git rbd-backport , make sucessfully=
=2E
>
> A word of caution: the rbd-backport branch is really old and out of d=
ate.
> The reason it compiles is because it doesn't have the task_dirty_inc =
call
> at all. =A0And looking at it more closely, it looks like task_dirty_i=
nc was
> never exported to modules. =A0Whoops! =A0I'm not sure what the implic=
ations of
> not calling it are (presumably the VMs space accounting gets out of
> whack), but it was also missing from the upstream version until 2.6.3=
6, so
> I'll just drop it from the -backport branches. =A0(I suspect I added =
it when
> the account_page_dirtied() call was added in 2.6.36 and noticed it wa=
s
> doing it.)
>
> In any case, the ceph-client-standalone.git is fixed up, and you shou=
ld
> now be able to use either master-backport or unstable-backport.
>
> sage
>
>
>>
>> Regards,
>> Jeff.Wu
>> Transoft.inc
>> Senior software Engineer
>>
>> =FF=FF 2010-10-29=FF=FF=FF=FF 00:54 +0800=FF=FFYonggang Liu=FF=FF=FF=
=FF=FF=FF
>> > Solved. Thank you Gregory!
>> > I used the branck rbd-backport and it works perfectly.
>> >
>> > Regards,
>> >
>> > On Thu, Oct 28, 2010 at 11:55 AM, Gregory Farnum <gregf@hq.newdrea=
m.net> wrote:
>> > > The ceph-client tree is always maintained against the latest rc =
from
>> > > Linus. For any other kernel you need to use the -backports branc=
hes.
>> > > It looks like this is what's causing both your troubles. :)
>> > > -Greg
>> > >
>> > > On Thu, Oct 28, 2010 at 8:20 AM, Yonggang Liu <myidpt@gmail.com>=
 wrote:
>> > >> The same thing happens here, I was using Debian 5.0 with kernel=
 2.6.32-5-686.
>> > >> I had the following error message:
>> > >> client:~/ceph-client-standalone# insmod ceph.ko
>> > >> insmod: error inserting 'ceph.ko': -1 Unknown symbol in module
>> > >> client:~/ceph-client-standalone# dmesg -c
>> > >> [ 4295.877555] ceph: Unknown symbol task_dirty_inc
>> > >>
>> > >> Any ideas?
>> > >>
>> > >> On Thu, Oct 28, 2010 at 5:55 AM, Jeff Wu <cpwu@tnsoft.com.cn> w=
rote:
>> > >>> Hi ,all
>> > >>>
>> > >>> At Ubuntu 10.10 x86_64 , kernel : Linux-2.6.35-22-generic ,
>> > >>>
>> > >>> I git Lastest ceph-client-standalone source codes from
>> > >>> git://ceph.newdream.net/ceph-client-standalone.git
>> > >>>
>> > >>> it make fail, get the warning messages: "account_page_dirtied"
>> > >>>
>> > >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Logs=
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > >>>
>> > >>> jeff@cephserver:~/work/ceph-client-standalone$ make
>> > >>>
>> > >>> =A0...................................
>> > >>>
>> > >>> CC [M] =A0/home/jeff/work/ceph-client-standalone/ceph_hash.o
>> > >>> =A0CC [M] =A0/home/jeff/work/ceph-client-standalone/ceph_frag.=
o
>> > >>> =A0LD [M] =A0/home/jeff/work/ceph-client-standalone/ceph.o
>> > >>> =A0Building modules, stage 2.
>> > >>> =A0MODPOST 1 modules
>> > >>> WARNING:
>> > >>> "account_page_dirtied" [/home/jeff/work/ceph-client-standalone=
/ceph.ko]
>> > >>> undefined!
>> > >>> =A0CC =A0 =A0 =A0/home/jeff/work/ceph-client-standalone/ceph.m=
od.o
>> > >>> =A0LD [M] =A0/home/jeff/work/ceph-client-standalone/ceph.ko
>> > >>> make[1]: Leaving directory `/usr/src/linux-headers-2.6.35-22-g=
eneric'
>> > >>> jeff@cephserver:~/work/ceph-client-standalone$
>> > >>>
>> > >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>> > >>>
>> > >>> then =A0i change to master-backport, to make it ,
>> > >>> still get a warning messages : "task_dirty_inc" .
>> > >>>
>> > >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dlogs=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>> > >>>
>> > >>> jeff@cephserver:~/work/ceph-client-standalone$ git checkout -b
>> > >>> master-backport origin/master-backport
>> > >>> Branch master-backport set up to track remote branch master-ba=
ckport
>> > >>> from origin.
>> > >>> Switched to a new branch 'master-backport'
>> > >>> jeff@cephserver:~/work/ceph-client-standalone$ git pull
>> > >>> Already up-to-date.
>> > >>>
>> > >>> jeff@cephserver:~/work/ceph-client-standalone$ make
>> > >>>
>> > >>> .........................................
>> > >>>
>> > >>> =A0CC [M] =A0/home/jeff/work/ceph-client-standalone/osdmap.o
>> > >>> =A0CC [M] =A0/home/jeff/work/ceph-client-standalone/debugfs.o
>> > >>> =A0CC [M] =A0/home/jeff/work/ceph-client-standalone/auth.o
>> > >>> =A0LD [M] =A0/home/jeff/work/ceph-client-standalone/ceph.o
>> > >>> =A0Building modules, stage 2.
>> > >>> =A0MODPOST 1 modules
>> > >>> WARNING:
>> > >>> "task_dirty_inc" [/home/jeff/work/ceph-client-standalone/ceph.=
ko]
>> > >>> undefined!
>> > >>> =A0CC =A0 =A0 =A0/home/jeff/work/ceph-client-standalone/ceph.m=
od.o
>> > >>> =A0LD [M] =A0/home/jeff/work/ceph-client-standalone/ceph.ko
>> > >>> make[1]: Leaving directory `/usr/src/linux-headers-2.6.35-22-g=
eneric'
>> > >>> jeff@cephserver:~/work/ceph-client-standalone$
>> > >>>
>> > >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > >>>
>> > >>> Is it a bug ? or i git wrong source package ?
>> > >>>
>> > >>> Thanks,
>> > >>> Jeff,Wu
>> > >>>
>> > >>>
>> > >>>
>> > >>>
>> > >>>
>> > >>>
>> > >>>
>> > >>> --
>> > >>> To unsubscribe from this list: send the line "unsubscribe ceph=
-devel" in
>> > >>> the body of a message to majordomo@vger.kernel.org
>> > >>> More majordomo info at =A0http://vger.kernel.org/majordomo-inf=
o.html
>> > >>>
>> > >>
>> > >>
>> > >>
>> > >> --
>> > >> Yonggang Liu
>> > >> Advanced Computing and Information Systems Laboratory
>> > >> University of Florida
>> > >> --
>> > >> To unsubscribe from this list: send the line "unsubscribe ceph-=
devel" in
>> > >> the body of a message to majordomo@vger.kernel.org
>> > >> More majordomo info at =A0http://vger.kernel.org/majordomo-info=
=2Ehtml
>> > >>
>> > >
>> >
>> >
>> >
>> > --
>> > Yonggang Liu
>> > Advanced Computing and Information Systems Laboratory
>> > University of Florida
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.ht=
ml
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>>



--=20
Yonggang Liu
Advanced Computing and Information Systems Laboratory
University of Florida
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
