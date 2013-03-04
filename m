From: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <szibis@gmail.com>
Subject: Re: RGW Blocking on 1-2 PG's - argonaut
Date: Mon, 4 Mar 2013 18:23:51 +0100
Message-ID: <CAMwB3TjfkX8LJpBiicrcdf3UqZpYApBoEShebceee6KgY+C3kw@mail.gmail.com>
References: <CAMwB3ThhN036aBHP+29fVJ47E=PxOnj+fTiKJrB2dANFn1-Q1w@mail.gmail.com>
	<CAC-hyiGG+f7R1jCY8CPR2HKTa7bSetnGWs+ERii6iTdEAXpWMg@mail.gmail.com>
	<CAMwB3ThWcpWNOp03tCv1vG1OckH0Nw0moKYnPDytNya2Hhv+XA@mail.gmail.com>
	<alpine.DEB.2.00.1303040900500.14723@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:38647 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758031Ab3CDRXw convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Mar 2013 12:23:52 -0500
Received: by mail-ie0-f171.google.com with SMTP id 10so6496217ied.30
        for <ceph-devel@vger.kernel.org>; Mon, 04 Mar 2013 09:23:52 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1303040900500.14723@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Yehuda Sadeh <yehuda@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Mar 4, 2013 at 6:02 PM, Sage Weil <sage@inktank.com> wrote:
> On Mon, 4 Mar 2013, S?awomir Skowron wrote:
>> Ok, thanks for response. But if i have crush map like this in attach=
ment.
>>
>> All data should be balanced equal, not including hosts with 0.5 weig=
ht.
>>
>> How make data auto balanced ?? when i know that some pq's have too
>> much data ?? I have 4800 pg's on RGW only with 78 OSD, it is quite
>> enough.
>>
>> pool 3 '.rgw.buckets' rep size 3 crush_ruleset 0 object_hash rjenkin=
s
>> pg_num 4800 pgp_num 4800 last_change 908 owner 0
>>
>> When will bee possible to expand number of pg's ??
>
> Soon.  :)
>
> The bigger question for me is why there is one PG that is getting pou=
nded
> while the others are not.  Is there a large skew in the workload towa=
rd a
> small number of very hot objects?

Yes, there are constantly about 100-200 operations in second, all
going into RGW backend. But when problems comes, there are more
requests, more GET, and PUT, because of reconnect of applications,
with short timeouts. But statistically all new PUTs normally goes for
many pg's, this should not overload a single master OSD. Maybe
balanced Reads from all replicas could help a little ??.

>  I expect it should be obvious if you go
> to the loaded osd and do
>
>  ceph --admin-daemon /var/run/ceph/ceph-osd.NN.asok dump_ops_in_fligh=
t
>

Yes i did that, but only when cluster going unstable there are such
long operations. Normaly there are no ops in queue, only when cluster
going to rebalance, remap, or anything else.

> and look at the request queue.
>
> sage
>
>
>>
>> Best Regards
>>
>> Slawomir Skowron
>>
>> On Mon, Mar 4, 2013 at 3:16 PM, Yehuda Sadeh <yehuda@inktank.com> wr=
ote:
>> > On Mon, Mar 4, 2013 at 3:02 AM, S?awomir Skowron <szibis@gmail.com=
> wrote:
>> >> Hi,
>> >>
>> >> We have a big problem with RGW. I don't know what is the initial
>> >> trigger, but i have theory.
>> >>
>> >> 2-3 osd, from 78 in cluster (6480 PG on RGW pool), have 3x time m=
ore
>> >> RAM usage, they have much more operations in journal, and much bi=
gger
>> >> latency.
>> >>
>> >> When we PUT some objects then in some cases, there are so many
>> >> operations in triple replication on this osd (one PG). Then this
>> >> triple can't handle this load, and goes down, drives on backend o=
f
>> >> this osd are getting fire with big wait-io, and big response time=
s.
>> >> RGW waiting for this PG, and eventually block all the others
>> >> operations when makes 1024 operations blocked in queue.
>> >> Then whole cluster have problems, and we have an outage.
>> >>
>> >> When RGW block operations there is only one PG that have >1000
>> >> operations in queue -
>> >> ceph pg map 3.9447554d
>> >> osdmap e11404 pg 3.9447554d (3.54d) -> up [53,45,23] acting [53,4=
5,23]
>> >>
>> >> now this osd are migrated, with ratio 0.5 on, but before it was
>> >>
>> >> ceph pg map 3.9447554d
>> >> osdmap e11404 pg 3.9447554d (3.54d) -> up [71,45,23] acting [71,4=
5,23]
>> >>
>> >> and this three osd's have such a problems. Under this osd's are o=
nly 3
>> >> drive, one drive per osd, that's why this have such a big impact.
>> >>
>> >> What i done. I gave 50% smaller ratio in CRUSH for this osd's, bu=
t
>> >> data move to other osd, and this osd, have half of possible capac=
ity.
>> >> I think it won't help in long term, and it's not a solution.
>> >>
>> >> I have second cluster, with only replication on it, and there are=
 same
>> >> case. Attachment explain everything. Every parameter on this bad =
osd
>> >> is much higher than on others. There are 2-3 osd with such high
>> >> counters.
>> >>
>> >> Is this a bug ?? maybe there is no problems in bobtail ?? I can't
>> >> switch quick into bobtail that's why i need some answers, which w=
ay i
>> >> need to go.
>> >>
>> >
>> > Not sure if bobtail is going to help much here, although there wer=
e a
>> > few performance fixes that went in. If your cluster is unbalanced =
(in
>> > terms of performance) then requests are going to be accumulated on=
 the
>> > weakest link. Reweighting the osd like what you did is a valid way=
 to
>> > go. You need to make sure that on the steady state, there's no one=
 osd
>> > that starts holding all the traffic.
>> > Also, make sure that your pools have enough pgs so that the placem=
ent
>> > distribution is uniform.
>> >
>> > Yehuda
>>
>>
>>
>> --
>> -----
>> Pozdrawiam
>>
>> S?awek "sZiBis" Skowron
>>



--
-----
Pozdrawiam

S=C5=82awek "sZiBis" Skowron
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
