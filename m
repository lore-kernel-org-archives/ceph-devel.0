From: Tommi Virtanen <tv@inktank.com>
Subject: Re: rbd locking and handling broken clients
Date: Thu, 14 Jun 2012 12:44:12 -0700
Message-ID: <CADvuQREOHMv+A-efDVSq3Tr93ENtOJ4Bgm0N_+=3bfZFEkViZg@mail.gmail.com>
References: <CAPYLRzhWkma7rrR=ATQTFmq_pwizeJ+SDi3efMEU9gTYPqAY3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:46263 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754157Ab2FNTod (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Jun 2012 15:44:33 -0400
Received: by dady13 with SMTP id y13so3001069dad.19
        for <ceph-devel@vger.kernel.org>; Thu, 14 Jun 2012 12:44:33 -0700 (PDT)
In-Reply-To: <CAPYLRzhWkma7rrR=ATQTFmq_pwizeJ+SDi3efMEU9gTYPqAY3g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: ceph-devel@vger.kernel.org, mandell@pistoncloud.com

On Wed, Jun 13, 2012 at 10:40 AM, Gregory Farnum <greg@inktank.com> wrote:
> 2) Client fencing. See http://tracker.newdream.net/issues/2531. There
> is an existing "blacklist" functionality in the OSDs/OSDMap, where you

So I just managed to put into words another reason I like the key
rotation more than blacklisting: blacklisting fails open, key rotation
fails closed. That is, say something restart the client process, and
it gets a new pid: now it has a new unique id, and the old blacklist
entry no longer applies! Where as with key rotation, if you don't get
a new secret, you have snowballs chance in hell of getting it going
again.


The other reason that came up is, blacklisting is time-expiring (I
hear 24 hours currently), and I have absolutely no faith that
malfunctioning clients will actually always get manual intervention by
an admin within that time interval (or any other reasonable time
interval, either).
