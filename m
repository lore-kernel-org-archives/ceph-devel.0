From: Gregory Farnum <greg-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Flapping osd / continuously reported as failed
Date: Tue, 23 Jul 2013 15:12:59 -0700
Message-ID: <CAPYLRzjGDep1ny6K-Ctz_7VG4THV6nAx9odOdjr=WNNesV4cVA@mail.gmail.com>
References: <0D057B737C42FC4AB3F22773A5C9425F259DBDEDD0@MXMBON06.grupa.onet>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <0D057B737C42FC4AB3F22773A5C9425F259DBDEDD0-K9pFWFEelezFe27LHpJFGNHuzzzSOjJt@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: =?ISO-8859-2?Q?Studzi=F1ski_Krzysztof?= <krzysztof.studzinski-Yw1TE0hTT7dz6jiHbVrK7g@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, Mostowiec Dominik <Dominik.Mostowiec-Yw1TE0hTT7dz6jiHbVrK7g@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Tue, Jul 23, 2013 at 2:50 PM, Studzi=F1ski Krzysztof
<krzysztof.studzinski-Yw1TE0hTT7dz6jiHbVrK7g@public.gmane.org> wrote:
> Hi,
> We've got some problem with our cluster - it continuously reports failed =
one osd and after auto-rebooting everything seems to work fine for some tim=
e (few minutes). CPU util of this osd is max 8%, iostat is very low. We tri=
ed to "ceph osd out" such flapping osd, but after recovering this behavior =
returned on different osd. This osd has also much more read operations than=
 others (see file osd_reads.png linked at the bottom of the email; at about=
 16:00 we switched off osd.57 and osd.72 started to misbehave. Osd.108 work=
s while recovering).
>
> Extract from ceph.log:
>
> 2013-07-23 22:43:57.425839 mon.0 10.177.64.4:6789/0 24690 : [INF] osd.72 =
10.177.64.8:6803/22584 boot
> 2013-07-23 22:43:56.298467 osd.72 10.177.64.8:6803/22584 415 : [WRN] map =
e41730 wrongly marked me down
> 2013-07-23 22:50:27.572110 mon.0 10.177.64.4:6789/0 25081 : [DBG] osd.72 =
10.177.64.8:6803/22584 reported failed by osd.9 10.177.64.4:6946/5124
> 2013-07-23 22:50:27.595044 mon.0 10.177.64.4:6789/0 25082 : [DBG] osd.72 =
10.177.64.8:6803/22584 reported failed by osd.78 10.177.64.5:6854/5604
> 2013-07-23 22:50:27.611964 mon.0 10.177.64.4:6789/0 25083 : [DBG] osd.72 =
10.177.64.8:6803/22584 reported failed by osd.10 10.177.64.4:6814/26192
> 2013-07-23 22:50:27.612009 mon.0 10.177.64.4:6789/0 25084 : [INF] osd.72 =
10.177.64.8:6803/22584 failed (3 reports from 3 peers after 2013-07-23 22:5=
0:43.611939 >=3D grace 20.000000)
> 2013-07-23 22:50:30.367398 7f8adb837700  0 log [WRN] : 3 slow requests, 3=
 included below; oldest blocked for > 30.688891 secs
> 2013-07-23 22:50:30.367408 7f8adb837700  0 log [WRN] : slow request 30.68=
8891 seconds old, received at 2013-07-23 22:49:59.678453: sd_op(client.4429=
0048.0:125899 .dir.4168.2 [call rgw.bucket_prepare_op] 3.9447554d) v4 curre=
ntly no flag points reached
> 2013-07-23 22:50:30.367412 7f8adb837700  0 log [WRN] : slow request 30.17=
9044 seconds old, received at 2013-07-23 22:50:00.188300: sd_op(client.4420=
5530.0:189270 .dir.4168.2 [call rgw.bucket_list] 3.9447554d) v4 currently n=
o flag points reached
> 2013-07-23 22:50:30.367415 7f8adb837700  0 log [WRN] : slow request 30.17=
1968 seconds old, received at 2013-07-23 22:50:00.195376: sd_op(client.4420=
3484.0:192902 .dir.4168.2 [call rgw.bucket_list] 3.9447554d) v4 currently n=
o flag points reached
> 2013-07-23 22:51:36.082303 mon.0 10.177.64.4:6789/0 25159 : [INF] osd.72 =
10.177.64.8:6803/22584 boot
> 2013-07-23 22:51:35.238164 osd.72 10.177.64.8:6803/22584 420 : [WRN] map =
e41738 wrongly marked me down
> 2013-07-23 22:52:05.582969 mon.0 10.177.64.4:6789/0 25191 : [DBG] osd.72 =
10.177.64.8:6803/22584 reported failed by osd.20 10.177.64.4:6913/4101
> 2013-07-23 22:52:05.587388 mon.0 10.177.64.4:6789/0 25192 : [DBG] osd.72 =
10.177.64.8:6803/22584 reported failed by osd.9 10.177.64.4:6946/5124
> 2013-07-23 22:52:05.610925 mon.0 10.177.64.4:6789/0 25193 : [DBG] osd.72 =
10.177.64.8:6803/22584 reported failed by osd.78 10.177.64.5:6854/5604
> 2013-07-23 22:52:05.610951 mon.0 10.177.64.4:6789/0 25194 : [INF] osd.72 =
10.177.64.8:6803/22584 failed (3 reports from 3 peers after 2013-07-23 22:5=
2:20.610895 >=3D grace 20.000000)
> 2013-07-23 22:52:05.630821 mon.0 10.177.64.4:6789/0 25195 : [DBG] osd.72 =
10.177.64.8:6803/22584 reported failed by osd.10 10.177.64.4:6814/26192
> 2013-07-23 22:53:47.203352 mon.0 10.177.64.4:6789/0 25300 : [INF] osd.72 =
10.177.64.8:6803/22584 boot
> 2013-07-23 22:53:46.417106 osd.72 10.177.64.8:6803/22584 474 : [WRN] map =
e41742 wrongly marked me down
>
> Could you please take a look at our config and suggest some improvements?
> See attached "ceph pg <pg_id> query" for two groups during recovery and p=
arts of our config file.
> Our cluster's size: 6 hosts, 26 HDD each, 156 osds, 6488 pgs, mostly in o=
ne bucket having 9M objects, 3342 GB data, 11173 GB used, 31690 GB / 42864 =
GB avail.

I'm surprised you're running into it at 9m objects but this is almost
certainly the problem. Right now the index for each RGW bucket lives
on a single OSD; you're probably having issues with whichever OSD is
receiving the bucket index reads. Is it feasible for you to shard the
contents into multiple buckets and see if things calm down?
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
