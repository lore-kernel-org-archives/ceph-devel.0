From: Atish Kathpal <atish.kathpal@gmail.com>
Subject: Re: How to recover degraded objects?
Date: Fri, 4 Nov 2011 15:23:44 +0530
Message-ID: <CAMiHsJK4omXsDNRuhqoWDNnYbdBaJDhAMA7vTeAkyS1RWrunTA@mail.gmail.com>
References: <CAMiHsJL4bYiKXMRKs142PyetmsEBtizp9T-V97wf-5qpJVf6sw@mail.gmail.com>
 <CAMiHsJLAYTbysxh4n-v3hgcDiqoS0eyva+CELz4Fdkv-K+fkZA@mail.gmail.com>
 <CAMiHsJJ73xofKdNfqPzF1x1ax5AVGLb5Y+p-4Swhaxn8skaPFA@mail.gmail.com> <CAORUGqB5WAvW8Bchy=afdZJM=zMddWKs0=18RofspQ+x0w8_OA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:46460 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754774Ab1KDJyG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Nov 2011 05:54:06 -0400
Received: by bke11 with SMTP id 11so1776915bke.19
        for <ceph-devel@vger.kernel.org>; Fri, 04 Nov 2011 02:54:05 -0700 (PDT)
In-Reply-To: <CAORUGqB5WAvW8Bchy=afdZJM=zMddWKs0=18RofspQ+x0w8_OA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

On Thu, Nov 3, 2011 at 10:38 PM, Tommi Virtanen
<tommi.virtanen@dreamhost.com> wrote:
> On Wed, Nov 2, 2011 at 23:58, Atish Kathpal <atish.kathpal@gmail.com> wrote:
>> Moreover, I am also unable to create new objects and/or get/put the
>> degraded objects. I re-ran mkcephfs after my reboot.
>
> Well, if you re-ran mkcephfs, that wiped out your old data, so your
> earlier question is now moot. Did you shutdown all the daemons first
> before mkcephfs? If not, expect them to be broken now. It's hard to
> guess what the state of your system is now; perhaps the easiest path
> out is to shut down all the daemons, remove all the ceph data ("osd
> data" and "mon data" dirs in ceph.conf), re-run mkcephfs, see that
> "ceph health" says ok, and then try the "rados" command again.
>

Thanks for the insights. Yes, I guess I did too many things after the
reboot, including re-starting the daemons and the re-running mkcephfs.
So from your reply I understand that a system reboot would have done
nothing to my RADOS objects, it was the re-running of mkcephfs that
degraded my objects. Right?

I am able to use "rados" command again, I independently performed some
of the steps you have also mentioned. I have understandably lost all
my old object though.

Thanks
Atish
