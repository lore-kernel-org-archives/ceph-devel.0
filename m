From: Karan Singh <karan.singh-Gn+qtVAUx6s@public.gmane.org>
Subject: Production Ceph :: PG data lost : Cluster PG
	incomplete, inactive, unclean
Date: Fri, 20 Mar 2015 13:16:42 +0200
Message-ID: <7ED97A92-F91D-40BC-B2E9-30A7D1AB8AC6@csc.fi>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Content-Type: multipart/mixed; boundary="===============0390095315=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ceph Community <ceph-community-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org


--===============0390095315==
Content-Type: multipart/signed; boundary="Apple-Mail=_10EBE662-0350-4BEE-AD39-6AD1A827555F"; protocol="application/pkcs7-signature"; micalg=sha1


--Apple-Mail=_10EBE662-0350-4BEE-AD39-6AD1A827555F
Content-Type: multipart/alternative;
	boundary="Apple-Mail=_03BF1528-30DB-4561-8F1B-012110CA12B3"


--Apple-Mail=_03BF1528-30DB-4561-8F1B-012110CA12B3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hello Guys

My CEPH cluster lost data and not its not recovering. This problem =
occurred when Ceph performed recovery when one of the node was down.=20
Now all the nodes are up but Ceph is showing PG as incomplete , unclean =
, recovering.


I have tried several things to recover them like , scrub , deep-scrub , =
pg repair , try changing primary affinity and then scrubbing , =
osd_pool_default_size etc. BUT NO LUCK

Could yo please advice , how to recover PG and achieve HEALTH_OK

# ceph -s
    cluster 2bd3283d-67ef-4316-8b7e-d8f4747eae33
     health HEALTH_WARN 19 pgs incomplete; 3 pgs recovering; 20 pgs =
stuck inactive; 23 pgs stuck unclean; 2 requests are blocked > 32 sec; =
recovery 531/980676 objects degraded (0.054%); 243/326892 unfound =
(0.074%)
     monmap e3: 3 mons at =
{xxx=3Dxxxx:6789/0,xxx=3Dxxxx:6789:6789/0,xxx=3Dxxxx:6789:6789/0}, =
election epoch 1474, quorum 0,1,2 xx,xx,xx
     osdmap e261536: 239 osds: 239 up, 238 in
      pgmap v415790: 18432 pgs, 13 pools, 2330 GB data, 319 kobjects
            20316 GB used, 844 TB / 864 TB avail
            531/980676 objects degraded (0.054%); 243/326892 unfound =
(0.074%)
                   1 creating
               18409 active+clean
                   3 active+recovering
                  19 incomplete




# ceph pg dump_stuck unclean
ok
pg_stat	objects	mip	degr	unf	bytes	log	disklog	state	=
state_stamp	v	reported	up	up_primary	acting	=
acting_primary	last_scrub	scrub_stamp	last_deep_scrub	=
deep_scrub_stamp
10.70	0	0	0	0	0	0	0	=
incomplete	2015-03-20 12:19:49.534911	0'0	261536:1015	=
[153,140,80]	153	[153,140,80]	153	0'0	2015-03-12 =
17:59:43.275049	0'0	2015-03-09 17:55:58.745662
3.dde	68	66	0	66	552861709	297	297	=
incomplete	2015-03-20 12:19:49.584839	33547'297	=
261536:228352	[174,5,179]	174	[174,5,179]	174	=
33547'297	2015-03-12 14:19:15.261595	28522'43	=
2015-03-11 14:19:13.894538
5.a2	0	0	0	0	0	0	0	=
incomplete	2015-03-20 12:19:49.560756	0'0	261536:897	=
[214,191,170]	214	[214,191,170]	214	0'0	2015-03-12 =
17:58:29.257085	0'0	2015-03-09 17:55:07.684377
13.1b6	0	0	0	0	0	0	0	=
incomplete	2015-03-20 12:19:49.846253	0'0	261536:1050	=
[0,176,131]	0	[0,176,131]	0	0'0	2015-03-12 =
18:00:13.286920	0'0	2015-03-09 17:56:18.715208
7.25b	16	0	0	0	67108864	16	16	=
incomplete	2015-03-20 12:19:49.639102	27666'16	=
261536:4777	[194,145,45]	194	[194,145,45]	194	27666'16	=
2015-03-12 17:59:06.357864	2330'3	2015-03-09 17:55:30.754522
5.19	0	0	0	0	0	0	0	=
incomplete	2015-03-20 12:19:49.742698	0'0	261536:25410	=
[212,43,131]	212	[212,43,131]	212	0'0	2015-03-12 =
13:51:37.777026	0'0	2015-03-11 13:51:35.406246
3.a2f	0	0	0	0	0	0	0	creating	=
2015-03-20 12:42:15.586372	0'0	0:0	[]	-1	[]	=
-1	0'0	0.000000	0'0	0.000000
7.298	0	0	0	0	0	0	0	=
incomplete	2015-03-20 12:19:49.566966	0'0	261536:900	=
[187,95,225]	187	[187,95,225]	187	27666'13	=
2015-03-12 17:59:10.308423	2330'4	2015-03-09 17:55:35.750109
3.a5a	77	87	261	87	623902741	325	325	=
active+recovering	2015-03-20 10:54:57.443670	33569'325	=
261536:182464	[150,149,181]	150	[150,149,181]	150	=
33569'325	2015-03-12 13:58:05.813966	28433'44	=
2015-03-11 13:57:53.909795
1.1e7	0	0	0	0	0	0	0	=
incomplete	2015-03-20 12:19:49.610547	0'0	261536:772	=
[175,182]	175	[175,182]	175	0'0	2015-03-12 =
17:55:45.203232	0'0	2015-03-09 17:53:49.694822
3.774	79	0	0	0	645136397	339	339	=
incomplete	2015-03-20 12:19:49.821708	33570'339	=
261536:166857	[162,39,161]	162	[162,39,161]	162	=
33570'339	2015-03-12 14:49:03.869447	2226'2	2015-03-09 =
13:46:49.783950
3.7d0	78	0	0	0	609222686	376	376	=
incomplete	2015-03-20 12:19:49.534004	33538'376	=
261536:182810	[117,118,177]	117	[117,118,177]	117	=
33538'376	2015-03-12 13:51:03.984454	28394'62	=
2015-03-11 13:50:58.196288
3.d60	0	0	0	0	0	0	0	=
incomplete	2015-03-20 12:19:49.647196	0'0	261536:833	=
[154,172,1]	154	[154,172,1]	154	33552'321	=
2015-03-12 13:44:43.502907	28356'39	2015-03-11 =
13:44:41.663482
4.1fc	0	0	0	0	0	0	0	=
incomplete	2015-03-20 12:19:49.610103	0'0	261536:1069	=
[70,179,58]	70	[70,179,58]	70	0'0	2015-03-12 =
17:58:19.254170	0'0	2015-03-09 17:54:55.720479
3.e02	72	0	0	0	585105425	304	304	=
incomplete	2015-03-20 12:19:49.564768	33568'304	=
261536:167428	[15,102,147]	15	[15,102,147]	15	=
33568'304	2015-03-16 10:04:19.894789	2246'4	2015-03-09 =
11:43:44.176331
8.1d4	0	0	0	0	0	0	0	=
incomplete	2015-03-20 12:19:49.614727	0'0	261536:19611	=
[126,43,174]	126	[126,43,174]	126	0'0	2015-03-12 =
14:34:35.258338	0'0	2015-03-12 14:34:35.258338
4.2f4	0	0	0	0	0	0	0	=
incomplete	2015-03-20 12:19:49.595109	0'0	261536:113791	=
[181,186,13]	181	[181,186,13]	181	0'0	2015-03-12 =
14:59:03.529264	0'0	2015-03-09 13:46:40.601301
3.52c	65	23	69	23	543162368	290	290	=
active+recovering	2015-03-20 10:51:43.664734	33553'290	=
261536:8431	[212,100,219]	212	[212,100,219]	212	=
33553'290	2015-03-13 11:44:26.396514	29686'103	=
2015-03-11 17:18:33.452616
3.e5a	76	70	0	0	623902741	325	325	=
incomplete	2015-03-20 12:19:49.552071	33569'325	=
261536:71248	[97,22,62]	97	[97,22,62]	97	=
33569'325	2015-03-12 13:58:05.813966	28433'44	=
2015-03-11 13:57:53.909795
8.3a0	0	0	0	0	0	0	0	=
incomplete	2015-03-20 12:19:49.615728	0'0	261536:173184	=
[62,14,178]	62	[62,14,178]	62	0'0	2015-03-12 =
13:52:44.546418	0'0	2015-03-12 13:52:44.546418
3.24e	0	0	0	0	0	0	0	=
incomplete	2015-03-20 12:19:49.591282	0'0	261536:1026	=
[103,14,90]	103	[103,14,90]	103	33556'272	=
2015-03-13 11:44:41.263725	2327'4	2015-03-09 17:54:43.675552
5.f7	0	0	0	0	0	0	0	=
incomplete	2015-03-20 12:19:49.667823	0'0	261536:853	=
[73,44,123]	73	[73,44,123]	73	0'0	2015-03-12 =
17:58:30.257371	0'0	2015-03-09 17:55:11.725629
3.ae8	77	67	201	67	624427024	342	342	=
active+recovering	2015-03-20 10:50:01.693979	33516'342	=
261536:149258	[122,144,218]	122	[122,144,218]	122	=
33516'342	2015-03-12 17:11:01.899062	29638'134	=
2015-03-11 17:10:59.966372
#


PG data is there on multiple OSD=E2=80=99s but Ceph is not recovering =
the PG , For Example

# ceph pg map 7.25b
osdmap e261536 pg 7.25b (7.25b) -> up [194,145,45] acting [194,145,45]


# ls -l /var/lib/ceph/osd/ceph-194/current/7.25b_head | wc -l
17

# ls -l /var/lib/ceph/osd/ceph-145/current/7.25b_head | wc -l
0
#

# ls -l /var/lib/ceph/osd/ceph-45/current/7.25b_head | wc -l
17





Some of the PG are completely lost , i.e they don=E2=80=99t have any =
data . For example=20

# ceph pg map 10.70
osdmap e261536 pg 10.70 (10.70) -> up [153,140,80] acting [153,140,80]


# ls -l /var/lib/ceph/osd/ceph-140/current/10.70_head | wc -l
0

# ls -l /var/lib/ceph/osd/ceph-153/current/10.70_head | wc -l
0

# ls -l /var/lib/ceph/osd/ceph-80/current/10.70_head | wc -l
0



- Karan -


--Apple-Mail=_03BF1528-30DB-4561-8F1B-012110CA12B3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dutf-8"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" =
class=3D""><div class=3D""><div class=3D"">Hello Guys</div><div =
class=3D""><br class=3D""></div><div class=3D"">My CEPH cluster lost =
data and not its not recovering. This problem occurred when Ceph =
performed recovery when one of the node was down.&nbsp;</div><div =
class=3D"">Now all the nodes are up but Ceph is showing PG as incomplete =
, unclean , recovering.</div><div class=3D""><br class=3D""></div><div =
class=3D""><br class=3D""></div><div class=3D"">I have tried several =
things to recover them like , <b class=3D"">scrub , deep-scrub , pg =
repair , try changing primary affinity and then scrubbing , =
osd_pool_default_size etc. BUT NO LUCK</b></div><div class=3D""><br =
class=3D""></div><div class=3D"">Could yo please advice , how to recover =
PG and achieve HEALTH_OK</div><div class=3D""><br class=3D""></div><div =
class=3D""># ceph -s</div><div class=3D"">&nbsp; &nbsp; cluster =
2bd3283d-67ef-4316-8b7e-d8f4747eae33</div><div class=3D"">&nbsp; &nbsp; =
&nbsp;health <b class=3D"">HEALTH_WARN 19 pgs incomplete; 3 pgs =
recovering; 20 pgs stuck inactive; 23 pgs stuck unclean</b>; 2 requests =
are blocked &gt; 32 sec; recovery 531/980676 objects degraded (0.054%); =
243/326892 unfound (0.074%)</div><div class=3D"">&nbsp; &nbsp; =
&nbsp;monmap e3: 3 mons at =
{xxx=3Dxxxx:6789/0,xxx=3Dxxxx:6789:6789/0,xxx=3Dxxxx:6789:6789/0}, =
election epoch 1474, quorum 0,1,2 xx,xx,xx</div><div class=3D"">&nbsp; =
&nbsp; &nbsp;osdmap e261536: 239 osds: 239 up, 238 in</div><div =
class=3D"">&nbsp; &nbsp; &nbsp; pgmap v415790: 18432 pgs, 13 pools, 2330 =
GB data, 319 kobjects</div><div class=3D"">&nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; 20316 GB used, 844 TB / 864 TB avail</div><div =
class=3D"">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 531/980676 objects =
degraded (0.054%); 243/326892 unfound (0.074%)</div><div class=3D"">&nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;1 =
creating</div><div class=3D"">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp;18409 active+clean</div><div class=3D"">&nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;3 =
active+recovering</div><div class=3D"">&nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 19 incomplete</div><div class=3D""><br =
class=3D""></div></div><div class=3D""><br class=3D""></div><div =
class=3D""><br class=3D""></div><div class=3D""><br class=3D""></div><div =
class=3D""><div class=3D""># ceph pg dump_stuck unclean</div><div =
class=3D"">ok</div><div class=3D"">pg_stat<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>objects<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>mip<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>degr<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>unf<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>bytes<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>log<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>disklog<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>state<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>state_stamp<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>v<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>reported<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>up<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>up_primary<span class=3D"Apple-tab-span" style=3D"white-space:pre">=
	</span>acting<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>acting_primary<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>last_scrub<span class=3D"Apple-tab-span" style=3D"white-space:pre">=
	</span>scrub_stamp<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>last_deep_scrub<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>deep_scrub_stamp</div><div class=3D"">10.70<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>incomplete<span class=3D"Apple-tab-span" style=3D"white-space:pre">=
	</span>2015-03-20 12:19:49.534911<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0'0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>261536:1015<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>[153,140,80]<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>153<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>[153,140,80]<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>153<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0'0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>2015-03-12 17:59:43.275049<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0'0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>2015-03-09 =
17:55:58.745662</div><div class=3D"">3.dde<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>68<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>66<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>66<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>552861709<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>297<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>297<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>incomplete<span class=3D"Apple-tab-span" style=3D"white-space:pre">=
	</span>2015-03-20 12:19:49.584839<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>33547'297<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>261536:228352<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>[174,5,179]<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>174<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>[174,5,179]<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>174<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>33547'297<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>2015-03-12 14:19:15.261595<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>28522'43<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>2015-03-11 14:19:13.894538</div><div class=3D"">5.a2<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>incomplete<span class=3D"Apple-tab-span" style=3D"white-space:pre">=
	</span>2015-03-20 12:19:49.560756<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0'0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>261536:897<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>[214,191,170]<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>214<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>[214,191,170]<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>214<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0'0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>2015-03-12 17:58:29.257085<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0'0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>2015-03-09 =
17:55:07.684377</div><div class=3D"">13.1b6<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>incomplete<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>2015-03-20 12:19:49.846253<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0'0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>261536:1050<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>[0,176,131]<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>[0,176,131]<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0'0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>2015-03-12 18:00:13.286920<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0'0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>2015-03-09 =
17:56:18.715208</div><div class=3D"">7.25b<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>16<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>67108864<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>16<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>16<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>incomplete<span class=3D"Apple-tab-span" style=3D"white-space:pre">=
	</span>2015-03-20 12:19:49.639102<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>27666'16<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>261536:4777<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>[194,145,45]<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>194<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>[194,145,45]<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>194<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>27666'16<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>2015-03-12 17:59:06.357864<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>2330'3<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>2015-03-09 17:55:30.754522</div><div class=3D"">5.19<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>incomplete<span class=3D"Apple-tab-span" style=3D"white-space:pre">=
	</span>2015-03-20 12:19:49.742698<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0'0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>261536:25410<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>[212,43,131]<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>212<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>[212,43,131]<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>212<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0'0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>2015-03-12 13:51:37.777026<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0'0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>2015-03-11 =
13:51:35.406246</div><div class=3D"">3.a2f<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>creating<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>2015-03-20 12:42:15.586372<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0'0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0:0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>[]<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>-1<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>[]<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>-1<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0'0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0.000000<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0'0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>0.000000</div><div class=3D"">7.298<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>incomplete<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>2015-03-20 12:19:49.566966<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0'0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>261536:900<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>[187,95,225]<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>187<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>[187,95,225]<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>187<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>27666'13<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>2015-03-12 17:59:10.308423<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>2330'4<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>2015-03-09 17:55:35.750109</div><div class=3D"">3.a5a<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>77<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>87<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>261<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>87<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>623902741<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>325<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>325<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>active+recovering<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>2015-03-20 10:54:57.443670<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>33569'325<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>261536:182464<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>[150,149,181]<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>150<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>[150,149,181]<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>150<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>33569'325<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>2015-03-12 13:58:05.813966<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>28433'44<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>2015-03-11 13:57:53.909795</div><div class=3D"">1.1e7<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>incomplete<span class=3D"Apple-tab-span" style=3D"white-space:pre">=
	</span>2015-03-20 12:19:49.610547<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0'0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>261536:772<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>[175,182]<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>175<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>[175,182]<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>175<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>0'0<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>2015-03-12 17:55:45.203232<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0'0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>2015-03-09 =
17:53:49.694822</div><div class=3D"">3.774<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>79<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>645136397<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>339<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>339<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>incomplete<span class=3D"Apple-tab-span" style=3D"white-space:pre">=
	</span>2015-03-20 12:19:49.821708<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>33570'339<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>261536:166857<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>[162,39,161]<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>162<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>[162,39,161]<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>162<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>33570'339<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>2015-03-12 14:49:03.869447<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>2226'2<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>2015-03-09 13:46:49.783950</div><div class=3D"">3.7d0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>78<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>609222686<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>376<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>376<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>incomplete<span class=3D"Apple-tab-span" style=3D"white-space:pre">=
	</span>2015-03-20 12:19:49.534004<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>33538'376<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>261536:182810<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>[117,118,177]<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>117<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>[117,118,177]<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>117<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>33538'376<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>2015-03-12 13:51:03.984454<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>28394'62<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>2015-03-11 13:50:58.196288</div><div class=3D"">3.d60<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>incomplete<span class=3D"Apple-tab-span" style=3D"white-space:pre">=
	</span>2015-03-20 12:19:49.647196<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0'0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>261536:833<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>[154,172,1]<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>154<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>[154,172,1]<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>154<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>33552'321<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>2015-03-12 13:44:43.502907<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>28356'39<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>2015-03-11 13:44:41.663482</div><div class=3D"">4.1fc<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>incomplete<span class=3D"Apple-tab-span" style=3D"white-space:pre">=
	</span>2015-03-20 12:19:49.610103<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0'0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>261536:1069<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>[70,179,58]<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>70<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>[70,179,58]<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>70<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0'0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>2015-03-12 17:58:19.254170<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0'0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>2015-03-09 =
17:54:55.720479</div><div class=3D"">3.e02<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>72<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>585105425<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>304<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>304<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>incomplete<span class=3D"Apple-tab-span" style=3D"white-space:pre">=
	</span>2015-03-20 12:19:49.564768<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>33568'304<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>261536:167428<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>[15,102,147]<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>15<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>[15,102,147]<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>15<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>33568'304<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>2015-03-16 10:04:19.894789<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>2246'4<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>2015-03-09 11:43:44.176331</div><div class=3D"">8.1d4<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>incomplete<span class=3D"Apple-tab-span" style=3D"white-space:pre">=
	</span>2015-03-20 12:19:49.614727<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0'0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>261536:19611<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>[126,43,174]<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>126<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>[126,43,174]<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>126<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0'0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>2015-03-12 14:34:35.258338<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0'0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>2015-03-12 =
14:34:35.258338</div><div class=3D"">4.2f4<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>incomplete<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>2015-03-20 12:19:49.595109<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0'0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>261536:113791<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>[181,186,13]<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>181<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>[181,186,13]<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>181<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0'0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>2015-03-12 14:59:03.529264<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0'0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>2015-03-09 =
13:46:40.601301</div><div class=3D"">3.52c<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>65<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>23<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>69<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>23<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>543162368<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>290<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>290<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>active+recovering<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>2015-03-20 10:51:43.664734<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>33553'290<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>261536:8431<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>[212,100,219]<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>212<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>[212,100,219]<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>212<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>33553'290<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>2015-03-13 11:44:26.396514<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>29686'103<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>2015-03-11 17:18:33.452616</div><div class=3D"">3.e5a<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>76<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>70<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>623902741<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>325<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>325<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>incomplete<span class=3D"Apple-tab-span" style=3D"white-space:pre">=
	</span>2015-03-20 12:19:49.552071<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>33569'325<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>261536:71248<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>[97,22,62]<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>97<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>[97,22,62]<span class=3D"Apple-tab-span" style=3D"white-space:pre">=
	</span>97<span class=3D"Apple-tab-span" style=3D"white-space:pre">=
	</span>33569'325<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>2015-03-12 13:58:05.813966<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>28433'44<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>2015-03-11 13:57:53.909795</div><div class=3D"">8.3a0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>incomplete<span class=3D"Apple-tab-span" style=3D"white-space:pre">=
	</span>2015-03-20 12:19:49.615728<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0'0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>261536:173184<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>[62,14,178]<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>62<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>[62,14,178]<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>62<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0'0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>2015-03-12 13:52:44.546418<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0'0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>2015-03-12 =
13:52:44.546418</div><div class=3D"">3.24e<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>incomplete<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>2015-03-20 12:19:49.591282<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0'0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>261536:1026<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>[103,14,90]<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>103<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>[103,14,90]<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>103<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>33556'272<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>2015-03-13 11:44:41.263725<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>2327'4<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>2015-03-09 17:54:43.675552</div><div class=3D"">5.f7<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>incomplete<span class=3D"Apple-tab-span" style=3D"white-space:pre">=
	</span>2015-03-20 12:19:49.667823<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0'0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>261536:853<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>[73,44,123]<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>73<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>[73,44,123]<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>73<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0'0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>2015-03-12 17:58:30.257371<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0'0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>2015-03-09 =
17:55:11.725629</div><div class=3D"">3.ae8<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>77<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>67<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>201<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>67<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>624427024<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>342<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>342<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>active+recovering<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>2015-03-20 10:50:01.693979<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>33516'342<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>261536:149258<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>[122,144,218]<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>122<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>[122,144,218]<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>122<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>33516'342<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>2015-03-12 17:11:01.899062<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>29638'134<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>2015-03-11 17:10:59.966372</div><div class=3D"">#</div></div><div =
class=3D""><br class=3D""></div><div class=3D""><br class=3D""></div><div =
class=3D"">PG data is there on multiple OSD=E2=80=99s but Ceph is not =
recovering the PG , For Example</div><div style=3D"font-size: 16px;" =
class=3D""><br class=3D""></div><div class=3D""><div class=3D""><font =
size=3D"3" class=3D""># ceph pg map 7.25b</font></div><div =
class=3D""><font size=3D"3" class=3D"">osdmap e261536 pg 7.25b (7.25b) =
-&gt; up [194,145,45] acting [194,145,45]</font></div><div class=3D""><br =
class=3D""></div></div><div class=3D""><br class=3D""></div><div =
class=3D""># ls -l /var/lib/ceph/osd/ceph-194/current/7.25b_head | wc =
-l</div><div class=3D"">17</div><div class=3D""><br class=3D""></div><div =
class=3D""><div class=3D""># ls -l =
/var/lib/ceph/osd/ceph-145/current/7.25b_head | wc -l</div><div =
class=3D"">0</div><div class=3D"">#</div></div><div class=3D""><br =
class=3D""></div><div class=3D""><div class=3D""># ls -l =
/var/lib/ceph/osd/ceph-45/current/7.25b_head | wc -l</div><div =
class=3D"">17</div></div><div class=3D""><br =
class=3D"webkit-block-placeholder"></div><div class=3D""><br =
class=3D""></div><div class=3D""><br class=3D""></div><div class=3D""><br =
class=3D""></div><div class=3D""><br class=3D""></div><div class=3D"">Some=
 of the PG are completely lost , i.e they don=E2=80=99t have any data . =
For example&nbsp;</div><div class=3D""><br class=3D""></div><div =
class=3D""><div class=3D""># ceph pg map 10.70</div><div class=3D"">osdmap=
 e261536 pg 10.70 (10.70) -&gt; up [153,140,80] acting =
[153,140,80]</div><div class=3D""><br class=3D""></div></div><div =
class=3D""><br class=3D"webkit-block-placeholder"></div><div =
class=3D""><div class=3D""># ls -l =
/var/lib/ceph/osd/ceph-140/current/10.70_head | wc -l</div><div =
class=3D"">0</div></div><div class=3D""><br class=3D""></div><div =
class=3D""><div class=3D""># ls -l =
/var/lib/ceph/osd/ceph-153/current/10.70_head | wc -l</div><div =
class=3D"">0</div></div><div class=3D""><br class=3D""></div><div =
class=3D""><div class=3D""># ls -l =
/var/lib/ceph/osd/ceph-80/current/10.70_head | wc -l</div><div =
class=3D"">0</div></div><div class=3D""><br =
class=3D"webkit-block-placeholder"></div><div class=3D""><br =
class=3D"webkit-block-placeholder"></div><div class=3D""><br =
class=3D"webkit-block-placeholder"></div><div =
apple-content-edited=3D"true" class=3D"">
<div style=3D"color: rgb(0, 0, 0); letter-spacing: normal; orphans: =
auto; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" =
class=3D""><div style=3D"color: rgb(0, 0, 0); letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" =
class=3D""><div style=3D"color: rgb(0, 0, 0); font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant: normal; font-weight: =
normal; letter-spacing: normal; line-height: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
word-wrap: break-word; -webkit-nbsp-mode: space; -webkit-line-break: =
after-white-space;" class=3D"">- Karan -</div></div></div>
</div>
<br class=3D""></body></html>=

--Apple-Mail=_03BF1528-30DB-4561-8F1B-012110CA12B3--

--Apple-Mail=_10EBE662-0350-4BEE-AD39-6AD1A827555F
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIOYjCCBJ0w
ggOFoAMCAQICEDQ96SusJzT/j8s0lPvMcFQwDQYJKoZIhvcNAQEFBQAwbzELMAkGA1UEBhMCU0Ux
FDASBgNVBAoTC0FkZFRydXN0IEFCMSYwJAYDVQQLEx1BZGRUcnVzdCBFeHRlcm5hbCBUVFAgTmV0
d29yazEiMCAGA1UEAxMZQWRkVHJ1c3QgRXh0ZXJuYWwgQ0EgUm9vdDAeFw0wNTA2MDcwODA5MTBa
Fw0yMDA1MzAxMDQ4MzhaMIGuMQswCQYDVQQGEwJVUzELMAkGA1UECBMCVVQxFzAVBgNVBAcTDlNh
bHQgTGFrZSBDaXR5MR4wHAYDVQQKExVUaGUgVVNFUlRSVVNUIE5ldHdvcmsxITAfBgNVBAsTGGh0
dHA6Ly93d3cudXNlcnRydXN0LmNvbTE2MDQGA1UEAxMtVVROLVVTRVJGaXJzdC1DbGllbnQgQXV0
aGVudGljYXRpb24gYW5kIEVtYWlsMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAsjmF
pPJ9q0E7YkY3rs3BYHW8OWX5ShpHornMSMxqmNVNNRm5pELlzkniii8efNIxB8dOtINknS4p1aJk
xIW9hVE1eaROaJB7HHqkkqgX8pgV8pPMyaQylbsMTzC9mKALi+VuG6JG+ni8om+rWV6lL8/K2m2q
L+usobNqqrcuZzWLeeEeaYji5kbNoKXqvgvOdjp6Dpvq/NonWz1zHyLmSGHGTPNpsaguG7bUMSAs
vIKKjqQOpdeJQ/wWWq8dcdcRWdq6hw2v+vPhwvCkxWeM1tZUOt4KpLoDd7NlyP0e03RiqhjKaJMe
oYV+9Udly/hNVyh00jT/MLbu9mIwFIws6wIDAQABo4H0MIHxMB8GA1UdIwQYMBaAFK29mHo0tCb3
+sQmVO8DveAky1QaMB0GA1UdDgQWBBSJgmd9xJ0mcABLtFBIfN49rgRufTAOBgNVHQ8BAf8EBAMC
AQYwDwYDVR0TAQH/BAUwAwEB/zARBgNVHSAECjAIMAYGBFUdIAAwRAYDVR0fBD0wOzA5oDegNYYz
aHR0cDovL2NybC51c2VydHJ1c3QuY29tL0FkZFRydXN0RXh0ZXJuYWxDQVJvb3QuY3JsMDUGCCsG
AQUFBwEBBCkwJzAlBggrBgEFBQcwAYYZaHR0cDovL29jc3AudXNlcnRydXN0LmNvbTANBgkqhkiG
9w0BAQUFAAOCAQEAAbyc42MosPMxAcLfe91ioAGdIzEPnJJzU1HqH0z61p/Eyi9nfngzD3QWuZGH
kfWKJvpkcADYHvkLBGJQh5OB1Nr1I9s0u4VWtHA0bniDNx6FHMURFZJfhxe9rGr98cLRzIlfsXzw
PlHyNfN87GCYazor4O/fs32G67Ub9VvsonyYE9cAULnRLXPeA3h04QWFMV7LmrmdlMa5lDd1ctxE
+2fo8PolHlKn2iXpR+CgxzygTrEKNvt3SJ/vl4r7tP7jlBSog7xcLT/SYHFg7sJxggzpiDbj2iC0
o6BsqpZLuICOdcpJB/Y7FLrf3AXZn9vgsuZNoHgm5+ctbn9fxh6IFTCCBNowggPCoAMCAQICEF3/
UOr+D1NGiJ+AQY/nQsgwDQYJKoZIhvcNAQEFBQAwga4xCzAJBgNVBAYTAlVTMQswCQYDVQQIEwJV
VDEXMBUGA1UEBxMOU2FsdCBMYWtlIENpdHkxHjAcBgNVBAoTFVRoZSBVU0VSVFJVU1QgTmV0d29y
azEhMB8GA1UECxMYaHR0cDovL3d3dy51c2VydHJ1c3QuY29tMTYwNAYDVQQDEy1VVE4tVVNFUkZp
cnN0LUNsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgRW1haWwwHhcNMDkwNTE4MDAwMDAwWhcNMjgx
MjMxMjM1OTU5WjBEMQswCQYDVQQGEwJOTDEPMA0GA1UEChMGVEVSRU5BMSQwIgYDVQQDExtURVJF
TkEgZVNjaWVuY2UgUGVyc29uYWwgQ0EwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDE
vCV9ze9ZBKt0Jym2Y4rvxDVwoUYIr25QmxtxeJcChcA1/5AYEWb6MzkUnqQS9z3uBSyB5/ctLjZ4
Qw45tn96dMPLVT8vs8vDN2rhlQMjG7MimBODWDBfrDyRRdNtCy7L0ZFhsspx+sKJDHsJ1pK/o4EX
EVUg3zeBnx4mCR3SFxlDy4uZJXRBW+YyKtCnU9zSIY3Nkc97bPTJ/tDl0gZrGmFCG4CRB9wUSSc7
Coqy4jtpCITLgZnXuhQf2H6SY732LTH6lU7NNg2Z7xG6rUr7qMR4uXxaPsj1CDLAqQXHjBoojzC6
F6PxueIHp7j7Vb+fYlrVFA8ItBOZ0hJ5WvD9AgMBAAGjggFbMIIBVzAfBgNVHSMEGDAWgBSJgmd9
xJ0mcABLtFBIfN49rgRufTAdBgNVHQ4EFgQUyIlzmaddURZTRVR8o8I5fMvXqoEwDgYDVR0PAQH/
BAQDAgEGMBIGA1UdEwEB/wQIMAYBAf8CAQAwJgYDVR0gBB8wHTANBgsrBgEEAbIxAQICHTAMBgoq
hkiG90wFAgIFMFgGA1UdHwRRME8wTaBLoEmGR2h0dHA6Ly9jcmwudXNlcnRydXN0LmNvbS9VVE4t
VVNFUkZpcnN0LUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kRW1haWwuY3JsMG8GCCsGAQUFBwEBBGMw
YTA4BggrBgEFBQcwAoYsaHR0cDovL2NydC51c2VydHJ1c3QuY29tL1VUTkFBQUNsaWVudF9DQS5j
cnQwJQYIKwYBBQUHMAGGGWh0dHA6Ly9vY3NwLnVzZXJ0cnVzdC5jb20wDQYJKoZIhvcNAQEFBQAD
ggEBAAgXpBz5FWuwGWFvoEjjeiTvQVWaoFBw2CPVU4ZKZ47o2lYWGCwbGCGJupgk7lY04xeGJr0h
WtQZk0rqYXRNtsSEjUfuyi5lbTaTmLHikmaI4k57dcdeRGkh3BJqMPxhgP4P8J3S3H6u5cJTTQtw
g2FWRfs933L2AkJ164iKmFdg9Z+ickmxej5BZzXDVSsNBzXoxivVuod5gHTnkja9RoF6Liniar7h
FxM1fBakJTMvYe7OyVLgQNvTvjlaz89MFOV/xUNXi025Wo7CDwZN3shJnYFzuuQ/mKWTPFlO25s1
3/5Nv1Wh6WTDRXysj3xH0TrxTnXZkGdA6LEvnhcvXDUwggTfMIIDx6ADAgECAhB37ILErqxVSnc1
ePJuNvJXMA0GCSqGSIb3DQEBBQUAMEQxCzAJBgNVBAYTAk5MMQ8wDQYDVQQKEwZURVJFTkExJDAi
BgNVBAMTG1RFUkVOQSBlU2NpZW5jZSBQZXJzb25hbCBDQTAeFw0xNDEwMzEwMDAwMDBaFw0xNTEx
MzAyMzU5NTlaMIGBMRMwEQYKCZImiZPyLGQBGRYDb3JnMRYwFAYKCZImiZPyLGQBGRYGdGVyZW5h
MRMwEQYKCZImiZPyLGQBGRYDdGNzMQswCQYDVQQGEwJGSTEMMAoGA1UEChMDQ1NDMSIwIAYDVQQD
FBlLYXJhbiBTaW5naCBrc2luZ2hAY3NjLmZpMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC
AQEAua9GMiJ0pEMcMKOmNjldVeaFJyc34XPDGw3hYcBicv68bX7Ov+7XP0+s1zA4vw7M/oK9GXWn
nojVY7jR30saS4Z+DpS/7gY3yp/tGLCXZAhtn8ehOwx32pgsMQVUV55L7U7AEcJ4cunuU9Gqf25z
yqN4y6yeTYw1k5+ny+a9qBJjQMSAWatYnNBBN7BFawzL1a9/VnPvy7IkhKzQfAS6lCiuvxDZvG/z
tr1RgDXyX0JVya0B8XHO2wU3xVrJtF3K4g2I9DSYR05X2sjHa6wiXFvItZriQz2AjE6dOmvRW53E
4U5AyQRaY06oy5HlN9IaINKJ3WVf+5il9JoAZN68gwIDAQABo4IBjTCCAYkwHwYDVR0jBBgwFoAU
yIlzmaddURZTRVR8o8I5fMvXqoEwHQYDVR0OBBYEFMz+qQQcnAbKsqYs4UdOaFeQVxyYMA4GA1Ud
DwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMB0GA1UdJQQWMBQGCCsGAQUFBwMEBggrBgEFBQcDAjAm
BgNVHSAEHzAdMA0GCysGAQQBsjEBAgIdMAwGCiqGSIb3TAUCAgUwRwYDVR0fBEAwPjA8oDqgOIY2
aHR0cDovL2NybC50Y3MudGVyZW5hLm9yZy9URVJFTkFlU2NpZW5jZVBlcnNvbmFsQ0EuY3JsMHoG
CCsGAQUFBwEBBG4wbDBCBggrBgEFBQcwAoY2aHR0cDovL2NydC50Y3MudGVyZW5hLm9yZy9URVJF
TkFlU2NpZW5jZVBlcnNvbmFsQ0EuY3J0MCYGCCsGAQUFBzABhhpodHRwOi8vb2NzcC50Y3MudGVy
ZW5hLm9yZzAdBgNVHREEFjAUgRJrYXJhbi5zaW5naEBjc2MuZmkwDQYJKoZIhvcNAQEFBQADggEB
AKCP9egRCcShcjER4mSD0ziLoVVML8PF/NxEAG3x05LBSB/dSORR4qOz4RSQLRFOYCikc2RFjPrA
eQysx0KDp41tatPwmYgOrhcOaBVRhlvM4XpLLaqtDGTPzMrQQBDwAMaxIit2c4WtJ7EJippoWC8y
f/Xfs/ltDhD3FWsu+WSROHKRh1Cilix/03kk0f7qFjNZsEutSyo2tTeJgZwBUCLiWFMUBnqXESBJ
ZEnAPae4cKlpoTK+ib7njo5ePf7FFZBiLJgmCO3rGDU4NKgxCr25JmNVtxbaBz9jvag6eNoBsz7t
reCdKGTaqRvCK4fvpG1QhP3/73Ao0ZkqsDznIXoxggK0MIICsAIBATBYMEQxCzAJBgNVBAYTAk5M
MQ8wDQYDVQQKEwZURVJFTkExJDAiBgNVBAMTG1RFUkVOQSBlU2NpZW5jZSBQZXJzb25hbCBDQQIQ
d+yCxK6sVUp3NXjybjbyVzAJBgUrDgMCGgUAoIIBMTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0xNTAzMjAxMTE2NDNaMCMGCSqGSIb3DQEJBDEWBBTgY+TCqvZBkvnp
TPxY4rfID6F0bjBnBgkrBgEEAYI3EAQxWjBYMEQxCzAJBgNVBAYTAk5MMQ8wDQYDVQQKEwZURVJF
TkExJDAiBgNVBAMTG1RFUkVOQSBlU2NpZW5jZSBQZXJzb25hbCBDQQIQd+yCxK6sVUp3NXjybjby
VzBpBgsqhkiG9w0BCRACCzFaoFgwRDELMAkGA1UEBhMCTkwxDzANBgNVBAoTBlRFUkVOQTEkMCIG
A1UEAxMbVEVSRU5BIGVTY2llbmNlIFBlcnNvbmFsIENBAhB37ILErqxVSnc1ePJuNvJXMA0GCSqG
SIb3DQEBAQUABIIBAJEjBqUo4raIEOIQ6JmSoO05+wriDmsaMGJDJ29+P9HiV5OVhXMsqxsRKUtI
ox0CDM7xIZPj0cNPh+fXUrJIl6M7UZlb7WPTCpcolpeIglrrZnfxUglEvyq8uNVkasszL0B1TBoJ
EiY/63j5GX3lAk7Zi9UJD/2soXBafUPGbi1Ge+4CKXfL4LlhO1HVG2dCOjxkjEH0iam09Eeu1fMA
rr/+dCHHfuHIkPR5sV4HavK69cjWGn0g40ELJSuRbDqyOQP9rFT84pPYq7euRFfEdXuT4S4zt1kp
YxLRFZ/4+zeGYzZ80JcVFQGeENbJRso1D2nEBOq7RM/Vs5D5xXslkO8AAAAAAAA=
--Apple-Mail=_10EBE662-0350-4BEE-AD39-6AD1A827555F--

--===============0390095315==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0390095315==--
