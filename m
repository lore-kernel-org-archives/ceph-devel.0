From: Sam Zaydel <sam.zaydel@inktank.com>
Subject: Re: distributed cluster
Date: Tue, 29 May 2012 09:53:55 -0700
Message-ID: <CAAs1YtHpzCn4is5N5FT6poqPnQhP3cDDF7Oz+EZAYYUUBep8Xg@mail.gmail.com>
References: <Pine.LNX.4.64.1205281117360.358@Psilocybe.Update.UU.SE>
	<CADvuQREnjHmnjOKimy2+FCrJ0yc2zGh6v4gtUtovX=jVDazRsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:36200 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754051Ab2E2Qx4 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 May 2012 12:53:56 -0400
Received: by pbbrp8 with SMTP id rp8so6196560pbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 29 May 2012 09:53:55 -0700 (PDT)
In-Reply-To: <CADvuQREnjHmnjOKimy2+FCrJ0yc2zGh6v4gtUtovX=jVDazRsQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I could see a lot of use-cases for BC and DR tiers where performance
may not be as much an issue, but availability being critical above
all.

Most options in use today rely on some async rep. and are in most
cases quite expensive and still do not view performance as their
primary concern.

On Tue, May 29, 2012 at 9:44 AM, Tommi Virtanen <tv@inktank.com> wrote:
> On Mon, May 28, 2012 at 4:28 AM, Jerker Nyberg <jerker@update.uu.se> =
wrote:
>> This may not really be a subject ceph-devel mailinglist but rather a
>> potential ceph-users? I hope it is ok to write here.
>
> It's absolutely ok to talk on this mailing list about using Ceph. We
> may create a separate ceph-users later on, but right now this list is
> where the conversation should go.
>
>> Let us assume we have a couple of sites distributed over a metro net=
work
>> with at least gigabit interconnect. The demands for storage capacity=
 and
>> speed at our sites are increasing together with the demands for reas=
onably
>> stable storage. May Ceph be a port of a solution?
>
> Ceph was designed to work within a single data center. If parts of th=
e
> cluster reside in remote locations, you essentially suffer the worst
> combination of their latency and bandwidth limits. A write that gets
> replicated to three different data centers is not complete until the
> data has been transferred to all three, and an acknowledgement has
> been received.
>
> For example: with data replicated over data centers A, B, C, connecte=
d
> at 1Gb/s, the fastest all of A will ever handle writes is 0.5Gb/s --
> it'll need to replicate everything to B and C, over that single pipe.
>
> I am aware of a few people building multi-dc Ceph clusters. Some have
> shared their network latency, bandwidth and availability numbers with
> me (confidentially), and at first glance their wide-area network
> performs better than many single-dc networks. They are far above a 1
> gigabit interconnect.
>
> I would really recommend you embark on a project like this only if yo=
u
> are able to understand the Ceph replication model, and do the math fo=
r
> yourself and figure out what your expected service levels for Ceph
> operations would be. (Naturally, Inktank Professional Services will
> help you in your endeavors, though their first response should be
> "that's not a recommended setup".)
>
>> One idea is to set up Ceph distributed over this metro network. A pu=
blic
>> service network is announced at all sites, anycasted from the storag=
e
>> SMB/NFS/RGW(?)-to-Ceph gateway. (for stateless connections). Statefu=
ll
>> connections (iSCSI?) has to contact the individual storage gateways =
and
>> redundancy is handled at the application level (dual path). Ceph ker=
nel
>> clients contact the storage servers directly.
>
> The Ceph Distributed File System is not considered production ready y=
et.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
