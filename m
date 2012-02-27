From: Wido den Hollander <wido@widodh.nl>
Subject: Re: [WRN] map e### wrongly marked me down or wrong addr
Date: Mon, 27 Feb 2012 20:20:04 +0100
Message-ID: <4F4BD764.6090302@widodh.nl>
References: <2230716.Iq9SpLVmvc@mranderson> <Pine.LNX.4.64.1202270901350.12283@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:48429 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754850Ab2B0TUH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Feb 2012 14:20:07 -0500
In-Reply-To: <Pine.LNX.4.64.1202270901350.12283@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: =?ISO-8859-1?Q?Sz=E9kelyi_Szabolcs?= <szekelyi@niif.hu>, ceph-devel@vger.kernel.org



On 02/27/2012 06:03 PM, Sage Weil wrote:
> On Mon, 27 Feb 2012, Sz=E9kelyi Szabolcs wrote:
>> Hello,
>>
>> whenever I restart osd.0 I see a pair of messages like
>>
>> 2012-02-27 17:26:00.132666 mon.0<osd_1_ip>:6789/0 106 : [INF] osd.0
>> <osd_0_ip>:6801/29931 failed (by osd.1<osd_1_ip>:6806/20125)
>> 2012-02-27 17:26:21.074926 osd.0<osd_0_ip>:6801/29931 1 : [WRN] map =
e370
>> wrongly marked me down or wrong addr
>>
>> a couple of times. The situation stabilizes in a normal state after =
about two
>> minutes.
>>
>> Should I worry about this? Maybe the first message is about the just=
 killed
>> OSD, and the second comes from the new incarnation, and this is comp=
letely
>> normal? This is Ceph 0.41.
>
> It's not normal.  Wido was seeing something similar, I think.  I susp=
ect
> the problem is that during startup ceph-osd just busy, but the heartb=
eat
> code is such that it's not supposed to miss them.

I haven't seen the wrongly marked me down messages, I'm just seeing tha=
t=20
'pairs' of OSD's are marking the other down.

Still trying to figure that one out.

>
> Can you reproduce this with 'debug ms =3D 1'?
>
> sage
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
