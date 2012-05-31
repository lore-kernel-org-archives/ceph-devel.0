From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: poor OSD performance using kernel 3.4 => problem found
Date: Thu, 31 May 2012 09:10:53 +0200
Message-ID: <4FC7197D.5010406@profihost.ag>
References: <4FBE415E.8030702@profihost.ag>	<4FC54CDB.1000506@inktank.com>	<4FC5BF27.5060704@profihost.ag>	<CADdPHGs9dpSh9Oyu+5yDhyYU=Et_-zF5MuYybBuuAN5DgR433A@mail.gmail.com>	<4FC5C941.6010105@profihost.ag>	<CADdPHGuiJqZUCK-0qR_CrOo6GRhkjaCdkOhJ2boq3zD0_voTsA@mail.gmail.com>	<4FC5FEC1.90103@profihost.ag>	<4FC60FC8.207@inktank.com>	<4FC61596.3050703@profihost.ag>	<4FC62BB0.1020003@inktank.com>	<4FC66A1F.1080407@profihost.ag>	<CADdPHGuxa7TAyqXcXehb9WgKgkHwkybYTrj2oue_PKsiF+oR3A@mail.gmail.com>	<4FC68CAA.9030708@profihost.ag> <CADdPHGutEwoDc=Kcrqcx2ZMO=dqhuoT5iLoP-WxqD+e5ZUmBRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:46709 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752888Ab2EaHKo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 May 2012 03:10:44 -0400
In-Reply-To: <CADdPHGutEwoDc=Kcrqcx2ZMO=dqhuoT5iLoP-WxqD+e5ZUmBRA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Majer <stefan.majer@gmail.com>
Cc: Mark Nelson <mark.nelson@inktank.com>, ceph-devel@vger.kernel.org

Hi Marc, Hi Stefan,

first thanks for all your help and time.

I found the commit which results in this problem and it is TCP related
but i'm still wondering if the expected behaviour of this commit is
expected?

The commit in question is:
git show c43b874d5d714f271b80d4c3f49e05d0cbf51ed2
commit c43b874d5d714f271b80d4c3f49e05d0cbf51ed2
Author: Jason Wang <jasowang@redhat.com>
Date:   Thu Feb 2 00:07:00 2012 +0000

    tcp: properly initialize tcp memory limits

    Commit 4acb4190 tries to fix the using uninitialized value
    introduced by commit 3dc43e3,  but it would make the
    per-socket memory limits too small.

    This patch fixes this and also remove the redundant codes
    introduced in 4acb4190.

    Signed-off-by: Jason Wang <jasowang@redhat.com>
    Acked-by: Glauber Costa <glommer@parallels.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index 4cb9cd2..7a7724d 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -778,7 +778,6 @@ EXPORT_SYMBOL_GPL(net_ipv4_ctl_path);
 static __net_init int ipv4_sysctl_init_net(struct net *net)
 {
        struct ctl_table *table;
-       unsigned long limit;

        table = ipv4_net_table;
        if (!net_eq(net, &init_net)) {
@@ -815,11 +814,6 @@ static __net_init int ipv4_sysctl_init_net(struct
net *net)
        net->ipv4.sysctl_rt_cache_rebuild_count = 4;

        tcp_init_mem(net);
-       limit = nr_free_buffer_pages() / 8;
-       limit = max(limit, 128UL);
-       net->ipv4.sysctl_tcp_mem[0] = limit / 4 * 3;
-       net->ipv4.sysctl_tcp_mem[1] = limit;
-       net->ipv4.sysctl_tcp_mem[2] = net->ipv4.sysctl_tcp_mem[0] * 2;

        net->ipv4.ipv4_hdr = register_net_sysctl_table(net,
                        net_ipv4_ctl_path, table);
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index a34f5cf..37755cc 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3229,7 +3229,6 @@ __setup("thash_entries=", set_thash_entries);

 void tcp_init_mem(struct net *net)
 {
-       /* Set per-socket limits to no more than 1/128 the pressure
threshold */
        unsigned long limit = nr_free_buffer_pages() / 8;
        limit = max(limit, 128UL);
        net->ipv4.sysctl_tcp_mem[0] = limit / 4 * 3;
@@ -3298,7 +3297,8 @@ void __init tcp_init(void)
        sysctl_max_syn_backlog = max(128, cnt / 256);

        tcp_init_mem(&init_net);
-       limit = nr_free_buffer_pages() / 8;
+       /* Set per-socket limits to no more than 1/128 the pressure
threshold */
+       limit = nr_free_buffer_pages() << (PAGE_SHIFT - 10);
        limit = max(limit, 128UL);
        max_share = min(4UL*1024*1024, limit);

Greets
Stefan
