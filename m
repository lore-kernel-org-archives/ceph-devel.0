From: =?KOI8-R?B?4s/Sz8TJziD3zMHEyc3J0g==?= <volk@xakep.ru>
Subject: Re: Theoretical questions
Date: Wed, 21 Mar 2012 21:44:49 +0300
Message-ID: <CAGEBRh176DeZ_sj0hMsBSXs+tKm52D+iCCRZew+XUDpTL7Kf6g@mail.gmail.com>
References: <CAGEBRh0t-X4-HE5-nyFbAmW7-k+yj7d4FjhiZL_WhQ6CjPToew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:48881 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751803Ab2CUSou (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Mar 2012 14:44:50 -0400
Received: by iagz16 with SMTP id z16so1931830iag.19
        for <ceph-devel@vger.kernel.org>; Wed, 21 Mar 2012 11:44:49 -0700 (PDT)
In-Reply-To: <CAGEBRh0t-X4-HE5-nyFbAmW7-k+yj7d4FjhiZL_WhQ6CjPToew@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sam.just@dreamhost.com, ceph-devel@vger.kernel.org

Thank you, Samuel.

Here is what I meant in fourth question:
We have pool "data" and in the crushmap there is a rule like this:
rule data {
	ruleset 1
	type replicated
	min_size 3
	max_size 3
	step take root
	step chooseleaf firstn 0 type rack
	step emit
}
The client tries to write an object to pool "data". Ceph selects PG
where to put the object. The object is then written to the buffer of
the primary OSD. Primary OSD then tries to write copies to buffer of
two replica OSDs and fails (perhaps, they are marked as down). Does
client recieve ack? Or will ceph try to write the object into another
PG?
Primary OSD then writes object from buffer to disk. Two replicas are
still down. Does client receive commit?
Is there a way to write always 3 successfull copies of an object and
then return ack to client?

21.03.2012, 21:12, "Samuel Just" <sam.just@dreamhost.com>:
> 1. The standby mds does not maintain cached metadata in memory or
> serve reads.  When taking over from a failed mds, it reads the
> primary's journal, which does warm up its cache somewhat.  Optionally,
> you can put an mds into standby-replay for an active mds.  In this case,
> the standby-replay mds will continually replay the primary's journal in
> order to more quickly take over in the case of a crash.
>
> 2. Primary-copy is the only strategy currently implemented.
>
> 3. On a sync, we wait for commits to ensure data safety.
>
> 4. I don't quite understand this question.
>
> 5.  Currently, there is not a good way to accomplish this using only
> ceph.  Replication is synchronous on writes, so you would be paying
> the latency cost between data centers on each write if you wanted to
> replicate between data centers.  We don't currently support reading from
> the closest replica.
>
> On Wed, Mar 21, 2012 at 2:22 AM, Borodin Vladimir <v.a.borodin@gmail.com> wrote:
>
>>  Hi all.
>>
>>  I've read everything in ceph.newdream.net/docs and
>>  ceph.newdream.net/wiki. I've also read some articles from
>>  ceph.newdream.net/publications. But I haven't found answers on some
>>  questions:
>>  1. there is one active MDS and one in standby mode. Active MDS caches
>>  all metadata in RAM. Does standby MDS copy this information to RAM?
>>  Will it take metadata from OSDs on every request after primary MDS
>>  failure? Do read requests come to standby MDS?
>>  2. what replication strategy on OSDs (primary-copy, chain or splay) is
>>  turned on by default?
>>  3. when does kernel client understand that the write was successfull
>>  (when it recieves ack or commit from primary OSD)?
>>  4. I want to have 3 copies of each object. By default there is a way
>>  to write only one successfull copy (and two others give a failure),
>>  isn't that? Is there a way to turn this off (even if one of three
>>  copies failed, the object will be placed to another PG)?
>>  5. if I have several data centers with good network connection, what
>>  is the way to provide data locality? For example, most of write and
>>  read requests from Spain come to Spanish DC and most of write and read
>>  requests from Russia come to Russian DC. Is it posible?
>>
>>  Regards,
>>  Vladimir.
>>  --
>>  To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>  the body of a message to majordomo@vger.kernel.org
>>  More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
