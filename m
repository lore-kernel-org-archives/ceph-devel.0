From: Vasu Kulkarni <vakulkar-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: HELP! --> CLUSER DOWN (was "v13.2.1 Mimic
 released")
Date: Sat, 28 Jul 2018 18:15:07 -0700
Message-ID: <CAKPXa=ZLDi17fnf5gq0RfGPp_RGoFWQ7EutbqPuJ7OoJte=G_w@mail.gmail.com>
References: <alpine.DEB.2.11.1807271924250.15688@piezo.novalocal>
 <086B2EB1-4349-4694-856C-ECA50FBF6211@godaddy.com>
 <trinity-977054d3-80b8-4be9-9a69-009e8b25c718-1532789176388@3c-app-gmx-bs12>
 <422702b2-35c6-413e-bb9f-506921ccb3fc@email.android.com>
 <trinity-331a4fa8-ed1e-4a06-8e8f-0b2519cf5904-1532813725473@3c-app-gmx-bs14>
 <trinity-ac10e367-ef5e-458d-b5aa-d1d671b3a5c7-1532826164122@3c-app-gmx-bs02>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <trinity-ac10e367-ef5e-458d-b5aa-d1d671b3a5c7-1532826164122@3c-app-gmx-bs02>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: ceph.novice-k4R3PER4nllwCEqMux5wBA@public.gmane.org
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, Ceph Development <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Sat, Jul 28, 2018 at 6:02 PM,  <ceph.novice-k4R3PER4nllwCEqMux5wBA@public.gmane.org> wrote:
> Have you guys changed something with the systemctl startup of the OSDs?
I think there is some kind of systemd issue hidden in mimic,
https://tracker.ceph.com/issues/25004

>
> I've stopped and disabled all the OSDs on all my hosts via "systemctl stop|disable ceph-osd.target" and rebooted all the nodes. Everything look just the same.
> The I started all the OSD daemons one after the other via the CLI with "/usr/bin/ceph-osd -f --cluster ceph --id $NR --setuser ceph --setgroup ceph > /tmp/osd.${NR}.log 2>&1 & " and now everything (ok, beside the ZABBIX mgr module?!?) seems to work :|
>
>
>   cluster:
>     id:     2a919338-4e44-454f-bf45-e94a01c2a5e6
>     health: HEALTH_WARN
>             Failed to send data to Zabbix
>
>   services:
>     mon: 3 daemons, quorum sds20,sds21,sds22
>     mgr: sds22(active), standbys: sds20, sds21
>     osd: 18 osds: 18 up, 18 in
>     rgw: 4 daemons active
>
>   data:
>     pools:   25 pools, 1390 pgs
>     objects: 2.55 k objects, 3.4 GiB
>     usage:   26 GiB used, 8.8 TiB / 8.8 TiB avail
>     pgs:     1390 active+clean
>
>   io:
>     client:   11 KiB/s rd, 10 op/s rd, 0 op/s wr
>
> Any hints?
>
> ----------------------------------------------------------------------
>
>
> Gesendet: Samstag, 28. Juli 2018 um 23:35 Uhr
> Von: ceph.novice-k4R3PER4nllwCEqMux5wBA@public.gmane.org
> An: "Sage Weil" <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
> Cc: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Betreff: Re: [ceph-users] HELP! --> CLUSER DOWN (was "v13.2.1 Mimic released")
> Hi Sage.
>
> Sure. Any specific OSD(s) log(s)? Or just any?
>
> Gesendet: Samstag, 28. Juli 2018 um 16:49 Uhr
> Von: "Sage Weil" <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
> An: ceph.novice-k4R3PER4nllwCEqMux5wBA@public.gmane.org, ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Betreff: Re: [ceph-users] HELP! --> CLUSER DOWN (was "v13.2.1 Mimic released")
>
> Can you include more or your osd log file?
>
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
