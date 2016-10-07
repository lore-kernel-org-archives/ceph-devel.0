From: =?UTF-8?Q?Pawe=c5=82_Sadowski?= <ceph-Bj5ZXqqQV65mR6Xm/wNWPw@public.gmane.org>
Subject: Re: unfound objects blocking cluster, need help!
Date: Fri, 7 Oct 2016 09:07:47 +0200
Message-ID: <49675cc7-d2fa-c181-bc6a-f599472b5275@sadziu.pl>
References: <CAHMzCM09p3zAsFrE8yDEhRRBEOZNgx62EchubRxFj29Xd3-W=Q@mail.gmail.com>
	<CAHMzCM1C=cjGwV5nhNcR7S8zPMEe42Xf+aQACrtDsg6CcaFXPg@mail.gmail.com>
	<CABZ+qqnbTMDQu9MWEwFFWDN6Rr0QPF8HCaG+JG5G47B592JpqA@mail.gmail.com>
Reply-To: ceph-Bj5ZXqqQV65mR6Xm/wNWPw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CABZ+qqnbTMDQu9MWEwFFWDN6Rr0QPF8HCaG+JG5G47B592JpqA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

Hi,

I work with Tomasz and I'm investigating this situation. We still don't
fully understood why there was unfound object after removing single OSD.
From logs[1] it looks like all PGs were active+clean before marking that
OSD out. After that backfills started on multiple OSDs. Three minutes
later our robot removed that OSD from cluster. Before removing OSD there
were some PGs marked as degraded. And we ended up with some PGs
degraded+undersized and with unfound objects. During whole event there
were some slow requests related to this OSD -- that's why we decided to
get rid of it.

Then, after a while whole cluster seems to be blocked -- those unfound
objects were blocking recovery and client operations -- we only got
something like 10% of normal traffic. It looks like this was caused by
OSD with unfound objects -- there is throttling mechanism in OSD which
will by default allow only 100 messages. If there are some unfound
objects and many client requests for it it will completely block that
OSD after a while with all ops "waiting for missing object"[2]. In this
state it's not possible to query PG, even do 'ceph tell osd.X version'.
Restarting OSD will give a chance to execute 'pg query' or
'make_unfound_lost revert|delete' before throttle limit will be reached.
It's also possible to increase that limit by setting
'osd_client_message_cap' in config file (option not documented in docs).

I was able to reproduce blocking on throttling limit on Hammer (0.94.5
and 0.94.9) and Jewel (10.2.3). This looks like a bug - client
operations are blocking recovery process/admin tools.

1:

2016-10-01 07:25:05 - mon.0 10.97.212.2:6789/0 8690339 : cluster [INF]
pgmap v31174228: 10432 pgs: 10432 active+clean; 141 TB data, 423 TB
used, 807 TB / 1231 TB avail; 83202 kB/s rd, 144 MB/s wr, 8717
op/s                          <-- cluster seems ok
2016-10-01 07:25:06 - mon.0 10.97.212.2:6789/0 8690341 : cluster [INF]
osdmap e696136: 227 osds: 227 up, 226 in     <-- ceph osd out
2016-10-01 07:28:47 - mon.0 10.97.212.2:6789/0 8691212 : cluster [INF]
pgmap v31174433: 10432 pgs: 4 active+recovery_wait+degraded+remapped, 9
activating+degraded+remapped, 10301 active+clean, 59
active+remapped+wait_backfill, 19 activating+remapped, 38
active+remapped+backfilling, 2 active+recovering+degraded; 141 TB data,
421 TB used, 803 TB / 1225 TB avail; 4738 kB/s rd, 19025 kB/s wr, 2006
op/s; 1863/125061398 objects degraded (0.001%); 1211382/125061398
objects misplaced (0.969%); 994 MB/s, 352 objects/s recovering
2016-10-01 07:28:47 - mon.0 10.97.212.2:6789/0 8691232 : cluster [INF]
osd.87 marked itself down                    <-- osd down
2016-10-01 07:28:41 - osd.102 10.99.208.134:6801/77524 6820 : cluster
[WRN] slow request 30.664042 seconds old, received at 2016-10-01
07:28:11.248835: osd_op(client.458404438.0:13798725
rbd_data.e623422ae8944a.0000000000000d49 [write 786432~8192] 3.abb76dbb
snapc 9256b=[] ack+ondisk+write+known_if_redirected e696155) currently
waiting for subops from 5,54,87,142
2016-10-01 07:28:54 - mon.0 10.97.212.2:6789/0 8691266 : cluster [INF]
pgmap v31174439: 10432 pgs: 3
stale+active+recovery_wait+degraded+remapped, 9
stale+activating+degraded+remapped, 11
stale+active+remapped+wait_backfill, 10301 active+clean, 49
active+remapped+wait_backfill, 1
active+recovering+undersized+degraded+remapped, 17 activating+remapped,
39 active+remapped+backfilling, 2 active+recovering+degraded; 141 TB
data, 421 TB used, 803 TB / 1225 TB avail; 85707 kB/s rd, 139 MB/s wr,
6271 op/s; 6326/125057026 objects degraded (0.005%); 1224087/125057026
objects misplaced (0.979%); 1/41406770 unfound (0.000%) <-- first unfound

full log:
https://gist.githubusercontent.com/anonymous/0336ea26c7c165e20ae75fbe03204d19/raw/9f5053e91ec5ae10bfb614033c924fe2361a116e/ceph_log

2:
# ceph --admin-daemon /var/run/ceph/*.asok dump_ops_in_flight
        {
            "description": "osd_op(client.176998.0:2805522
rbd_data.24d2b238e1f29.000000000000182f [set-alloc-hint object_size
4194304 write_size 4194304,write 2662400~4096] 2.62ea5cd0
ack+ondisk+write+known_if_redirected e1919)",
            "initiated_at": "2016-10-06 07:19:45.650089",
            "age": 647.394210,
            "duration": 0.003584,
            "type_data": [
                "delayed",
                {
                    "client": "client.176998",
                    "tid": 2805522
                },
                [
                    {
                        "time": "2016-10-06 07:19:45.650089",
                        "event": "initiated"
                    },
                    {
                        "time": "2016-10-06 07:19:45.653667",
                        "event": "reached_pg"
                    },
                    {
                        "time": "2016-10-06 07:19:45.653673",
                        "event": "waiting for missing object"
                    }
                ]
            ]
        }

3:
# ceph --admin-daemon /var/run/ceph/*.asok perf dump | grep -A 20
"throttle-osd_client_messages"
    "throttle-osd_client_messages": {
        "val": 100,
        "max": 100,
        "get": 1739,
        "get_sum": 1739,
        "get_or_fail_fail": 0,
        "get_or_fail_success": 0,
        "take": 0,
        "take_sum": 0,
        "put": 1639,
        "put_sum": 1639,
        "wait": {
            "avgcount": 1511,
            "sum": 1139.416916927
        }
    }
}


On 10/02/2016 10:22 AM, Dan van der Ster wrote:
>
> Hi,
>
> Do you understand why removing that osd led to unfound objects? Do you
> have the ceph.log from yesterday?
>
> Cheers, Dan
>
> On 2 Oct 2016 10:18, "Tomasz Kuzemko" <tomasz-K/miwsqi6UvR7s880joybQ@public.gmane.org
> <mailto:tomasz-K/miwsqi6UvR7s880joybQ@public.gmane.org>> wrote:
> >
> > Forgot to mention Ceph version - 0.94.5.
> >
> > I managed to fix this. By chance I found that when an OSD for a
> blocked PG is starting, there is a few-second time window (after
> load_pgs) in which it accepts commands related to the blocked PG. So
> first I managed to capture "ceph pg PGID query" this way. Then I tried
> to issue "ceph pg missing_lost delete" and it worked too. After
> deleting all unfound objects this way cluster finally unblocked.
> Before that I exported all blocked PGs so hopefully I will be able to
> recover those 17 objects to a near-latest state.
> >
> > Hope this helps anyone who might run into the same problem.
> >
> >
> > 2016-10-01 14:27 GMT+02:00 Tomasz Kuzemko <tomasz-K/miwsqi6UvR7s880joybQ@public.gmane.org
> <mailto:tomasz-K/miwsqi6UvR7s880joybQ@public.gmane.org>>:
> >>
> >> Hi,
> >>
> >> I have a production cluster on which 1 OSD on a failing disk was
> slowing the whole cluster down. I removed the OSD (osd.87) like usual
> in such case but this time it resulted in 17 unfound objects. I no
> longer have the files from osd.87. I was able to call "ceph pg PGID
> mark_unfound_lost delete" on 10 of those objects.
> >>
> >> On the remaining objects 7 the command blocks. When I try to do
> "ceph pg  PGID query" on this PG it also blocks. I suspect this is
> same reason why mark_unfound blocks.
> >>
> >> Other client IO to PGs that have unfound objects are also blocked.
> When trying to query the OSDs which has the PG with unfound objects,
> "ceph tell" blocks.
> >>
> >> I tried to mark the PG as complete using ceph-objectstore-tool but
> it did not help as the PG is in fact complete but for some reason blocks.
> >>
> >> I tried recreating an empty osd.87 and importing the PG exported
> from other replica but it did not help.
> >>
> >> Can someone help me please? This is really important.
> >>
> >> ceph pg dump:
> >>
> https://gist.github.com/anonymous/c0622ef0d8c0ac84e0778e73bad3c1af/raw/206a06e674ed1c870bbb09bb75fe4285a8e20ba4/pg-dump
> >>
> >> ceph osd dump:
> >>
> https://gist.github.com/anonymous/64e237d85016af6bd7879ef272ca5639/raw/d6fceb9acd206b75c3ce59c60bcd55a47dea7acd/osd-dump
> >>
> >> ceph health detail:
> >>
> https://gist.github.com/anonymous/ddb27863ecd416748ebd7ebbc036e438/raw/59ef1582960e011f10cbdbd4ccee509419b95d4e/health-detail
> >>
> >>
> >> --
> >> Pozdrawiam,
> >> Tomasz Kuzemko
> >> tomasz-K/miwsqi6UvR7s880joybQ@public.gmane.org <mailto:tomasz-K/miwsqi6UvR7s880joybQ@public.gmane.org>
> >
> >
> >
> >
> > --
> > Pozdrawiam,
> > Tomasz Kuzemko
> > tomasz-K/miwsqi6UvR7s880joybQ@public.gmane.org <mailto:tomasz-K/miwsqi6UvR7s880joybQ@public.gmane.org>
> >
> > _______________________________________________
> > ceph-users mailing list
> > ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
> > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> >
>
>
>
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
