From: =?UTF-8?B?RnLDqWTDqXJpYyBOYXNz?= <frederic.nass-mHc8WM8rKNgDTEWcYJR2Ng@public.gmane.org>
Subject: Re: stalls caused by scrub on jewel
Date: Thu, 1 Dec 2016 16:24:43 +0100
Message-ID: <67e859f3-1aa6-e4b5-06b5-664583f668f1@univ-lorraine.fr>
References: <alpine.DEB.2.11.1611152232260.2650@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.11.1611152232260.2650-ie3vfNGmdjePKud3HExfWg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, ceph-users-Qp0mS5GaXlQ@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org


Hi Sage, Sam,

We're impacted by this bug (case 01725311). Our cluster is running RHCS =

2.0 and is no more capable to scrub neither deep-scrub.

[1] http://tracker.ceph.com/issues/17859
[2] https://bugzilla.redhat.com/show_bug.cgi?id=3D1394007
[3] https://github.com/ceph/ceph/pull/11898

I'm worried we'll have to live with a cluster that can't =

scrub/deep-scrub until March 2017 (ETA for RHCS 2.2 running Jewel 10.2.4).

Can we have this fix any sooner ?

Regards

Fr=E9d=E9ric.

Le 15/11/2016 =E0 23:35, Sage Weil a =E9crit :
> Hi everyone,
>
> There was a regression in jewel that can trigger long OSD stalls during
> scrub.  How long the stalls are depends on how many objects are in your
> PGs, how fast your storage device is, and what is cached, but in at least
> one case they were long enough that the OSD internal heartbeat check
> failed and it committed suicide (120 seconds).
>
> The workaround for now is to simply
>
>   ceph osd set noscrub
>
> as the bug is only triggered by scrub.  A fix is being tested and will be
> available shortly.
>
> If you've seen any kind of weird latencies or slow requests on jewel, I
> suggest setting noscrub and seeing if they go away!
>
> The tracker bug is
>
>   http://tracker.ceph.com/issues/17859
>
> Big thanks to Yoann Moulin for helping track this down!
>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
