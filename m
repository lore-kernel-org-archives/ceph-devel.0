From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Inject configuration change into cluster
Date: Tue, 04 Sep 2012 11:36:00 +0200
Message-ID: <5045CB80.50508@widodh.nl>
References: <1FC69721-C852-4B56-ACE6-073137C5290D@portal.onet.pl> <5045B928.1050706@widodh.nl> <1BF27E0D85AE8C45A1BB84890DC4BFFB8A7C49@MXMBON05.grupa.onet>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:45573 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756576Ab2IDJgD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Sep 2012 05:36:03 -0400
In-Reply-To: <1BF27E0D85AE8C45A1BB84890DC4BFFB8A7C49@MXMBON05.grupa.onet>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?U2tvd3JvbiBTxYJhd29taXI=?= <slawomir.skowron@grupaonet.pl>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 09/04/2012 10:30 AM, Skowron S=C5=82awomir wrote:
> Ok, thanks.
>
> Number of workers used for recover, or numer of disk threads.
>

I think those can be changed while the OSD is running. You could always=
=20
give it a try.

Wido

> -----Original Message-----
> From: Wido den Hollander [mailto:wido@widodh.nl]
> Sent: Tuesday, September 04, 2012 10:18 AM
> To: Skowron S=C5=82awomir
> Cc: ceph-devel@vger.kernel.org
> Subject: Re: Inject configuration change into cluster
>
> On 09/04/2012 07:04 AM, Skowron S=C5=82awomir wrote:
>> Is there any way now, to inject new configuration change, without re=
starting daemons ??
>>
>
> Yes, you can use the injectargs command.
>
> $ ceph osd tell 0 injectargs '--debug-osd 20'
>
> What do you want to change? Not everything can be changed while the O=
SD is running.
>
> Wido
>
>> Regards
>>
>> Slawomir Skowron--
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
"
>> in the body of a message to majordomo@vger.kernel.org More majordomo
>> info at  http://vger.kernel.org/majordomo-info.html
>>
>
> N=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDr=EF=BF=BD=EF=BF=BDy=EF=
=BF=BD=EF=BF=BD=EF=BF=BDb=EF=BF=BDX=EF=BF=BD=EF=BF=BD=C7=A7v=EF=BF=BD^=EF=
=BF=BD)=DE=BA{.n=EF=BF=BD+=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD]z=EF=BF=
=BD{ay=EF=BF=BD=1D=CA=87=DA=99=EF=BF=BD,j=07=EF=BF=BD=EF=BF=BDf=EF=BF=BD=
=EF=BF=BD=EF=BF=BDh=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD=1E=EF=BF=BDw=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=0C=EF=BF=BD=EF=BF=BD=EF=BF=BDj:+v=EF=BF=BD=EF=BF=
=BD=EF=BF=BDw=EF=BF=BDj=EF=BF=BDm=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=07=
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDzZ+=EF=BF=BD=EF=BF=BD=DD=A2j"=EF=BF=
=BD=EF=BF=BD!tml=3D
>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
