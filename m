From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: How to recover degraded objects?
Date: Thu, 3 Nov 2011 10:08:15 -0700
Message-ID: <CAORUGqB5WAvW8Bchy=afdZJM=zMddWKs0=18RofspQ+x0w8_OA@mail.gmail.com>
References: <CAMiHsJL4bYiKXMRKs142PyetmsEBtizp9T-V97wf-5qpJVf6sw@mail.gmail.com>
 <CAMiHsJLAYTbysxh4n-v3hgcDiqoS0eyva+CELz4Fdkv-K+fkZA@mail.gmail.com> <CAMiHsJJ73xofKdNfqPzF1x1ax5AVGLb5Y+p-4Swhaxn8skaPFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:37008 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755682Ab1KCRIh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Nov 2011 13:08:37 -0400
Received: by wyh15 with SMTP id 15so1426063wyh.19
        for <ceph-devel@vger.kernel.org>; Thu, 03 Nov 2011 10:08:36 -0700 (PDT)
In-Reply-To: <CAMiHsJJ73xofKdNfqPzF1x1ax5AVGLb5Y+p-4Swhaxn8skaPFA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Atish Kathpal <atish.kathpal@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Wed, Nov 2, 2011 at 23:58, Atish Kathpal <atish.kathpal@gmail.com> wrote:
> Moreover, I am also unable to create new objects and/or get/put the
> degraded objects. I re-ran mkcephfs after my reboot.

Well, if you re-ran mkcephfs, that wiped out your old data, so your
earlier question is now moot. Did you shutdown all the daemons first
before mkcephfs? If not, expect them to be broken now. It's hard to
guess what the state of your system is now; perhaps the easiest path
out is to shut down all the daemons, remove all the ceph data ("osd
data" and "mon data" dirs in ceph.conf), re-run mkcephfs, see that
"ceph health" says ok, and then try the "rados" command again.
