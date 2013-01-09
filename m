From: Dave Spano <dspano@optogenics.com>
Subject: Re: OSD memory leaks?
Date: Wed, 9 Jan 2013 11:10:59 -0500 (EST)
Message-ID: <8366806.170.1357747859058.JavaMail.dspano@it1>
References: <CAOLwVUk-pf22gXFD+8A8FGgtE4mWfz3r8minKQ6vP6q_ftYRdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from rrcs-24-103-221-203.nys.biz.rr.com ([24.103.221.203]:52648 "EHLO
	mail.optogenics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932099Ab3AIQLG convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Jan 2013 11:11:06 -0500
In-Reply-To: <CAOLwVUk-pf22gXFD+8A8FGgtE4mWfz3r8minKQ6vP6q_ftYRdQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?utf-8?Q?S=C3=A9bastien?= Han <han.sebastien@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Samuel Just <sam.just@inktank.com>

Yes, I'm using argonaut.=20

I've got 38 heap files from yesterday. Currently, the OSD in question i=
s using 91.2% of memory according to top, and staying there. I initiall=
y thought it would go until the OOM killer started killing processes, b=
ut I don't see anything funny in the system logs that indicate that.=20

On the other hand, the ceph-osd process on osd.1 is using far less memo=
ry.=20

osd.0
  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND   =
                                                                       =
                                                      =20
 9151 root      20   0 20.4g  14g 2548 S    1 91.2 517:58.71 ceph-osd=20

osd.1

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND   =
                                                                       =
                                                      =20
10785 root      20   0  673m 310m 5164 S    3  1.9 107:04.39 ceph-osd =20

Here's what tcmalloc says when I run ceph osd tell 0 heap stats:
2013-01-09 11:09:36.778675 7f62aae23700  0 log [INF] : osd.0tcmalloc he=
ap stats:------------------------------------------------
2013-01-09 11:09:36.779113 7f62aae23700  0 log [INF] : MALLOC:      210=
884768 (  201.1 MB) Bytes in use by application
2013-01-09 11:09:36.779348 7f62aae23700  0 log [INF] : MALLOC: +     89=
026560 (   84.9 MB) Bytes in page heap freelist
2013-01-09 11:09:36.779928 7f62aae23700  0 log [INF] : MALLOC: +      7=
926512 (    7.6 MB) Bytes in central cache freelist
2013-01-09 11:09:36.779951 7f62aae23700  0 log [INF] : MALLOC: +       =
144896 (    0.1 MB) Bytes in transfer cache freelist
2013-01-09 11:09:36.779972 7f62aae23700  0 log [INF] : MALLOC: +     11=
046512 (   10.5 MB) Bytes in thread cache freelists
2013-01-09 11:09:36.780013 7f62aae23700  0 log [INF] : MALLOC: +      5=
177344 (    4.9 MB) Bytes in malloc metadata
2013-01-09 11:09:36.780030 7f62aae23700  0 log [INF] : MALLOC:   ------=
------
2013-01-09 11:09:36.780056 7f62aae23700  0 log [INF] : MALLOC: =3D    3=
24206592 (  309.2 MB) Actual memory used (physical + swap)
2013-01-09 11:09:36.780081 7f62aae23700  0 log [INF] : MALLOC: +    126=
177280 (  120.3 MB) Bytes released to OS (aka unmapped)
2013-01-09 11:09:36.780112 7f62aae23700  0 log [INF] : MALLOC:   ------=
------
2013-01-09 11:09:36.780127 7f62aae23700  0 log [INF] : MALLOC: =3D    4=
50383872 (  429.5 MB) Virtual address space used
2013-01-09 11:09:36.780152 7f62aae23700  0 log [INF] : MALLOC:
2013-01-09 11:09:36.780168 7f62aae23700  0 log [INF] : MALLOC:         =
 37492              Spans in use
2013-01-09 11:09:36.780330 7f62aae23700  0 log [INF] : MALLOC:         =
    51              Thread heaps in use
2013-01-09 11:09:36.780359 7f62aae23700  0 log [INF] : MALLOC:         =
  4096              Tcmalloc page size
2013-01-09 11:09:36.780384 7f62aae23700  0 log [INF] : ----------------=
--------------------------------


Dave Spano=20
Optogenics=20
Systems Administrator=20



----- Original Message -----=20

=46rom: "S=C3=A9bastien Han" <han.sebastien@gmail.com>=20
To: "Samuel Just" <sam.just@inktank.com>=20
Cc: "Dave Spano" <dspano@optogenics.com>, "ceph-devel" <ceph-devel@vger=
=2Ekernel.org>=20
Sent: Wednesday, January 9, 2013 10:20:43 AM=20
Subject: Re: OSD memory leaks?=20

I guess he runs Argonaut as well.=20

More suggestions about this problem?=20

Thanks!=20

--=20
Regards,=20
S=C3=A9bastien Han.=20


On Mon, Jan 7, 2013 at 8:09 PM, Samuel Just <sam.just@inktank.com> wrot=
e:=20
>=20
> Awesome! What version are you running (ceph-osd -v, include the hash)=
?=20
> -Sam=20
>=20
> On Mon, Jan 7, 2013 at 11:03 AM, Dave Spano <dspano@optogenics.com> w=
rote:=20
> > This failed the first time I sent it, so I'm resending in plain tex=
t.=20
> >=20
> > Dave Spano=20
> > Optogenics=20
> > Systems Administrator=20
> >=20
> >=20
> >=20
> > ----- Original Message -----=20
> >=20
> > From: "Dave Spano" <dspano@optogenics.com>=20
> > To: "S=C3=A9bastien Han" <han.sebastien@gmail.com>=20
> > Cc: "ceph-devel" <ceph-devel@vger.kernel.org>, "Samuel Just" <sam.j=
ust@inktank.com>=20
> > Sent: Monday, January 7, 2013 12:40:06 PM=20
> > Subject: Re: OSD memory leaks?=20
> >=20
> >=20
> > Sam,=20
> >=20
> > Attached are some heaps that I collected today. 001 and 003 are jus=
t after I started the profiler; 011 is the most recent. If you need mor=
e, or anything different let me know. Already the OSD in question is at=
 38% memory usage. As mentioned by S=C3=A8bastien, restarting ceph-osd =
keeps things going.=20
> >=20
> > Not sure if this is helpful information, but out of the two OSDs th=
at I have running, the first one (osd.0) is the one that develops this =
problem the quickest. osd.1 does have the same issue, it just takes muc=
h longer. Do the monitors hit the first osd in the list first, when the=
re's activity?=20
> >=20
> >=20
> > Dave Spano=20
> > Optogenics=20
> > Systems Administrator=20
> >=20
> >=20
> > ----- Original Message -----=20
> >=20
> > From: "S=C3=A9bastien Han" <han.sebastien@gmail.com>=20
> > To: "Samuel Just" <sam.just@inktank.com>=20
> > Cc: "ceph-devel" <ceph-devel@vger.kernel.org>=20
> > Sent: Friday, January 4, 2013 10:20:58 AM=20
> > Subject: Re: OSD memory leaks?=20
> >=20
> > Hi Sam,=20
> >=20
> > Thanks for your answer and sorry the late reply.=20
> >=20
> > Unfortunately I can't get something out from the profiler, actually=
 I=20
> > do but I guess it doesn't show what is supposed to show... I will k=
eep=20
> > on trying this. Anyway yesterday I just thought that the problem mi=
ght=20
> > be due to some over usage of some OSDs. I was thinking that the=20
> > distribution of the primary OSD might be uneven, this could have=20
> > explained that some memory leaks are more important with some serve=
rs.=20
> > At the end, the repartition seems even but while looking at the pg=20
> > dump I found something interesting in the scrub column, timestamps=20
> > from the last scrubbing operation matched with times showed on the=20
> > graph.=20
> >=20
> > After this, I made some calculation, I compared the total number of=
=20
> > scrubbing operation with the time range where memory leaks occurred=
=2E=20
> > First of all check my setup:=20
> >=20
> > root@c2-ceph-01 ~ # ceph osd tree=20
> > dumped osdmap tree epoch 859=20
> > # id weight type name up/down reweight=20
> > -1 12 pool default=20
> > -3 12 rack lc2_rack33=20
> > -2 3 host c2-ceph-01=20
> > 0 1 osd.0 up 1=20
> > 1 1 osd.1 up 1=20
> > 2 1 osd.2 up 1=20
> > -4 3 host c2-ceph-04=20
> > 10 1 osd.10 up 1=20
> > 11 1 osd.11 up 1=20
> > 9 1 osd.9 up 1=20
> > -5 3 host c2-ceph-02=20
> > 3 1 osd.3 up 1=20
> > 4 1 osd.4 up 1=20
> > 5 1 osd.5 up 1=20
> > -6 3 host c2-ceph-03=20
> > 6 1 osd.6 up 1=20
> > 7 1 osd.7 up 1=20
> > 8 1 osd.8 up 1=20
> >=20
> >=20
> > And there are the results:=20
> >=20
> > * Ceph node 1 which has the most important memory leak performed 16=
08=20
> > in total and 1059 during the time range where memory leaks occured=20
> > * Ceph node 2, 1168 in total and 776 during the time range where=20
> > memory leaks occured=20
> > * Ceph node 3, 940 in total and 94 during the time range where memo=
ry=20
> > leaks occurred=20
> > * Ceph node 4, 899 in total and 191 during the time range where=20
> > memory leaks occurred=20
> >=20
> > I'm still not entirely sure that the scrub operation causes the lea=
k=20
> > but the only relevant relation that I found...=20
> >=20
> > Could it be that the scrubbing process doesn't release memory? Btw =
I=20
> > was wondering, how ceph decides at what time it should run the=20
> > scrubbing operation? I know that it's once a day and control by the=
=20
> > following options=20
> >=20
> > OPTION(osd_scrub_min_interval, OPT_FLOAT, 300)=20
> > OPTION(osd_scrub_max_interval, OPT_FLOAT, 60*60*24)=20
> >=20
> > But how ceph determined the time where the operation started, durin=
g=20
> > cluster creation probably?=20
> >=20
> > I just checked the options that control OSD scrubbing and found tha=
t by default:=20
> >=20
> > OPTION(osd_max_scrubs, OPT_INT, 1)=20
> >=20
> > So that might explain why only one OSD uses a lot of memory.=20
> >=20
> > My dirty workaround at the moment is to performed a check of memory=
=20
> > use by every OSD and restart it if it uses more than 25% of the tot=
al=20
> > memory. Also note that on ceph 1, 3 and 4 it's always one OSD that=20
> > uses a lot of memory, for ceph 2 only the mem usage is high but alm=
ost=20
> > the same for all the OSD process.=20
> >=20
> > Thank you in advance.=20
> >=20
> > --=20
> > Regards,=20
> > S=C3=A9bastien Han.=20
> >=20
> >=20
> > On Wed, Dec 19, 2012 at 10:43 PM, Samuel Just <sam.just@inktank.com=
> wrote:=20
> >>=20
> >> Sorry, it's been very busy. The next step would to try to get a he=
ap=20
> >> dump. You can start a heap profile on osd N by:=20
> >>=20
> >> ceph osd tell N heap start_profiler=20
> >>=20
> >> and you can get it to dump the collected profile using=20
> >>=20
> >> ceph osd tell N heap dump.=20
> >>=20
> >> The dumps should show up in the osd log directory.=20
> >>=20
> >> Assuming the heap profiler is working correctly, you can look at t=
he=20
> >> dump using pprof in google-perftools.=20
> >>=20
> >> On Wed, Dec 19, 2012 at 8:37 AM, S=C3=A9bastien Han <han.sebastien=
@gmail.com> wrote:=20
> >> > No more suggestions? :(=20
> >> > --=20
> >> > Regards,=20
> >> > S=C3=A9bastien Han.=20
> >> >=20
> >> >=20
> >> > On Tue, Dec 18, 2012 at 6:21 PM, S=C3=A9bastien Han <han.sebasti=
en@gmail.com> wrote:=20
> >> >> Nothing terrific...=20
> >> >>=20
> >> >> Kernel logs from my clients are full of "libceph: osd4=20
> >> >> 172.20.11.32:6801 socket closed"=20
> >> >>=20
> >> >> I saw this somewhere on the tracker.=20
> >> >>=20
> >> >> Does this harm?=20
> >> >>=20
> >> >> Thanks.=20
> >> >>=20
> >> >> --=20
> >> >> Regards,=20
> >> >> S=C3=A9bastien Han.=20
> >> >>=20
> >> >>=20
> >> >>=20
> >> >> On Mon, Dec 17, 2012 at 11:55 PM, Samuel Just <sam.just@inktank=
=2Ecom> wrote:=20
> >> >>>=20
> >> >>> What is the workload like?=20
> >> >>> -Sam=20
> >> >>>=20
> >> >>> On Mon, Dec 17, 2012 at 2:41 PM, S=C3=A9bastien Han <han.sebas=
tien@gmail.com> wrote:=20
> >> >>> > Hi,=20
> >> >>> >=20
> >> >>> > No, I don't see nothing abnormal in the network stats. I don=
't see=20
> >> >>> > anything in the logs... :(=20
> >> >>> > The weird thing is that one node over 4 seems to take way mo=
re memory=20
> >> >>> > than the others...=20
> >> >>> >=20
> >> >>> > --=20
> >> >>> > Regards,=20
> >> >>> > S=C3=A9bastien Han.=20
> >> >>> >=20
> >> >>> >=20
> >> >>> > On Mon, Dec 17, 2012 at 11:31 PM, S=C3=A9bastien Han <han.se=
bastien@gmail.com> wrote:=20
> >> >>> >>=20
> >> >>> >> Hi,=20
> >> >>> >>=20
> >> >>> >> No, I don't see nothing abnormal in the network stats. I do=
n't see anything in the logs... :(=20
> >> >>> >> The weird thing is that one node over 4 seems to take way m=
ore memory than the others...=20
> >> >>> >>=20
> >> >>> >> --=20
> >> >>> >> Regards,=20
> >> >>> >> S=C3=A9bastien Han.=20
> >> >>> >>=20
> >> >>> >>=20
> >> >>> >>=20
> >> >>> >> On Mon, Dec 17, 2012 at 7:12 PM, Samuel Just <sam.just@inkt=
ank.com> wrote:=20
> >> >>> >>>=20
> >> >>> >>> Are you having network hiccups? There was a bug noticed re=
cently that=20
> >> >>> >>> could cause a memory leak if nodes are being marked up and=
 down.=20
> >> >>> >>> -Sam=20
> >> >>> >>>=20
> >> >>> >>> On Mon, Dec 17, 2012 at 12:28 AM, S=C3=A9bastien Han <han.=
sebastien@gmail.com> wrote:=20
> >> >>> >>> > Hi guys,=20
> >> >>> >>> >=20
> >> >>> >>> > Today looking at my graphs I noticed that one over 4 cep=
h nodes used a=20
> >> >>> >>> > lot of memory. It keeps growing and growing.=20
> >> >>> >>> > See the graph attached to this mail.=20
> >> >>> >>> > I run 0.48.2 on Ubuntu 12.04.=20
> >> >>> >>> >=20
> >> >>> >>> > The other nodes also grow, but slowly than the first one=
=2E=20
> >> >>> >>> >=20
> >> >>> >>> > I'm not quite sure about the information that I have to =
provide. So=20
> >> >>> >>> > let me know. The only thing I can say is that the load h=
aven't=20
> >> >>> >>> > increase that much this week. It seems to be consuming a=
nd not giving=20
> >> >>> >>> > back the memory.=20
> >> >>> >>> >=20
> >> >>> >>> > Thank you in advance.=20
> >> >>> >>> >=20
> >> >>> >>> > --=20
> >> >>> >>> > Regards,=20
> >> >>> >>> > S=C3=A9bastien Han.=20
> >> >>> >>=20
> >> >>> >>=20
> --=20
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in=20
> the body of a message to majordomo@vger.kernel.org=20
> More majordomo info at http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
