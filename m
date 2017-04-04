From: nokia ceph <nokiacephusers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Troubleshooting incomplete PG's
Date: Tue, 4 Apr 2017 15:50:14 +0530
Message-ID: <CALWuvY-XOdKqC94wRt4-C8VjBoEyOGNh6LhZN2EhZsQsj+pCZA@mail.gmail.com>
References: <CALWuvY9pPr6FumF-d65pLrhbj1=HPNUEH74tKEOsfs=fAn_fbA@mail.gmail.com>
	<CAF-wwdGXduVn8a5xYPxo2BBtHQnAFVijPG_EvDjojyL_7f0cxQ@mail.gmail.com>
	<CALWuvY-053dt8w8Aj5n-icf--v_TZ2dkEBrE8T7nTR8Hb3SeDg@mail.gmail.com>
	<alpine.DEB.2.11.1704031315210.12988@piezo.novalocal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2073371407=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.11.1704031315210.12988-qHenpvqtifaMSRpgCs4c+g@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ceph Users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============2073371407==
Content-Type: multipart/alternative; boundary=f40304378b002f287b054c549f11

--f40304378b002f287b054c549f11
Content-Type: text/plain; charset=UTF-8

Hello Sage and Brad,

Many thanks for the information

>incomplete PGs can be extracted from the drive if the bad sector(s) don't
>happen to affect those pgs.  The ceph-objectstore-tool --op export command
>can be used for this (extract it from the affected drive and add it to
>some other osd).


==
#ceph-objectstore-tool --data-path /var/lib/ceph/osd/ceph-0 --pgid 1.fs1
--op export --file /tmp/test
Exporting 1.fs1
Export successful

#ceph-objectstore-tool --data-path /var/lib/ceph/osd/ceph-1  --op import
--file /tmp/test
Importing pgid 1.fs1
Import successful
==

I will try this for next issue reoccurance.

Need your suggestion to fixing the unfound errors which happened on other
environment. v11.2.0 , bluestore, 4+1

===
1 active+degraded, 8191 active+clean; 29494 GB data, 39323 GB used, 1180 TB
/ 1218 TB avail; 2/66917305 objects degraded (0.000%); 1/13383461 unfound
(0.000%)
===

===
pg 1.93f is active+degraded, acting [206,99,11,290,169], 1 unfound
===

What we tried...

#Restart all the associated OSD's for that PG's 206,99,11,290,169
#Here all the OSD's are up and running state
#ceph pg repair 1.93f
#ceph pg deep-scrub 1.93f

At last
#ceph pg 1.93f mark_unfound_lost delete   { data loss }


Need your views on this, to how to clear the unfound issues without data
loss.


Thanks
Jayaram



On Mon, Apr 3, 2017 at 6:50 PM, Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> On Fri, 31 Mar 2017, nokia ceph wrote:
> > Hello Brad,
> > Many thanks of the info :)
> >
> > ENV:-- Kracken - bluestore - EC 4+1 - 5 node cluster : RHEL7
> >
> > What is the status of the down+out osd? Only one osd osd.6 down and out
> from
> > cluster.
> > What role did/does it play? Mostimportantly, is it osd.6? Yes, due to
> > underlying I/O error issue we removed this device from the cluster.
>
> Is the device completely destroyed or is it only returning errors
> when reading certain data?  It is likely that some (or all) of the
> incomplete PGs can be extracted from the drive if the bad sector(s) don't
> happen to affect those pgs.  The ceph-objectstore-tool --op export command
> can be used for this (extract it from the affected drive and add it to
> some other osd).
>
> > I put this parameter " osd_find_best_info_ignore_history_les = true" in
> > ceph.conf, and find those 22 PG's were changed to "down+remapped" . Now
> all
> > are reverted to "remapped+incomplete" state.
>
> This is usually not a great idea unless you're out of options, by the way!
>
> > #ceph pg stat 2> /dev/null
> > v2731828: 4096 pgs: 1 incomplete, 21 remapped+incomplete, 4074
> active+clean;
> > 268 TB data, 371 TB used, 267 TB / 638 TB avail
> >
> > ## ceph -s
> > 2017-03-30 19:02:14.350242 7f8b0415f700 -1 WARNING: the following
> dangerous
> > and experimental features are enabled: bluestore,rocksdb
> > 2017-03-30 19:02:14.366545 7f8b0415f700 -1 WARNING: the following
> dangerous
> > and experimental features are enabled: bluestore,rocksdb
> >     cluster bd8adcd0-c36d-4367-9efe-f48f5ab5f108
> >      health HEALTH_ERR
> >             22 pgs are stuck inactive for more than 300 seconds
> >             22 pgs incomplete
> >             22 pgs stuck inactive
> >             22 pgs stuck unclean
> >      monmap e2: 5 mons at{au-adelaide=10.50.21.24:
> 6789/0,au-brisbane=10.50.21.22:6789/0,au-canberra=
> > 10.50.21.23:6789/0,au-melbourne=10.50.21.21:6789/0,
> au-sydney=10.50.21.20:67
> > 89/0}
> >             election epoch 180, quorum 0,1,2,3,4
> > au-sydney,au-melbourne,au-brisbane,au-canberra,au-adelaide
> >         mgr active: au-adelaide
> >      osdmap e6506: 117 osds: 117 up, 117 in; 21 remapped pgs
> >             flags sortbitwise,require_jewel_osds,require_kraken_osds
> >       pgmap v2731828: 4096 pgs, 1 pools, 268 TB data, 197 Mobjects
> >             371 TB used, 267 TB / 638 TB avail
> >                 4074 active+clean
> >                   21 remapped+incomplete
> >                    1 incomplete
> >
> >
> > ## ceph osd dump 2>/dev/null | grep cdvr
> > pool 1 'cdvr_ec' erasure size 5 min_size 4 crush_ruleset 1 object_hash
> > rjenkins pg_num 4096 pgp_num 4096 last_change 456 flags
> > hashpspool,nodeep-scrub stripe_width 65536
> >
> > Inspecting affected PG 1.e4b
> >
> > # ceph pg dump 2> /dev/null | grep 1.e4b
> > 1.e4b     50832                  0        0         0       0 73013340821
> > 10006    10006 remapped+incomplete 2017-03-30 14:14:26.297098 3844'161662
> >  6506:325748 [113,66,15,73,103]        113  [NONE,NONE,NONE,73,NONE]
>
> >     73 1643'139486 2017-03-21 04:56:16.683953             0'0 2017-02-21
> > 10:33:50.012922
> >
> > When I trigger below command.
> >
> > #ceph pg force_create_pg 1.e4b
> > pg 1.e4b now creating, ok
> >
> > As it went to creating state, no change after that. Can you explain why
> this
> > PG showing null values after triggering "force_create_pg",?
> >
> > ]# ceph pg dump 2> /dev/null | grep 1.e4b
> > 1.e4b         0                  0        0         0       0
> 0
> >   0        0            creating 2017-03-30 19:07:00.982178         0'0
>
> >      0:0                 []         -1                        []
>
> > -1         0'0                   0.000000             0'0
>
> > 0.000000
>
> CRUSH isn't mapping the PG to any OSDs, so there is nowhere to create it,
> it seems?  What does 'ceph pg map <pgid>' show?
>
> > Then I triggered below command
> >
> > # ceph pg  repair 1.e4b
> > Error EAGAIN: pg 1.e4b has no primary osd  --<<
> >
> > Could you please provide answer for below queries.
> >
> > 1. How to fix this "incomplete+remapped" PG issue, here all OSD's were up
> > and running and affected OSD marked out and removed from the cluster.
>
> To recover the data, you need to find surviving shards of the PG.
> ceph-objectstore-tool on the "failed" disk is one option, but since this
> is a 4+2 code there should have been another copy that got lost along the
> line... do you know where it is?
>
> > 2. Will reduce min_size helps? currently it set to 4. Could you please
> > explain what is the impact if we reduce min_size for the current config
> EC
> > 4+1
>
> You can't reduce it below 4 since it's a 4+2 code.  By default we set it
> as 5 (k+1) so that you won't write new data to the PG if a single
> additional failure could lead you to lose those writes.
>
> > 3. Is there any procedure to safely remove an affected PG? As per my
> > understanding I'm aware about this command.
> >
> > ===
> > #ceph-objectstore-tool --data-path /var/lib/ceph/osd/ceph --pgid 1.e4b
> --op
> > remove
> > ===
> >
> > Awaiting for your suggestions to proceed.
>
> If you don't need the data and just want to recreate the pg empty, then
> the procedure is to remove any surviving fragments and then do
> force_create_pg.  It looks like you need to figure out why the pgid isn't
> mapping to any OSDs first, though.
>
> sage
>
>
>
>  >
> > Thanks
> >
> >
> >
> >
> >
> >
> > On Thu, Mar 30, 2017 at 7:32 AM, Brad Hubbard <bhubbard-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> wrote:
> >
> >
> >       On Thu, Mar 30, 2017 at 4:53 AM, nokia ceph
> >       <nokiacephusers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> >       > Hello,
> >       >
> >       > Env:-
> >       > 5 node, EC 4+1 bluestore kraken v11.2.0 , RHEL7.2
> >       >
> >       > As part of our resillency testing with kraken bluestore, we
> >       face more PG's
> >       > were in incomplete+remapped state. We tried to repair each PG
> >       using "ceph pg
> >       > repair <pgid>" still no luck. Then we planned to remove
> >       incomplete PG's
> >       > using below procedure.
> >       >
> >       >
> >       > #ceph health detail | grep  1.e4b
> >       > pg 1.e4b is remapped+incomplete, acting
> >       [2147483647,66,15,73,2147483647]
> >       > (reducing pool cdvr_ec min_size from 4 may help; search
> >       ceph.com/docs for
> >       > 'incomplete')
> >
> >       "Incomplete Ceph detects that a placement group is missing
> >       information about
> >       writes that may have occurred, or does not have any healthy
> >       copies. If you see
> >       this state, try to start any failed OSDs that may contain the
> >       needed
> >       information."
> >
> >       >
> >       > Here we shutdown the OSD's 66,15 and 73 then proceeded with
> >       below operation.
> >       >
> >       > #ceph-objectstore-tool --data-path /var/lib/ceph/osd/ceph-135
> >       --op list-pgs
> >       > #ceph-objectstore-tool --data-path /var/lib/ceph/osd/ceph-135
> >       --pgid 1.e4b
> >       > --op remove
> >       >
> >       > Please confirm that we are following the correct procedure to
> >       removal of
> >       > PG's
> >
> >       There are multiple threads about that on this very list "pgs
> >       stuck inactive"
> >       recently for example.
> >
> >       >
> >       > #ceph pg stat
> >       > v2724830: 4096 pgs: 1 active+clean+scrubbing+deep+repair, 1
> >       down+remapped,
> >       > 21 remapped+incomplete, 4073 active+clean; 268 TB data, 371 TB
> >       used, 267 TB
> >       > / 638 TB avail
> >       >
> >       > # ceph -s
> >       > 2017-03-29 18:23:44.288508 7f8c2b8e5700 -1 WARNING: the
> >       following dangerous
> >       > and experimental features are enabled: bluestore,rocksdb
> >       > 2017-03-29 18:23:44.304692 7f8c2b8e5700 -1 WARNING: the
> >       following dangerous
> >       > and experimental features are enabled: bluestore,rocksdb
> >       >     cluster bd8adcd0-c36d-4367-9efe-f48f5ab5f108
> >       >      health HEALTH_ERR
> >       >             22 pgs are stuck inactive for more than 300
> >       seconds
> >       >             1 pgs down
> >       >             21 pgs incomplete
> >       >             1 pgs repair
> >       >             22 pgs stuck inactive
> >       >             22 pgs stuck unclean
> >       >      monmap e2: 5 mons at
> >       >{au-adelaide=10.50.21.24:6789/0,au-brisbane=10.50.21.
> 22:6789/0,au-canberra=
> > 10.50.21.23:6789/0,au-melbourne=10.50.21.21:6789/0,
> au-sydney=10.50.21.20:67
> >       89/0}
> >       >             election epoch 172, quorum 0,1,2,3,4
> >       > au-sydney,au-melbourne,au-brisbane,au-canberra,au-adelaide
> >       >         mgr active: au-brisbane
> >       >      osdmap e6284: 118 osds: 117 up, 117 in; 22 remapped pgs
> >
> >       What is the status of the down+out osd? What role did/does it
> >       play? Most
> >       importantly, is it osd.6?
> >
> >       >             flags
> >       sortbitwise,require_jewel_osds,require_kraken_osds
> >       >       pgmap v2724830: 4096 pgs, 1 pools, 268 TB data, 197
> >       Mobjects
> >       >             371 TB used, 267 TB / 638 TB avail
> >       >                 4073 active+clean
> >       >                   21 remapped+incomplete
> >       >                    1 down+remapped
> >       >                    1 active+clean+scrubbing+deep+repair
> >       >
> >       >
> >       > #ceph osd dump | grep pool
> >       > pool 1 'cdvr_ec' erasure size 5 min_size 4 crush_ruleset 1
> >       object_hash
> >       > rjenkins pg_num 4096 pgp_num 4096 last_change 456 flags
> >       > hashpspool,nodeep-scrub stripe_width 65536
> >       >
> >       >
> >       >
> >       > Can you please suggest is there any way to wipe out these
> >       incomplete PG's.
> >
> >       See the thread previously mentioned. Take note of the
> >       force_create_pg step.
> >
> >       > Why ceph pg repair failed in this scenerio?
> >       > How to recover incomplete PG's to active state.
> >       >
> >       > pg query for the affected PG ended with this error. Can you
> >       please explain
> >       > what is meant by this ?
> >       > ---
> >       >                 "15(2)",
> >       >                 "66(1)",
> >       >                 "73(3)",
> >       >                 "103(4)",
> >       >                 "113(0)"
> >       >             ],
> >       >             "down_osds_we_would_probe": [
> >       >                 6
> >       >             ],
> >       >             "peering_blocked_by": [],
> >       >             "peering_blocked_by_detail": [
> >       >                 {
> >       >                     "detail":
> >       "peering_blocked_by_history_les_bound"
> >       >                 }
> >       > ----
> >
> >       During multiple intervals osd 6 was in the up/acting set, for
> >       example;
> >
> >                       {
> >                           "first": 1608,
> >                           "last": 1645,
> >                           "maybe_went_rw": 1,
> >                           "up": [
> >                               113,
> >                               6,
> >                               15,
> >                               73,
> >                               103
> >                           ],
> >                           "acting": [
> >                               113,
> >                               6,
> >                               15,
> >                               73,
> >                               103
> >                           ],
> >                           "primary": 113,
> >                           "up_primary": 113
> >                       },
> >
> >       Because we may have gone rw during that interval we need to
> >       query it and it is blocking progress.
> >
> >                   "blocked_by": [
> >                       6
> >                   ],
> >
> >       Setting osd_find_best_info_ignore_history_les to true may help
> >       but then you may
> >       need to mark the missing OSD lost or perform some other trickery
> >       (and this . I
> >       suspect your min_size is too low, especially for a cluster of
> >       this size, but EC
> >       is not an area I know extensively so I can't say definitively.
> >       Some of your
> >       questions may be better suited to the ceph-devel mailing list by
> >       the way.
> >
> >       >
> >       > Attaching "ceph pg 1.e4b query > /tmp/1.e4b-pg.txt" file with
> >       this mail.
> >       >
> >       > Thanks
> >       >
> >       > _______________________________________________
> >       > ceph-users mailing list
> >       > ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> >       > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> >       >
> >
> >
> >
> >       --
> >       Cheers,
> >       Brad
> >
> >
> >
> >
>

--f40304378b002f287b054c549f11
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello Sage and Brad,<div><br></div><div>Many thanks for th=
e information=C2=A0</div><div><br></div><div><span style=3D"font-size:12.8p=
x">&gt;incomplete PGs can be extracted from the drive if the bad sector(s) =
don&#39;t</span><br style=3D"font-size:12.8px"><span style=3D"font-size:12.=
8px">&gt;happen to affect those pgs.=C2=A0 The ceph-objectstore-tool --op e=
xport command</span><br style=3D"font-size:12.8px"><span style=3D"font-size=
:12.8px">&gt;can be used for this (extract it from the affected drive and a=
dd it to</span><br style=3D"font-size:12.8px"><span style=3D"font-size:12.8=
px">&gt;some other osd).</span><br></div><div><span style=3D"font-size:12.8=
px"><br></span></div><div><br></div><div><span style=3D"font-size:12.8px">=
=3D=3D</span></div><div><div><span style=3D"font-size:12.8px">#ceph-objects=
tore-tool --data-path /var/lib/ceph/osd/ceph-0 --pgid 1.fs1 --op export --f=
ile /tmp/test</span></div><div><span style=3D"font-size:12.8px">Exporting 1=
.fs1</span></div><div><span style=3D"font-size:12.8px">Export successful</s=
pan></div><div><span style=3D"font-size:12.8px"><br></span></div><div><span=
 style=3D"font-size:12.8px">#ceph-objectstore-tool --data-path /var/lib/cep=
h/osd/ceph-1 =C2=A0--op import --file /tmp/test</span></div><div><span styl=
e=3D"font-size:12.8px">Importing pgid 1.fs1</span></div><div><span style=3D=
"font-size:12.8px">Import successful</span></div></div><div><span style=3D"=
font-size:12.8px">=3D=3D</span></div><div><span style=3D"font-size:12.8px">=
<br></span></div><div><span style=3D"font-size:12.8px">I will try this for =
next issue reoccurance.=C2=A0</span></div><div><span style=3D"font-size:12.=
8px"><br></span></div><div><span style=3D"font-size:12.8px">Need your sugge=
stion to fixing the unfound errors which happened on other environment. v11=
.2.0 , bluestore, 4+1</span></div><div><span style=3D"font-size:12.8px">=C2=
=A0</span></div><div><span style=3D"font-size:11pt;line-height:115%;font-fa=
mily:calibri,sans-serif">=3D=3D=3D</span></div><div><span style=3D"font-siz=
e:11pt;line-height:115%;font-family:calibri,sans-serif">1 active+degraded,
8191 active+clean; 29494 GB data, 39323 GB used, 1180 TB / 1218 TB avail;
2/66917305 objects degraded (0.000%); 1/13383461 unfound (0.000%)</span><sp=
an style=3D"font-size:12.8px"><br></span></div><div><span style=3D"font-siz=
e:12.8px">=3D=3D=3D</span></div><div><span style=3D"font-size:12.8px"><br><=
/span></div><div><span style=3D"font-size:12.8px">=3D=3D=3D</span></div><di=
v><span style=3D"font-size:11pt;line-height:115%;font-family:calibri,sans-s=
erif">pg
1.93f is active+degraded, acting [206,99,11,290,169], 1 unfound</span><span=
 style=3D"font-size:12.8px"><br></span></div><div><span style=3D"font-size:=
12.8px">=3D=3D=3D</span></div><div><span style=3D"font-size:12.8px"><br></s=
pan></div><div><span style=3D"font-size:12.8px">What we tried...</span></di=
v><div><span style=3D"font-size:12.8px"><br></span></div><div><span style=
=3D"font-size:12.8px">#Restart all the associated OSD&#39;s for that PG&#39=
;s=C2=A0</span><span style=3D"font-family:calibri,sans-serif;font-size:14.6=
667px">206,99,11,290,169=C2=A0</span></div><div><span style=3D"font-family:=
calibri,sans-serif;font-size:14.6667px">#Here all the OSD&#39;s are up and =
running state</span></div><div><span style=3D"font-size:12.8px">#</span><sp=
an style=3D"font-family:calibri,sans-serif;font-size:11pt">ceph
pg repair 1.93f</span></div><div><span style=3D"font-family:calibri,sans-se=
rif;font-size:11pt">#ceph
pg deep-scrub 1.93f</span></div><div><br></div><div><font face=3D"calibri, =
sans-serif"><span style=3D"font-size:14.6667px">At last=C2=A0</span></font>=
</div><div><font face=3D"calibri, sans-serif"><span style=3D"font-size:14.6=
667px">#</span></font><span style=3D"font-family:calibri,sans-serif;font-si=
ze:11pt">ceph
pg 1.93f mark_unfound_lost delete =C2=A0 { data loss }</span></div><div><sp=
an style=3D"font-size:12.8px"><br></span></div><div><span style=3D"font-siz=
e:12.8px"><br></span></div><div><span style=3D"font-size:12.8px">Need your =
views on this, to how to clear the unfound issues without data loss.</span>=
</div><div><span style=3D"font-size:12.8px"><br></span></div><div><span sty=
le=3D"font-size:12.8px"><br></span></div><div><span style=3D"font-size:12.8=
px">Thanks</span></div><div><span style=3D"font-size:12.8px">Jayaram</span>=
</div><div><span style=3D"font-size:12.8px"><br></span></div><div><br></div=
></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Mon, Ap=
r 3, 2017 at 6:50 PM, Sage Weil <span dir=3D"ltr">&lt;<a href=3D"mailto:swe=
il-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" target=3D"_blank">sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt;</span> wrote:<br>=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><span class=3D"">On Fri, 31 Mar 2017, nokia =
ceph wrote:<br>
&gt; Hello Brad,<br>
&gt; Many thanks of the info :)<br>
&gt;<br>
&gt; ENV:-- Kracken - bluestore - EC 4+1 - 5 node cluster : RHEL7<br>
&gt;<br>
&gt; What is the status of the down+out osd? Only one osd osd.6 down and ou=
t from<br>
&gt; cluster.<br>
&gt; What role did/does it play? Mostimportantly, is it osd.6? Yes, due to<=
br>
&gt; underlying I/O error issue we removed this device from the cluster.<br=
>
<br>
</span>Is the device completely destroyed or is it only returning errors<br=
>
when reading certain data?=C2=A0 It is likely that some (or all) of the<br>
incomplete PGs can be extracted from the drive if the bad sector(s) don&#39=
;t<br>
happen to affect those pgs.=C2=A0 The ceph-objectstore-tool --op export com=
mand<br>
can be used for this (extract it from the affected drive and add it to<br>
some other osd).<br>
<span class=3D""><br>
&gt; I put this parameter &quot;=C2=A0osd_find_best_info_ignore_<wbr>histor=
y_les =3D true&quot; in<br>
&gt; ceph.conf, and find those 22 PG&#39;s were changed to &quot;down+remap=
ped&quot; . Now all<br>
&gt; are reverted to &quot;remapped+incomplete&quot; state.<br>
<br>
</span>This is usually not a great idea unless you&#39;re out of options, b=
y the way!<br>
<div><div class=3D"h5"><br>
&gt; #ceph pg stat 2&gt; /dev/null<br>
&gt; v2731828: 4096 pgs: 1 incomplete, 21 remapped+incomplete, 4074 active+=
clean;<br>
&gt; 268 TB data, 371 TB used, 267 TB / 638 TB avail<br>
&gt;<br>
&gt; ## ceph -s<br>
&gt; 2017-03-30 19:02:14.350242 7f8b0415f700 -1 WARNING: the following dang=
erous<br>
&gt; and experimental features are enabled: bluestore,rocksdb<br>
&gt; 2017-03-30 19:02:14.366545 7f8b0415f700 -1 WARNING: the following dang=
erous<br>
&gt; and experimental features are enabled: bluestore,rocksdb<br>
&gt; =C2=A0 =C2=A0 cluster bd8adcd0-c36d-4367-9efe-<wbr>f48f5ab5f108<br>
&gt; =C2=A0 =C2=A0 =C2=A0health HEALTH_ERR<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 22 pgs are stuck inactive fo=
r more than 300 seconds<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 22 pgs incomplete<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 22 pgs stuck inactive<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 22 pgs stuck unclean<br>
&gt; =C2=A0 =C2=A0 =C2=A0monmap e2: 5 mons at{au-adelaide=3D<a href=3D"http=
://10.50.21.24:6789/0,au-brisbane=3D10.50.21.22:6789/0,au-canberra=3D" rel=
=3D"noreferrer" target=3D"_blank">10.50.21.24:<wbr>6789/0,au-brisbane=3D10.=
50.21.<wbr>22:6789/0,au-canberra=3D</a><br>
&gt; <a href=3D"http://10.50.21.23:6789/0,au-melbourne=3D10.50.21.21:6789/0=
,au-sydney=3D10.50.21.20:67" rel=3D"noreferrer" target=3D"_blank">10.50.21.=
23:6789/0,au-<wbr>melbourne=3D10.50.21.21:6789/0,<wbr>au-sydney=3D10.50.21.=
20:67</a><br>
&gt; 89/0}<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 election epoch 180, quorum 0=
,1,2,3,4<br>
&gt; au-sydney,au-melbourne,au-<wbr>brisbane,au-canberra,au-<wbr>adelaide<b=
r>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 mgr active: au-adelaide<br>
&gt; =C2=A0 =C2=A0 =C2=A0osdmap e6506: 117 osds: 117 up, 117 in; 21 remappe=
d pgs<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flags sortbitwise,require_je=
wel_<wbr>osds,require_kraken_osds<br>
&gt; =C2=A0 =C2=A0 =C2=A0 pgmap v2731828: 4096 pgs, 1 pools, 268 TB data, 1=
97 Mobjects<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 371 TB used, 267 TB / 638 TB=
 avail<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 4074 active+cl=
ean<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 21 rema=
pped+incomplete<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01=
 incomplete<br>
&gt;<br>
&gt;<br>
&gt; ## ceph osd dump 2&gt;/dev/null | grep cdvr<br>
&gt; pool 1 &#39;cdvr_ec&#39; erasure size 5 min_size 4 crush_ruleset 1 obj=
ect_hash<br>
&gt; rjenkins pg_num 4096 pgp_num 4096 last_change 456 flags<br>
&gt; hashpspool,nodeep-scrub stripe_width 65536<br>
&gt;<br>
&gt; Inspecting affected PG 1.e4b<br>
&gt;<br>
&gt; # ceph pg dump 2&gt; /dev/null | grep 1.e4b<br>
&gt; 1.e4b =C2=A0 =C2=A0 50832 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A00 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 0 =C2=A0 =C2=A0 =C2=A0 0 73013340821<br>
&gt; 10006 =C2=A0 =C2=A010006 remapped+incomplete 2017-03-30 14:14:26.29709=
8 3844&#39;161662<br>
&gt; =C2=A06506:325748 [113,66,15,73,103] =C2=A0 =C2=A0 =C2=A0 =C2=A0113 =
=C2=A0[NONE,NONE,NONE,73,NONE] =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; =C2=A0 =C2=A0 73 1643&#39;139486 2017-03-21 04:56:16.683953 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0&#39;0 2017-02-21<br>
&gt; 10:33:50.012922<br>
&gt;<br>
&gt; When I trigger below command.<br>
&gt;<br>
&gt; #ceph pg force_create_pg 1.e4b<br>
&gt; pg 1.e4b now creating, ok<br>
&gt;<br>
&gt; As it went to creating state, no change after that. Can you explain wh=
y this<br>
&gt; PG showing null values after triggering &quot;force_create_pg&quot;,?<=
br>
&gt;<br>
&gt; ]# ceph pg dump 2&gt; /dev/null | grep 1.e4b<br>
&gt; 1.e4b =C2=A0 =C2=A0 =C2=A0 =C2=A0 0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 0 =C2=A0 =C2=A0 =C2=A0 0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0=
 =C2=A0<br>
&gt; =C2=A0 0 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0creating 2017-03-30 19:07:00.982178 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0=
&#39;0 =C2=A0 =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A00:0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 [] =C2=A0 =C2=A0 =C2=A0 =C2=A0 -1 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[] =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; -1 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0&#39;0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.000000 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 0&#39;0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0<br>
&gt; 0.000000<br>
<br>
</div></div>CRUSH isn&#39;t mapping the PG to any OSDs, so there is nowhere=
 to create it,<br>
it seems?=C2=A0 What does &#39;ceph pg map &lt;pgid&gt;&#39; show?<br>
<span class=3D""><br>
&gt; Then I triggered below command<br>
&gt;<br>
&gt; #=C2=A0ceph pg =C2=A0repair 1.e4b<br>
&gt; Error EAGAIN: pg 1.e4b has no primary osd =C2=A0--&lt;&lt;<br>
&gt;<br>
&gt; Could you please provide answer for below queries.<br>
&gt;<br>
&gt; 1. How to fix this &quot;incomplete+remapped&quot; PG issue, here all =
OSD&#39;s were up<br>
&gt; and running and affected OSD marked out and removed from the cluster.<=
br>
<br>
</span>To recover the data, you need to find surviving shards of the PG.<br=
>
ceph-objectstore-tool on the &quot;failed&quot; disk is one option, but sin=
ce this<br>
is a 4+2 code there should have been another copy that got lost along the<b=
r>
line... do you know where it is?<br>
<span class=3D""><br>
&gt; 2. Will reduce min_size helps? currently it set to 4. Could you please=
<br>
&gt; explain what is the impact if we reduce min_size for the current confi=
g EC<br>
&gt; 4+1<br>
<br>
</span>You can&#39;t reduce it below 4 since it&#39;s a 4+2 code.=C2=A0 By =
default we set it<br>
as 5 (k+1) so that you won&#39;t write new data to the PG if a single<br>
additional failure could lead you to lose those writes.<br>
<span class=3D""><br>
&gt; 3. Is there any procedure to safely remove an affected PG? As per my<b=
r>
&gt; understanding I&#39;m aware about this command.<br>
&gt;<br>
&gt; =3D=3D=3D<br>
&gt; #ceph-objectstore-tool --data-path /var/lib/ceph/osd/ceph --pgid 1.e4b=
 --op<br>
&gt; remove<br>
&gt; =3D=3D=3D<br>
&gt;<br>
&gt; Awaiting for your suggestions to proceed.=C2=A0<br>
<br>
</span>If you don&#39;t need the data and just want to recreate the pg empt=
y, then<br>
the procedure is to remove any surviving fragments and then do<br>
force_create_pg.=C2=A0 It looks like you need to figure out why the pgid is=
n&#39;t<br>
mapping to any OSDs first, though.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
sage<br>
</font></span><div class=3D"HOEnZb"><div class=3D"h5"><br>
<br>
<br>
=C2=A0&gt;<br>
&gt; Thanks<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; On Thu, Mar 30, 2017 at 7:32 AM, Brad Hubbard &lt;<a href=3D"mailto:bh=
ubbard-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org">bhubbard-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt; wrote:<br>
&gt;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0On Thu, Mar 30, 2017 at 4:53 AM, nokia ceph<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"mailto:nokiacephusers@gmail.c=
om">nokiacephusers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; Hello,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; Env:-<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; 5 node, EC 4+1 bluestore kraken v11.2.0=
 , RHEL7.2<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; As part of our resillency testing with =
kraken bluestore, we<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0face more PG&#39;s<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; were in incomplete+remapped state. We t=
ried to repair each PG<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0using &quot;ceph pg<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; repair &lt;pgid&gt;&quot; still no luck=
. Then we planned to remove<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0incomplete PG&#39;s<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; using below procedure.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; #ceph health detail | grep=C2=A0 1.e4b<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; pg 1.e4b is remapped+incomplete, acting=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[2147483647,66,15,73,<wbr>2147483647]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; (reducing pool cdvr_ec min_size from 4 =
may help; search<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"http://ceph.com/docs" rel=3D"nore=
ferrer" target=3D"_blank">ceph.com/docs</a> for<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; &#39;incomplete&#39;)<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;Incomplete Ceph detects that a placeme=
nt group is missing<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0information about<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0writes that may have occurred, or does not h=
ave any healthy<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0copies. If you see<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0this state, try to start any failed OSDs tha=
t may contain the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0needed<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0information.&quot;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; Here we shutdown the OSD&#39;s 66,15 an=
d 73 then proceeded with<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0below operation.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; #ceph-objectstore-tool --data-path /var=
/lib/ceph/osd/ceph-135<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0--op list-pgs<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; #ceph-objectstore-tool --data-path /var=
/lib/ceph/osd/ceph-135<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0--pgid 1.e4b<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; --op remove<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; Please confirm that we are following th=
e correct procedure to<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0removal of<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; PG&#39;s<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0There are multiple threads about that on thi=
s very list &quot;pgs<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0stuck inactive&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0recently for example.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; #ceph pg stat<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; v2724830: 4096 pgs: 1 active+clean+scru=
bbing+deep+<wbr>repair, 1<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0down+remapped,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; 21 remapped+incomplete, 4073 active+cle=
an; 268 TB data, 371 TB<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0used, 267 TB<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; / 638 TB avail<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; # ceph -s<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; 2017-03-29 18:23:44.288508 7f8c2b8e5700=
 -1 WARNING: the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0following dangerous<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; and experimental features are enabled: =
bluestore,rocksdb<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; 2017-03-29 18:23:44.304692 7f8c2b8e5700=
 -1 WARNING: the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0following dangerous<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; and experimental features are enabled: =
bluestore,rocksdb<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0cluster bd8adcd0-c36=
d-4367-9efe-<wbr>f48f5ab5f108<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 health HEALTH_ERR<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A022 pgs are stuck inactive for more than 300<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0seconds<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A01 pgs down<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A021 pgs incomplete<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A01 pgs repair<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A022 pgs stuck inactive<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A022 pgs stuck unclean<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 monmap e2: 5 mons a=
t<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;{au-adelaide=3D<a href=3D"http://10.50.2=
1.24:6789/0,au-brisbane=3D10.50.21.22:6789/0,au-canberra=3D" rel=3D"norefer=
rer" target=3D"_blank">10.50.21.24:<wbr>6789/0,au-brisbane=3D10.50.21.<wbr>=
22:6789/0,au-canberra=3D</a><br>
&gt; <a href=3D"http://10.50.21.23:6789/0,au-melbourne=3D10.50.21.21:6789/0=
,au-sydney=3D10.50.21.20:67" rel=3D"noreferrer" target=3D"_blank">10.50.21.=
23:6789/0,au-<wbr>melbourne=3D10.50.21.21:6789/0,<wbr>au-sydney=3D10.50.21.=
20:67</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A089/0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0election epoch 172, quorum 0,1,2,3,4<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; au-sydney,au-melbourne,au-<wbr>brisbane=
,au-canberra,au-<wbr>adelaide<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mgr ac=
tive: au-brisbane<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 osdmap e6284: 118 o=
sds: 117 up, 117 in; 22 remapped pgs<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0What is the status of the down+out osd? What=
 role did/does it<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0play? Most<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0importantly, is it osd.6?<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0flags<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0sortbitwise,require_jewel_<wbr>osds,require_=
kraken_osds<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0pgmap v272483=
0: 4096 pgs, 1 pools, 268 TB data, 197<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Mobjects<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0371 TB used, 267 TB / 638 TB avail<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A04073 active+clean<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A021 remapped+incomplete<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1 down+remapped<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1 active+clean+scrubbing+deep+<wbr>repair<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; #ceph osd dump | grep pool<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; pool 1 &#39;cdvr_ec&#39; erasure size 5=
 min_size 4 crush_ruleset 1<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0object_hash<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; rjenkins pg_num 4096 pgp_num 4096 last_=
change 456 flags<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; hashpspool,nodeep-scrub stripe_width 65=
536<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; Can you please suggest is there any way=
 to wipe out these<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0incomplete PG&#39;s.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0See the thread previously mentioned. Take no=
te of the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0force_create_pg step.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; Why ceph pg repair failed in this scene=
rio?<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; How to recover incomplete PG&#39;s to a=
ctive state.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; pg query for the affected PG ended with=
 this error. Can you<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0please explain<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; what is meant by this ?<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; ---<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0&quot;15(2)&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0&quot;66(1)&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0&quot;73(3)&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0&quot;103(4)&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0&quot;113(0)&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0],<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;down_osds_we_would_probe&quot;: [<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A06<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0],<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;peering_blocked_by&quot;: [],<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;peering_blocked_by_detail&quot;: [<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;detail&quot;:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;peering_blocked_by_history_<wbr>les_bo=
und&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; ----<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0During multiple intervals osd 6 was in the u=
p/acting set, for<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0example;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;first&quot;: 1608,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;last&quot;: 1645,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;maybe_went_rw&quot;: 1,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;up&quot;: [<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 113,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 6,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 15,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 73,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 103<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ],<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;acting&quot;: [<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 113,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 6,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 15,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 73,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 103<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ],<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;primary&quot;: 113,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;up_primary&quot;: 113<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 },<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Because we may have gone rw during that inte=
rval we need to<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0query it and it is blocking progress.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &q=
uot;blocked_by&quot;: [<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 6<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ],=
<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Setting osd_find_best_info_ignore_<wbr>histo=
ry_les to true may help<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0but then you may<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0need to mark the missing OSD lost or perform=
 some other trickery<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0(and this . I<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0suspect your min_size is too low, especially=
 for a cluster of<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0this size, but EC<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0is not an area I know extensively so I can&#=
39;t say definitively.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Some of your<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0questions may be better suited to the ceph-d=
evel mailing list by<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0the way.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; Attaching &quot;ceph pg 1.e4b query &gt=
; /tmp/1.e4b-pg.txt&quot; file with<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0this mail.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; Thanks<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; ______________________________<wbr>____=
_____________<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; ceph-users mailing list<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; <a href=3D"mailto:ceph-users-idqoXFIVOFLXfrYAhh+zQw@public.gmane.org=
.com">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; <a href=3D"http://lists.ceph.com/listin=
fo.cgi/ceph-users-ceph.com" rel=3D"noreferrer" target=3D"_blank">http://lis=
ts.ceph.com/<wbr>listinfo.cgi/ceph-users-ceph.<wbr>com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0--<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Cheers,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Brad<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; </div></div></blockquote></div><br></div>

--f40304378b002f287b054c549f11--

--===============2073371407==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============2073371407==--
