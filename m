From: Atish Kathpal <atish.kathpal@gmail.com>
Subject: Re: How to recover degraded objects?
Date: Mon, 7 Nov 2011 10:46:23 +0530
Message-ID: <CAMiHsJ+pf1h=JU7LYOR5WZUhequMUCgR-jrCUR2oc3oSwQGb0w@mail.gmail.com>
References: <CAMiHsJL4bYiKXMRKs142PyetmsEBtizp9T-V97wf-5qpJVf6sw@mail.gmail.com>
 <CAMiHsJLAYTbysxh4n-v3hgcDiqoS0eyva+CELz4Fdkv-K+fkZA@mail.gmail.com>
 <CAMiHsJJ73xofKdNfqPzF1x1ax5AVGLb5Y+p-4Swhaxn8skaPFA@mail.gmail.com>
 <CAORUGqB5WAvW8Bchy=afdZJM=zMddWKs0=18RofspQ+x0w8_OA@mail.gmail.com>
 <CAMiHsJK4omXsDNRuhqoWDNnYbdBaJDhAMA7vTeAkyS1RWrunTA@mail.gmail.com>
 <CANExM-Ogrbn8-6z1JgNAY3DjT20ZNk512as8ELpmJVPBe0xz1g@mail.gmail.com>
 <CAMiHsJLe+3OHNOQ0FfBha-bWu+W6uXJSJSjx5e7HOKXro9A17g@mail.gmail.com> <CAORUGqC5xTYaKTpyBrbpQe0BPkBNOpQENnYOZyZYz=ShhxUyiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:36572 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750771Ab1KGF00 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Nov 2011 00:26:26 -0500
Received: by bke11 with SMTP id 11so3311505bke.19
        for <ceph-devel@vger.kernel.org>; Sun, 06 Nov 2011 21:26:25 -0800 (PST)
In-Reply-To: <CAORUGqC5xTYaKTpyBrbpQe0BPkBNOpQENnYOZyZYz=ShhxUyiA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: Henry C Chang <henry.cy.chang@gmail.com>, ceph-devel@vger.kernel.org

On Fri, Nov 4, 2011 at 10:00 PM, Tommi Virtanen
<tommi.virtanen@dreamhost.com> wrote:
> On Fri, Nov 4, 2011 at 05:18, Atish Kathpal <atish.kathpal@gmail.com> wrote:
>> Thank you for providing further insights. To correct what you pointed
>> out regarding the default replica counts, I have now done the
>> following to my ceph single node cluster:
>> ceph osd pool set data size 1
>> ceph osd pool set metadata size 1
>>
>> This should take care of the replica counts staying to 0 I believe.
>> Correct me if I am mistaken.
>>
>> Further, while my cluster seems to be up and running and I am able to
>> do all get/put/setattr etc, I still see some issues with my ceph
>> health.
>> ===
>> root@atish-virtual-machine:/etc/ceph# ceph health
>> 2011-11-04 17:46:39.196118 mon <- [health]
>> 2011-11-04 17:46:39.197207 mon0 -> 'HEALTH_WARN 198 pgs degraded' (0)
>> ===
>>
>> Any insights on this? I am curious about the warning it throws and how
>> I could correct it.
>
> That is exactly the message you see when Ceph can't reach the desired
> number of copies for some Placement Groups.
>
> You can verify what the desired number of copies is set to (whether
> your "ceph osd pool set ... size 1" worked) by running
>
> ceph osd dump -o -|grep pg_size
>
> Please share that output with the list for further help.
>
> For more, see http://ceph.newdream.net/wiki/Adjusting_replication_level
>

The output you asked for is as follows:-

root@atish-virtual-machine:/etc/ceph# ceph osd dump -o -|grep pg_size
 wrote 716 byte payload to -
pg_pool 0 'data' pg_pool(rep pg_size 1 crush_ruleset 0 object_hash
rjenkins pg_num 64 pgp_num 64 lpg_num 2 lpgp_num 2 last_change 4 owner
0)
pg_pool 1 'metadata' pg_pool(rep pg_size 1 crush_ruleset 1 object_hash
rjenkins pg_num 64 pgp_num 64 lpg_num 2 lpgp_num 2 last_change 5 owner
0)
pg_pool 2 'rbd' pg_pool(rep pg_size 2 crush_ruleset 2 object_hash
rjenkins pg_num 64 pgp_num 64 lpg_num 2 lpgp_num 2 last_change 1 owner
0)

Do let me know.

Thanks
Atish
