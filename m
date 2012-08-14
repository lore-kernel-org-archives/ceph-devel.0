From: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <slawomir.skowron@gmail.com>
Subject: Re: RadosGW hanging
Date: Tue, 14 Aug 2012 11:10:28 +0200
Message-ID: <CAMwB3Tj+=VvuFDzOF1Lv+cZ_rm+MVCVJif5GWKcRfNtCMK-1SQ@mail.gmail.com>
References: <CAMwB3TgG_JZJApvfT2ST9pMr+iHCH7E8vRXi77Sm0Jd+3ES+3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:40942 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755482Ab2HNJK3 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Aug 2012 05:10:29 -0400
Received: by qcro28 with SMTP id o28so70119qcr.19
        for <ceph-devel@vger.kernel.org>; Tue, 14 Aug 2012 02:10:28 -0700 (PDT)
In-Reply-To: <CAMwB3TgG_JZJApvfT2ST9pMr+iHCH7E8vRXi77Sm0Jd+3ES+3A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Ok, more info.

ceph -w was in many hours in same state:

2012-08-14 10:42:08.060339    pg v3530828: 240 pgs: 238 active+clean,
2 active+clean+scrubbing; 634 GB data, 1582 GB used, 18458 GB / 20040
GB avail

Two PG in 2 active+clean+scrubbing, and fragment of ceph -w output:

2012-08-14 10:42:02.753954 osd.8 10.177.66.4:6861/8729 215538 : [WRN]
6 slow requests, 6 included below; oldest blocked for > 39941.540514
secs
2012-08-14 10:42:02.753961 osd.8 10.177.66.4:6861/8729 215539 : [WRN]
slow request 39941.540514 seconds old, received at 2012-08-13
23:36:21.213355: osd_op(client.2997480.0:397
20565.1__shadow_images/pulscms/YjY7MDA_/2dc02bf8fda55367396d4508de7a107=
f.jpg_IKRO1n3TG9Pnp5ffhj2KXMvgM7ssjlH
[write 524288~187647] 6.d82ee747) v4 currently delayed
2012-08-14 10:42:02.753965 osd.8 10.177.66.4:6861/8729 215540 : [WRN]
slow request 39924.756970 seconds old, received at 2012-08-13
23:36:37.996899: osd_op(client.2997480.0:1480
20565.1__shadow_images/pulscms/NjU7MDA_/e24ba2bc400864c02a34d74d246c2ea=
5.jpg_Q5ZNBIzJjG65RJccOqagYQp7h3_YSIM
[write 524288~146458] 6.f6a8c297) v4 currently delayed
2012-08-14 10:42:02.753970 osd.8 10.177.66.4:6861/8729 215541 : [WRN]
slow request 39793.329296 seconds old, received at 2012-08-13
23:38:49.424573: osd_op(client.2997480.0:4440
20565.1__shadow_images/pulscms/NWY7MDA_/7dc146588b5c08f00bb0afa81a5d194=
c.jpg_UAHJCxaQwZ02JFQdRskU1EXCsY-M9uK
[write 524288~203649] 6.99216177) v4 currently delayed
2012-08-14 10:42:02.753973 osd.8 10.177.66.4:6861/8729 215542 : [WRN]
slow request 39737.889310 seconds old, received at 2012-08-13
23:39:44.864559: osd_op(client.2997480.0:5323
20565.1__shadow_images/pulscms/NjU7MDA_/e24ba2bc400864c02a34d74d246c2ea=
5.jpg_B-P79zBKYklPq1aYlTQAMGo9xmZPVeS
[write 524288~146458] 6.4f2c1caf) v4 currently delayed
2012-08-14 10:42:02.753977 osd.8 10.177.66.4:6861/8729 215543 : [WRN]
slow request 39082.054071 seconds old, received at 2012-08-13
23:50:40.699798: osd_op(client.2997480.0:8887
20565.1_files/pulscms/OTU7MDA_/54ad2076d83bee578bb3fa2919013934
[create 0~0,delete,writefull 0~3515,setxattr user.rgw.acl
(109),setxattr user.rgw.content_type (11),setxattr user.rgw.etag (33)]
6.c39afed7) v4 currently delayed

Using ceph --admin-daemon
/var/run/ceph/ceph-client.radosgw.obs-10-177-66-4.asok
objecter_requests, i found, that some request appears many times in
radosgw, as it is in delayed ops in ceph -w:

     11           "pg": "6.25195037",
     24           "pg": "6.cd5a3cd7",
    959           "pg": "7.6b5c8bd3",

example:

root@obs-10-177-66-4:~# ceph pg map 6.25195037
osdmap e124908 pg 6.25195037 (6.7) -> up [8,61,35] acting [8,61,35]

After restart this two OSD, delayed operations has gone.

When scrubbing in pg is online, again, then number of waiting objecter
requests in rgw going up, and in this case scrubbing is not going to
be end, for many hours, i have quite big problem.

Is this some known bug ?? or maybe new one ??

On Tue, Aug 14, 2012 at 8:33 AM, S=B3awomir Skowron
<slawomir.skowron@gmail.com> wrote:
> Cluster version  0.47.2-1precise.
>
> Now i can't say what triggers the problem, but cluster is loosing som=
e
> OSD, and when it's remmaping, and rebooting this osd's, and finaly
> returning to normal (with as lot of delayed operations on delete), Bu=
t
> when cluster is starting to be loosing some OSD, then radogw goes a
> wild, and every operation that hit radosgw fcgi, returning only http
> code 502 from nginx, for every request.
>
> Process of radosgw is working, and after restart radosgw on each host=
,
> everything back to normal, after cluster back to normal.
>
> Is anybody see such kind of behavior  ??
>
> --
> -----
> Regards
>
> S=B3awek "sZiBis" Skowron



--=20
-----
Pozdrawiam

S=B3awek "sZiBis" Skowron
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
