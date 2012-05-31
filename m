From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: poor OSD performance using kernel 3.4 => problem found
Date: Thu, 31 May 2012 00:30:13 -0700
Message-ID: <CAC-hyiFjRFLVHYUKv8bGG0u8u2ZrHgP78U2Txt+3R7GGwtopZA@mail.gmail.com>
References: <4FBE415E.8030702@profihost.ag>
	<4FC54CDB.1000506@inktank.com>
	<4FC5BF27.5060704@profihost.ag>
	<CADdPHGs9dpSh9Oyu+5yDhyYU=Et_-zF5MuYybBuuAN5DgR433A@mail.gmail.com>
	<4FC5C941.6010105@profihost.ag>
	<CADdPHGuiJqZUCK-0qR_CrOo6GRhkjaCdkOhJ2boq3zD0_voTsA@mail.gmail.com>
	<4FC5FEC1.90103@profihost.ag>
	<4FC60FC8.207@inktank.com>
	<4FC61596.3050703@profihost.ag>
	<4FC62BB0.1020003@inktank.com>
	<4FC66A1F.1080407@profihost.ag>
	<CADdPHGuxa7TAyqXcXehb9WgKgkHwkybYTrj2oue_PKsiF+oR3A@mail.gmail.com>
	<4FC68CAA.9030708@profihost.ag>
	<CADdPHGutEwoDc=Kcrqcx2ZMO=dqhuoT5iLoP-WxqD+e5ZUmBRA@mail.gmail.com>
	<4FC7197D.5010406@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:52496 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757558Ab2EaHaR convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 May 2012 03:30:17 -0400
Received: by bkcji2 with SMTP id ji2so528960bkc.19
        for <ceph-devel@vger.kernel.org>; Thu, 31 May 2012 00:30:13 -0700 (PDT)
In-Reply-To: <4FC7197D.5010406@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: Stefan Majer <stefan.majer@gmail.com>, Mark Nelson <mark.nelson@inktank.com>, ceph-devel@vger.kernel.org

On Thu, May 31, 2012 at 12:10 AM, Stefan Priebe - Profihost AG
<s.priebe@profihost.ag> wrote:
> Hi Marc, Hi Stefan,
>
> first thanks for all your help and time.
>
> I found the commit which results in this problem and it is TCP relate=
d
> but i'm still wondering if the expected behaviour of this commit is
> expected?
>
> The commit in question is:
> git show c43b874d5d714f271b80d4c3f49e05d0cbf51ed2
> commit c43b874d5d714f271b80d4c3f49e05d0cbf51ed2
> Author: Jason Wang <jasowang@redhat.com>
> Date: =A0 Thu Feb 2 00:07:00 2012 +0000
>
> =A0 =A0tcp: properly initialize tcp memory limits
>
> =A0 =A0Commit 4acb4190 tries to fix the using uninitialized value
> =A0 =A0introduced by commit 3dc43e3, =A0but it would make the
> =A0 =A0per-socket memory limits too small.
>
> =A0 =A0This patch fixes this and also remove the redundant codes
> =A0 =A0introduced in 4acb4190.
>
> =A0 =A0Signed-off-by: Jason Wang <jasowang@redhat.com>
> =A0 =A0Acked-by: Glauber Costa <glommer@parallels.com>
> =A0 =A0Signed-off-by: David S. Miller <davem@davemloft.net>
>
> diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
> index 4cb9cd2..7a7724d 100644
> --- a/net/ipv4/sysctl_net_ipv4.c
> +++ b/net/ipv4/sysctl_net_ipv4.c
> @@ -778,7 +778,6 @@ EXPORT_SYMBOL_GPL(net_ipv4_ctl_path);
> =A0static __net_init int ipv4_sysctl_init_net(struct net *net)
> =A0{
> =A0 =A0 =A0 =A0struct ctl_table *table;
> - =A0 =A0 =A0 unsigned long limit;
>
> =A0 =A0 =A0 =A0table =3D ipv4_net_table;
> =A0 =A0 =A0 =A0if (!net_eq(net, &init_net)) {
> @@ -815,11 +814,6 @@ static __net_init int ipv4_sysctl_init_net(struc=
t
> net *net)
> =A0 =A0 =A0 =A0net->ipv4.sysctl_rt_cache_rebuild_count =3D 4;
>
> =A0 =A0 =A0 =A0tcp_init_mem(net);
> - =A0 =A0 =A0 limit =3D nr_free_buffer_pages() / 8;
> - =A0 =A0 =A0 limit =3D max(limit, 128UL);
> - =A0 =A0 =A0 net->ipv4.sysctl_tcp_mem[0] =3D limit / 4 * 3;
> - =A0 =A0 =A0 net->ipv4.sysctl_tcp_mem[1] =3D limit;
> - =A0 =A0 =A0 net->ipv4.sysctl_tcp_mem[2] =3D net->ipv4.sysctl_tcp_me=
m[0] * 2;
>
> =A0 =A0 =A0 =A0net->ipv4.ipv4_hdr =3D register_net_sysctl_table(net,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0net_ipv4_ctl_path, tab=
le);
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index a34f5cf..37755cc 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -3229,7 +3229,6 @@ __setup("thash_entries=3D", set_thash_entries);
>
> =A0void tcp_init_mem(struct net *net)
> =A0{
> - =A0 =A0 =A0 /* Set per-socket limits to no more than 1/128 the pres=
sure
> threshold */
> =A0 =A0 =A0 =A0unsigned long limit =3D nr_free_buffer_pages() / 8;
> =A0 =A0 =A0 =A0limit =3D max(limit, 128UL);
> =A0 =A0 =A0 =A0net->ipv4.sysctl_tcp_mem[0] =3D limit / 4 * 3;
> @@ -3298,7 +3297,8 @@ void __init tcp_init(void)
> =A0 =A0 =A0 =A0sysctl_max_syn_backlog =3D max(128, cnt / 256);
>
> =A0 =A0 =A0 =A0tcp_init_mem(&init_net);
> - =A0 =A0 =A0 limit =3D nr_free_buffer_pages() / 8;
> + =A0 =A0 =A0 /* Set per-socket limits to no more than 1/128 the pres=
sure
> threshold */
> + =A0 =A0 =A0 limit =3D nr_free_buffer_pages() << (PAGE_SHIFT - 10);
> =A0 =A0 =A0 =A0limit =3D max(limit, 128UL);
> =A0 =A0 =A0 =A0max_share =3D min(4UL*1024*1024, limit);
>
Yeah, this might have affected the tcp performance. Looking at the
current linus tree this function looks more like it looked beforehand,
so it was probable reverted this way or another.

Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
