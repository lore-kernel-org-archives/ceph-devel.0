From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: No space left while there are still available disk space
Date: Tue, 5 Oct 2010 22:05:50 -0700
Message-ID: <AANLkTi=hnc4AfTvHkLdypJWSmDP=BQ4xpnPsiQ0nVj_n@mail.gmail.com>
References: <AANLkTi=8ovvk8NPRx3Z=50DboYt4Qni8Ly0EFf0f79E-@mail.gmail.com>
	<AANLkTimcwHyJs+VL5TJVgZTU4MM5PjiAaDkkRkW1Frof@mail.gmail.com>
	<AANLkTinkdf3B7CEOaSsmAS8v-5oFjR31CRTHsKfHPpFb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:58099 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751920Ab0JFFFu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Oct 2010 01:05:50 -0400
Received: by pxi10 with SMTP id 10so1821061pxi.19
        for <ceph-devel@vger.kernel.org>; Tue, 05 Oct 2010 22:05:50 -0700 (PDT)
In-Reply-To: <AANLkTinkdf3B7CEOaSsmAS8v-5oFjR31CRTHsKfHPpFb@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Leander Yu <leander.yu@gmail.com>, Henry C Chang <henry_c_chang@tcloudcomputing.com>
Cc: ceph-devel@vger.kernel.org, Sage Weil <sage@newdream.net>

On Tue, Oct 5, 2010 at 9:57 PM, Leander Yu <leander.yu@gmail.com> wrote:
> Thanks, we found that even after I clean some disk space and make sure
> all the osd disk usage is less than 90%, I still can not write any
> data to the filesystem(not a single byte).
> Henry have check the kernel client debug info and found the osdmap is
> out of date and the flag is keep at full.
> He will post more detail information later.
> I guess there are some error handling problem there so that the client
> didn't keep updating the osdmap when disk is fulled.
>
> Any suggestion for further trouble shooting ?
Ah, we may not have set the kernel client to update its OSDMap
properly in this case. (Usually it updates automatically when it talks
to OSDs with a newer map, but the FULL flag prevents it from even
trying to write, so no communication.) Unless there's some other
problem I haven't thought of this will resolve if you unmount and
remount the filesystem (since it'll ask the monitor for a map on
mount). Did you try that?
-Greg
