From: Gregory Farnum <greg@inktank.com>
Subject: Re: RGW Blocking on 1-2 PG's - argonaut
Date: Mon, 4 Mar 2013 09:25:56 -0800
Message-ID: <CAPYLRzhMBBsgDHSwn84EimJJUb7uGtRx8-ef933Kayhv1UMsvQ@mail.gmail.com>
References: <CAMwB3ThhN036aBHP+29fVJ47E=PxOnj+fTiKJrB2dANFn1-Q1w@mail.gmail.com>
	<CAC-hyiGG+f7R1jCY8CPR2HKTa7bSetnGWs+ERii6iTdEAXpWMg@mail.gmail.com>
	<CAMwB3ThWcpWNOp03tCv1vG1OckH0Nw0moKYnPDytNya2Hhv+XA@mail.gmail.com>
	<alpine.DEB.2.00.1303040900500.14723@cobra.newdream.net>
	<CAMwB3TjfkX8LJpBiicrcdf3UqZpYApBoEShebceee6KgY+C3kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qe0-f45.google.com ([209.85.128.45]:58328 "EHLO
	mail-qe0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758031Ab3CDRZ5 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Mar 2013 12:25:57 -0500
Received: by mail-qe0-f45.google.com with SMTP id b4so4070341qen.32
        for <ceph-devel@vger.kernel.org>; Mon, 04 Mar 2013 09:25:56 -0800 (PST)
In-Reply-To: <CAMwB3TjfkX8LJpBiicrcdf3UqZpYApBoEShebceee6KgY+C3kw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <szibis@gmail.com>
Cc: Sage Weil <sage@inktank.com>, Yehuda Sadeh <yehuda@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Mar 4, 2013 at 9:23 AM, S=C5=82awomir Skowron <szibis@gmail.com=
> wrote:
> On Mon, Mar 4, 2013 at 6:02 PM, Sage Weil <sage@inktank.com> wrote:
>> On Mon, 4 Mar 2013, S?awomir Skowron wrote:
>>> Ok, thanks for response. But if i have crush map like this in attac=
hment.
>>>
>>> All data should be balanced equal, not including hosts with 0.5 wei=
ght.
>>>
>>> How make data auto balanced ?? when i know that some pq's have too
>>> much data ?? I have 4800 pg's on RGW only with 78 OSD, it is quite
>>> enough.
>>>
>>> pool 3 '.rgw.buckets' rep size 3 crush_ruleset 0 object_hash rjenki=
ns
>>> pg_num 4800 pgp_num 4800 last_change 908 owner 0
>>>
>>> When will bee possible to expand number of pg's ??
>>
>> Soon.  :)
>>
>> The bigger question for me is why there is one PG that is getting po=
unded
>> while the others are not.  Is there a large skew in the workload tow=
ard a
>> small number of very hot objects?
>
> Yes, there are constantly about 100-200 operations in second, all
> going into RGW backend. But when problems comes, there are more
> requests, more GET, and PUT, because of reconnect of applications,
> with short timeouts. But statistically all new PUTs normally goes for
> many pg's, this should not overload a single master OSD. Maybe
> balanced Reads from all replicas could help a little ??.
>
>>  I expect it should be obvious if you go
>> to the loaded osd and do
>>
>>  ceph --admin-daemon /var/run/ceph/ceph-osd.NN.asok dump_ops_in_flig=
ht
>>
>
> Yes i did that, but only when cluster going unstable there are such
> long operations. Normaly there are no ops in queue, only when cluster
> going to rebalance, remap, or anything else.

Have you checked the baseline disk performance of the OSDs? Perhaps
it's not that the PG is bad but that the OSDs are slow.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
