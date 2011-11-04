From: Atish Kathpal <atish.kathpal@gmail.com>
Subject: Re: How to recover degraded objects?
Date: Fri, 4 Nov 2011 17:48:36 +0530
Message-ID: <CAMiHsJLe+3OHNOQ0FfBha-bWu+W6uXJSJSjx5e7HOKXro9A17g@mail.gmail.com>
References: <CAMiHsJL4bYiKXMRKs142PyetmsEBtizp9T-V97wf-5qpJVf6sw@mail.gmail.com>
 <CAMiHsJLAYTbysxh4n-v3hgcDiqoS0eyva+CELz4Fdkv-K+fkZA@mail.gmail.com>
 <CAMiHsJJ73xofKdNfqPzF1x1ax5AVGLb5Y+p-4Swhaxn8skaPFA@mail.gmail.com>
 <CAORUGqB5WAvW8Bchy=afdZJM=zMddWKs0=18RofspQ+x0w8_OA@mail.gmail.com>
 <CAMiHsJK4omXsDNRuhqoWDNnYbdBaJDhAMA7vTeAkyS1RWrunTA@mail.gmail.com> <CANExM-Ogrbn8-6z1JgNAY3DjT20ZNk512as8ELpmJVPBe0xz1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:46775 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751038Ab1KDMS6 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Nov 2011 08:18:58 -0400
Received: by bke11 with SMTP id 11so1869639bke.19
        for <ceph-devel@vger.kernel.org>; Fri, 04 Nov 2011 05:18:57 -0700 (PDT)
In-Reply-To: <CANExM-Ogrbn8-6z1JgNAY3DjT20ZNk512as8ELpmJVPBe0xz1g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Henry C Chang <henry.cy.chang@gmail.com>
Cc: Tommi Virtanen <tommi.virtanen@dreamhost.com>, ceph-devel@vger.kernel.org

On Fri, Nov 4, 2011 at 4:23 PM, Henry C Chang <henry.cy.chang@gmail.com=
> wrote:
> Hi Atish,
>
> The default replication number of ceph is 2. Thus, If you have only
> one node (osd) in your cluster, all pg/objects are surely in degraded
> state.
>
> As to the problem that you cannot put/get objects, I guess it's
> because of the re-mkcephfs issue Tommi mentioned.
>
> Henry
>
Hello Henry

Thank you for providing further insights. To correct what you pointed
out regarding the default replica counts, I have now done the
following to my ceph single node cluster:
ceph osd pool set data size 1
ceph osd pool set metadata size 1

This should take care of the replica counts staying to 0 I believe.
Correct me if I am mistaken.

=46urther, while my cluster seems to be up and running and I am able to
do all get/put/setattr etc, I still see some issues with my ceph
health.
=3D=3D=3D
root@atish-virtual-machine:/etc/ceph# ceph health
2011-11-04 17:46:39.196118 mon <- [health]
2011-11-04 17:46:39.197207 mon0 -> 'HEALTH_WARN 198 pgs degraded' (0)
=3D=3D=3D

Any insights on this? I am curious about the warning it throws and how
I could correct it.

Regards
Atish

> 2011/11/4 Atish Kathpal <atish.kathpal@gmail.com>:
>> On Thu, Nov 3, 2011 at 10:38 PM, Tommi Virtanen
>> <tommi.virtanen@dreamhost.com> wrote:
>>> On Wed, Nov 2, 2011 at 23:58, Atish Kathpal <atish.kathpal@gmail.co=
m> wrote:
>>>> Moreover, I am also unable to create new objects and/or get/put th=
e
>>>> degraded objects. I re-ran mkcephfs after my reboot.
>>>
>>> Well, if you re-ran mkcephfs, that wiped out your old data, so your
>>> earlier question is now moot. Did you shutdown all the daemons firs=
t
>>> before mkcephfs? If not, expect them to be broken now. It's hard to
>>> guess what the state of your system is now; perhaps the easiest pat=
h
>>> out is to shut down all the daemons, remove all the ceph data ("osd
>>> data" and "mon data" dirs in ceph.conf), re-run mkcephfs, see that
>>> "ceph health" says ok, and then try the "rados" command again.
>>>
>>
>> Thanks for the insights. Yes, I guess I did too many things after th=
e
>> reboot, including re-starting the daemons and the re-running mkcephf=
s.
>> So from your reply I understand that a system reboot would have done
>> nothing to my RADOS objects, it was the re-running of mkcephfs that
>> degraded my objects. Right?
>>
>> I am able to use "rados" command again, I independently performed so=
me
>> of the steps you have also mentioned. I have understandably lost all
>> my old object though.
>>
>> Thanks
>> Atish
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
