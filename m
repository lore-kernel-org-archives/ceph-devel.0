From: Cesar Mello <cmello@gmail.com>
Subject: Re: Installing Rados Gateway from sources
Date: Wed, 23 Jan 2013 18:26:44 -0200
Message-ID: <CAJVE5RXd82tjU+d-HavR9S=ofUda8Q6hEOX23USvMLh=omCJ_Q@mail.gmail.com>
References: <CAJVE5RXPPpcpuin3ZwXo9Q9_+y1Orz2SrtUriSFLKRGwn6MFFQ@mail.gmail.com>
	<CAJVE5RV6t53XEANN_wmOPsKyq-x70VO0PMpZRugCrYJFLNGTjA@mail.gmail.com>
	<CAC-hyiHw7VmYna-NXmmz+UA-0tbOzoHewQ+=mXFc-fXTjDaqaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:40040 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751748Ab3AWU0q (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Jan 2013 15:26:46 -0500
Received: by mail-vc0-f174.google.com with SMTP id n11so5968253vch.19
        for <ceph-devel@vger.kernel.org>; Wed, 23 Jan 2013 12:26:46 -0800 (PST)
In-Reply-To: <CAC-hyiHw7VmYna-NXmmz+UA-0tbOzoHewQ+=mXFc-fXTjDaqaA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: ceph-devel@vger.kernel.org

Thanks so much Yehuda!

Best regards!
Mello

On Wed, Jan 23, 2013 at 6:02 PM, Yehuda Sadeh <yehuda@inktank.com> wrote:
> On Wed, Jan 23, 2013 at 11:53 AM, Cesar Mello <cmello@gmail.com> wrote:
>>
>> Hi,
>>
>> Sorry if this question is too off-topic. I am a Windows guy with no much
>> knowledge about Linux.
>>
>> I have successfully installed a Rados Gateway through apt-get in a virtual
>> machine. Now I would like to build and install from the sources in order
>> to
>> play and debug the latest stuff, in my ubuntu workstation.
>>
>> After building ceph, I run 'make install'. After following the
>> instructions
>> from docs I have 0.56-395-g371e6fb running nicely.
>>
>> Now I'm trying to setup radosgw. But this doesn't work:
>>
>> sudo /etc/init.d/radosgw start
>>
>
> You need to run the configure with the '--with-radosgw' option.
>
> Yehuda
