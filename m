From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: poor OSD performance using kernel 3.4 => problem found
Date: Thu, 31 May 2012 07:31:18 -0500
Message-ID: <4FC76496.9020001@inktank.com>
References: <4FBE415E.8030702@profihost.ag> <4FC54CDB.1000506@inktank.com> <4FC5BF27.5060704@profihost.ag> <CADdPHGs9dpSh9Oyu+5yDhyYU=Et_-zF5MuYybBuuAN5DgR433A@mail.gmail.com> <4FC5C941.6010105@profihost.ag> <CADdPHGuiJqZUCK-0qR_CrOo6GRhkjaCdkOhJ2boq3zD0_voTsA@mail.gmail.com> <4FC5FEC1.90103@profihost.ag> <4FC60FC8.207@inktank.com> <4FC61596.3050703@profihost.ag> <4FC62BB0.1020003@inktank.com> <4FC66A1F.1080407@profihost.ag> <CADdPHGuxa7TAyqXcXehb9WgKgkHwkybYTrj2oue_PKsiF+oR3A@mail.gmail.com> <4FC68CAA.9030708@profihost.ag> <CADdPHGutEwoDc=Kcrqcx2ZMO=dqhuoT5iLoP-WxqD+e5ZUmBRA@mail.gmail.com> <4FC7197D.5010406@profihost.ag> <CAC-hyiFjRFLVHYUKv8bGG0u8u2ZrHgP78U2Txt+3R7GGwtopZA@mail.gmail.com> <CADdPHGtz9Jq624DMO6Dve2AcJ9vrnFHbyqRa+qheA+0-y4k++g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:53055 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752109Ab2EaMbV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 May 2012 08:31:21 -0400
Received: by gglu4 with SMTP id u4so719040ggl.19
        for <ceph-devel@vger.kernel.org>; Thu, 31 May 2012 05:31:20 -0700 (PDT)
In-Reply-To: <CADdPHGtz9Jq624DMO6Dve2AcJ9vrnFHbyqRa+qheA+0-y4k++g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Majer <stefan.majer@gmail.com>
Cc: Yehuda Sadeh <yehuda@inktank.com>, Stefan Priebe - Profihost AG <s.priebe@profihost.ag>, ceph-devel@vger.kernel.org

Hi Stefan,

Please do share!  I was planning on starting out on the wiki and 
eventually getting these kinds of things into the master docs.  If you 
(and others) have already done testing it would be really interesting to 
compare experiences.  So far I've been just kind of throwing stuff into:

http://ceph.com/wiki/Performance_analysis

In it's current form it's pretty inadequate, but I'm hoping to 
eventually get back to it.  A lot of the work I've been doing recently 
is looking at underlying FS write behavior (specifically seeks) and if 
we can get any reasonable improvement through mkfs and mount options.

Mark

On 5/31/12 2:34 AM, Stefan Majer wrote:
> Hi,
>
> if Stefan confirms this as a solution it might me a good idea to 
> collect some performance optimizations hints for osds to 
> http://ceph.com/docs/master
> probably seperated in:
>
> Gigabit Ethernet based deployments
>  with Jumbo Frames
>
>  without Jumbo Frames
> 10 Gigabit Ethernet based deployments
>  with Jumbo Frames
>
>  without Jumbo Frames
>
> I can share some of our configurations as well
>
> Greetings
> Stefan
>
> On Thu, May 31, 2012 at 9:30 AM, Yehuda Sadeh <yehuda@inktank.com 
> <mailto:yehuda@inktank.com>> wrote:
>
>     On Thu, May 31, 2012 at 12:10 AM, Stefan Priebe - Profihost AG
>     <s.priebe@profihost.ag <mailto:s.priebe@profihost.ag>> wrote:
>     > Hi Marc, Hi Stefan,
>     >
>     > first thanks for all your help and time.
>     >
>     > I found the commit which results in this problem and it is TCP
>     related
>     > but i'm still wondering if the expected behaviour of this commit is
>     > expected?
>     >
>     > The commit in question is:
>     > git show c43b874d5d714f271b80d4c3f49e05d0cbf51ed2
>     > commit c43b874d5d714f271b80d4c3f49e05d0cbf51ed2
>     > Author: Jason Wang <jasowang@redhat.com
>     <mailto:jasowang@redhat.com>>
>     > Date:   Thu Feb 2 00:07:00 2012 +0000
>     >
>     >    tcp: properly initialize tcp memory limits
>     >
>     >    Commit 4acb4190 tries to fix the using uninitialized value
>     >    introduced by commit 3dc43e3,  but it would make the
>     >    per-socket memory limits too small.
>     >
>     >    This patch fixes this and also remove the redundant codes
>     >    introduced in 4acb4190.
>     >
>     >    Signed-off-by: Jason Wang <jasowang@redhat.com
>     <mailto:jasowang@redhat.com>>
>     >    Acked-by: Glauber Costa <glommer@parallels.com
>     <mailto:glommer@parallels.com>>
>     >    Signed-off-by: David S. Miller <davem@davemloft.net
>     <mailto:davem@davemloft.net>>
>     >
>     > diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
>     > index 4cb9cd2..7a7724d 100644
>     > --- a/net/ipv4/sysctl_net_ipv4.c
>     > +++ b/net/ipv4/sysctl_net_ipv4.c
>     > @@ -778,7 +778,6 @@ EXPORT_SYMBOL_GPL(net_ipv4_ctl_path);
>     >  static __net_init int ipv4_sysctl_init_net(struct net *net)
>     >  {
>     >        struct ctl_table *table;
>     > -       unsigned long limit;
>     >
>     >        table = ipv4_net_table;
>     >        if (!net_eq(net, &init_net)) {
>     > @@ -815,11 +814,6 @@ static __net_init int
>     ipv4_sysctl_init_net(struct
>     > net *net)
>     >        net->ipv4.sysctl_rt_cache_rebuild_count = 4;
>     >
>     >        tcp_init_mem(net);
>     > -       limit = nr_free_buffer_pages() / 8;
>     > -       limit = max(limit, 128UL);
>     > -       net->ipv4.sysctl_tcp_mem[0] = limit / 4 * 3;
>     > -       net->ipv4.sysctl_tcp_mem[1] = limit;
>     > -       net->ipv4.sysctl_tcp_mem[2] =
>     net->ipv4.sysctl_tcp_mem[0] * 2;
>     >
>     >        net->ipv4.ipv4_hdr = register_net_sysctl_table(net,
>     >                        net_ipv4_ctl_path, table);
>     > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
>     > index a34f5cf..37755cc 100644
>     > --- a/net/ipv4/tcp.c
>     > +++ b/net/ipv4/tcp.c
>     > @@ -3229 <tel:3229>,7 +3229,6 @@ __setup("thash_entries=",
>     set_thash_entries);
>     >
>     >  void tcp_init_mem(struct net *net)
>     >  {
>     > -       /* Set per-socket limits to no more than 1/128 the pressure
>     > threshold */
>     >        unsigned long limit = nr_free_buffer_pages() / 8;
>     >        limit = max(limit, 128UL);
>     >        net->ipv4.sysctl_tcp_mem[0] = limit / 4 * 3;
>     > @@ -3298 <tel:3298>,7 +3297,8 @@ void __init tcp_init(void)
>     >        sysctl_max_syn_backlog = max(128, cnt / 256);
>     >
>     >        tcp_init_mem(&init_net);
>     > -       limit = nr_free_buffer_pages() / 8;
>     > +       /* Set per-socket limits to no more than 1/128 the pressure
>     > threshold */
>     > +       limit = nr_free_buffer_pages() << (PAGE_SHIFT - 10);
>     >        limit = max(limit, 128UL);
>     >        max_share = min(4UL*1024*1024, limit);
>     >
>     Yeah, this might have affected the tcp performance. Looking at the
>     current linus tree this function looks more like it looked beforehand,
>     so it was probable reverted this way or another.
>
>     Yehuda
>
>
>
>
> -- 
> Stefan Majer


