From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: Installing Rados Gateway from sources
Date: Wed, 23 Jan 2013 12:02:16 -0800
Message-ID: <CAC-hyiHw7VmYna-NXmmz+UA-0tbOzoHewQ+=mXFc-fXTjDaqaA@mail.gmail.com>
References: <CAJVE5RXPPpcpuin3ZwXo9Q9_+y1Orz2SrtUriSFLKRGwn6MFFQ@mail.gmail.com>
	<CAJVE5RV6t53XEANN_wmOPsKyq-x70VO0PMpZRugCrYJFLNGTjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:34487 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751028Ab3AWUCR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Jan 2013 15:02:17 -0500
Received: by mail-ie0-f174.google.com with SMTP id k11so8594524iea.33
        for <ceph-devel@vger.kernel.org>; Wed, 23 Jan 2013 12:02:16 -0800 (PST)
In-Reply-To: <CAJVE5RV6t53XEANN_wmOPsKyq-x70VO0PMpZRugCrYJFLNGTjA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Cesar Mello <cmello@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Wed, Jan 23, 2013 at 11:53 AM, Cesar Mello <cmello@gmail.com> wrote:
>
> Hi,
>
> Sorry if this question is too off-topic. I am a Windows guy with no much
> knowledge about Linux.
>
> I have successfully installed a Rados Gateway through apt-get in a virtual
> machine. Now I would like to build and install from the sources in order
> to
> play and debug the latest stuff, in my ubuntu workstation.
>
> After building ceph, I run 'make install'. After following the
> instructions
> from docs I have 0.56-395-g371e6fb running nicely.
>
> Now I'm trying to setup radosgw. But this doesn't work:
>
> sudo /etc/init.d/radosgw start
>

You need to run the configure with the '--with-radosgw' option.

Yehuda
