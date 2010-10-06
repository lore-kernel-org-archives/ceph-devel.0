From: Leander Yu <leander.yu@gmail.com>
Subject: Re: No space left while there are still available disk space
Date: Wed, 6 Oct 2010 13:15:19 +0800
Message-ID: <AANLkTi=RT6ikTswH-LZ1LkDw3N+=H2u9hgdfYq1h8g9C@mail.gmail.com>
References: <AANLkTi=8ovvk8NPRx3Z=50DboYt4Qni8Ly0EFf0f79E-@mail.gmail.com>
	<AANLkTimcwHyJs+VL5TJVgZTU4MM5PjiAaDkkRkW1Frof@mail.gmail.com>
	<AANLkTinkdf3B7CEOaSsmAS8v-5oFjR31CRTHsKfHPpFb@mail.gmail.com>
	<AANLkTi=hnc4AfTvHkLdypJWSmDP=BQ4xpnPsiQ0nVj_n@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:61287 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752353Ab0JFFPU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Oct 2010 01:15:20 -0400
Received: by wyb28 with SMTP id 28so6834941wyb.19
        for <ceph-devel@vger.kernel.org>; Tue, 05 Oct 2010 22:15:19 -0700 (PDT)
In-Reply-To: <AANLkTi=hnc4AfTvHkLdypJWSmDP=BQ4xpnPsiQ0nVj_n@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregf@hq.newdream.net>
Cc: Henry C Chang <henry_c_chang@tcloudcomputing.com>, ceph-devel@vger.kernel.org, Sage Weil <sage@newdream.net>

Yes, after remount the file system it is back to normal

Regards,
Leander Yu.

On Wed, Oct 6, 2010 at 1:05 PM, Gregory Farnum <gregf@hq.newdream.net> wrote:
> On Tue, Oct 5, 2010 at 9:57 PM, Leander Yu <leander.yu@gmail.com> wrote:
>> Thanks, we found that even after I clean some disk space and make sure
>> all the osd disk usage is less than 90%, I still can not write any
>> data to the filesystem(not a single byte).
>> Henry have check the kernel client debug info and found the osdmap is
>> out of date and the flag is keep at full.
>> He will post more detail information later.
>> I guess there are some error handling problem there so that the client
>> didn't keep updating the osdmap when disk is fulled.
>>
>> Any suggestion for further trouble shooting ?
> Ah, we may not have set the kernel client to update its OSDMap
> properly in this case. (Usually it updates automatically when it talks
> to OSDs with a newer map, but the FULL flag prevents it from even
> trying to write, so no communication.) Unless there's some other
> problem I haven't thought of this will resolve if you unmount and
> remount the filesystem (since it'll ask the monitor for a map on
> mount). Did you try that?
> -Greg
>
