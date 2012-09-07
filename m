From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: Telling an osd to reload a cls library
Date: Thu, 06 Sep 2012 18:22:51 -0700
Message-ID: <50494C6B.5090005@inktank.com>
References: <CAEVWPAVfRk-2pg0RATzH8ph0zqXWrodm4viWhjDHJh3+P-zh7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:41183 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755637Ab2IGBWz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Sep 2012 21:22:55 -0400
Received: by iahk25 with SMTP id k25so2709427iah.19
        for <ceph-devel@vger.kernel.org>; Thu, 06 Sep 2012 18:22:55 -0700 (PDT)
In-Reply-To: <CAEVWPAVfRk-2pg0RATzH8ph0zqXWrodm4viWhjDHJh3+P-zh7g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ian Pye <ianpye@gmail.com>
Cc: ceph-devel@vger.kernel.org

On 09/06/2012 06:17 PM, Ian Pye wrote:
> Hi,
>
> Is there a way to tell an osd to reload a cls.so file without
> re-starting the osd?
>
> Thanks,
>
> Ian

Not right now, although there could be an admin socket or
'ceph osd tell' command to do so I guess.

Josh
