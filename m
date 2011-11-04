From: Henry C Chang <henry.cy.chang@gmail.com>
Subject: Re: How to recover degraded objects?
Date: Fri, 4 Nov 2011 18:53:43 +0800
Message-ID: <CANExM-Ogrbn8-6z1JgNAY3DjT20ZNk512as8ELpmJVPBe0xz1g@mail.gmail.com>
References: <CAMiHsJL4bYiKXMRKs142PyetmsEBtizp9T-V97wf-5qpJVf6sw@mail.gmail.com>
	<CAMiHsJLAYTbysxh4n-v3hgcDiqoS0eyva+CELz4Fdkv-K+fkZA@mail.gmail.com>
	<CAMiHsJJ73xofKdNfqPzF1x1ax5AVGLb5Y+p-4Swhaxn8skaPFA@mail.gmail.com>
	<CAORUGqB5WAvW8Bchy=afdZJM=zMddWKs0=18RofspQ+x0w8_OA@mail.gmail.com>
	<CAMiHsJK4omXsDNRuhqoWDNnYbdBaJDhAMA7vTeAkyS1RWrunTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:65362 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750938Ab1KDKxn convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Nov 2011 06:53:43 -0400
Received: by iage36 with SMTP id e36so2410947iag.19
        for <ceph-devel@vger.kernel.org>; Fri, 04 Nov 2011 03:53:43 -0700 (PDT)
In-Reply-To: <CAMiHsJK4omXsDNRuhqoWDNnYbdBaJDhAMA7vTeAkyS1RWrunTA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Atish Kathpal <atish.kathpal@gmail.com>
Cc: Tommi Virtanen <tommi.virtanen@dreamhost.com>, ceph-devel@vger.kernel.org

Hi Atish,

The default replication number of ceph is 2. Thus, If you have only
one node (osd) in your cluster, all pg/objects are surely in degraded
state.

As to the problem that you cannot put/get objects, I guess it's
because of the re-mkcephfs issue Tommi mentioned.

Henry

2011/11/4 Atish Kathpal <atish.kathpal@gmail.com>:
> On Thu, Nov 3, 2011 at 10:38 PM, Tommi Virtanen
> <tommi.virtanen@dreamhost.com> wrote:
>> On Wed, Nov 2, 2011 at 23:58, Atish Kathpal <atish.kathpal@gmail.com=
> wrote:
>>> Moreover, I am also unable to create new objects and/or get/put the
>>> degraded objects. I re-ran mkcephfs after my reboot.
>>
>> Well, if you re-ran mkcephfs, that wiped out your old data, so your
>> earlier question is now moot. Did you shutdown all the daemons first
>> before mkcephfs? If not, expect them to be broken now. It's hard to
>> guess what the state of your system is now; perhaps the easiest path
>> out is to shut down all the daemons, remove all the ceph data ("osd
>> data" and "mon data" dirs in ceph.conf), re-run mkcephfs, see that
>> "ceph health" says ok, and then try the "rados" command again.
>>
>
> Thanks for the insights. Yes, I guess I did too many things after the
> reboot, including re-starting the daemons and the re-running mkcephfs=
=2E
> So from your reply I understand that a system reboot would have done
> nothing to my RADOS objects, it was the re-running of mkcephfs that
> degraded my objects. Right?
>
> I am able to use "rados" command again, I independently performed som=
e
> of the steps you have also mentioned. I have understandably lost all
> my old object though.
>
> Thanks
> Atish
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
