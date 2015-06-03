From: Gregory Farnum <greg@gregs42.com>
Subject: Re: packaging init systems in a more autoools style way.
Date: Wed, 3 Jun 2015 14:38:39 -0700
Message-ID: <CAC6JEv9iFkWe86UFcwOonjzg9cvrrcUOubh1xTq3Qk02sy7M6Q@mail.gmail.com>
References: <556F1E19.6080704@suse.com>
	<alpine.DEB.2.00.1506030919460.9814@cobra.newdream.net>
	<556F6480.1090901@suse.com>
	<alpine.DEB.2.00.1506031344370.26591@cobra.newdream.net>
	<556F7344.4030003@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182]:34672 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754266AbbFCVim (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Jun 2015 17:38:42 -0400
Received: by lbcmx3 with SMTP id mx3so15737399lbc.1
        for <ceph-devel@vger.kernel.org>; Wed, 03 Jun 2015 14:38:41 -0700 (PDT)
Received: from mail-la0-f52.google.com (mail-la0-f52.google.com. [209.85.215.52])
        by mx.google.com with ESMTPSA id k10sm10391lbq.9.2015.06.03.14.38.39
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jun 2015 14:38:40 -0700 (PDT)
Received: by laew7 with SMTP id w7so18370762lae.1
        for <ceph-devel@vger.kernel.org>; Wed, 03 Jun 2015 14:38:39 -0700 (PDT)
In-Reply-To: <556F7344.4030003@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>
Cc: Sage Weil <sage@newdream.net>, Owen Synge <osynge@suse.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Jun 3, 2015 at 2:36 PM, Ken Dreyer <kdreyer@redhat.com> wrote:
> On 06/03/2015 02:45 PM, Sage Weil wrote:
>> Sounds good to me.  It could (should?) even error out if no init
> system is
>> specified?  Otherwise someone will likely be in for a surprise.
>
> I was picturing that we'd just autodetect based on OS version (eg Ubuntu
> 15.04 should default to --with-init=systemd). It's one less thing to get
> wrong during the build process.
>
> What do you think?

Debian users will get very angry at us. ;)
We could maybe autodetect if they don't specify one?
-Greg
