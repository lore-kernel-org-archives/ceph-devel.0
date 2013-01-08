From: Yann ROBIN <yann.robin@youscribe.com>
Subject: RE: Rados gateway init timeout with cache
Date: Tue, 8 Jan 2013 21:11:09 +0000
Message-ID: <367CC0B0FC02EE47BF7482398BD623C54E0E3AA2@DB3PRD0311MB416.eurprd03.prod.outlook.com>
References: <367CC0B0FC02EE47BF7482398BD623C54E0E3624@DB3PRD0311MB416.eurprd03.prod.outlook.com>
	<367CC0B0FC02EE47BF7482398BD623C54E0E3701@DB3PRD0311MB416.eurprd03.prod.outlook.com>
 <CAPYLRzhwWYA2_DZYgtRhKKEvATNY_4ATY1KwrV-LERocxAwjhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from va3ehsobe002.messaging.microsoft.com ([216.32.180.12]:12215
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751586Ab3AHVLc convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 8 Jan 2013 16:11:32 -0500
In-Reply-To: <CAPYLRzhwWYA2_DZYgtRhKKEvATNY_4ATY1KwrV-LERocxAwjhQ@mail.gmail.com>
Content-Language: fr-FR
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

We lost data in notify and gc. What bother me is that the rados gateway=
 can start if we desactivate the cache.
I think the availability of the cache objects shouldn't take down the r=
ados gateway. The option should be more a "I want the cache if availabl=
e".

-----Message d'origine-----
De=A0: Gregory Farnum [mailto:greg@inktank.com]=20
Envoy=E9=A0: mardi 8 janvier 2013 18:03
=C0=A0: Yann ROBIN
Cc=A0: ceph-devel@vger.kernel.org
Objet=A0: Re: Rados gateway init timeout with cache

To clarify, you lost the data on half of your OSDs? And it sounds like =
they weren't in separate CRUSH failure domains?

Given that, yep, you've lost some data. :(

On Tue, Jan 8, 2013 at 5:41 AM, Yann ROBIN <yann.robin@youscribe.com> w=
rote:
> Notify and gc objects where unfound, we marked them as lost and now t=
he rados start.
> But this means that if some notify object are not fully available, th=
e radosgateway stop responding.

Yes, that's the case. I'm not sure there's a way around it that makes m=
uch sense and satisfies the necessary guarantees, though.
-Greg

> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org=20
> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Yann ROBIN
> Sent: mardi 8 janvier 2013 12:13
> To: ceph-devel@vger.kernel.org
> Subject: Rados gateway init timeout with cache
>
> Hi,
>
> We recently experienced issue with the backplane of our server, resul=
ting in loosing half of our osd.
> During that period the rados gateway failed initializing (timeout).
> We found that the gateway was hanging in the init_watch function.
>
> We recreate our OSDs and we still have this issue, but pg are not all=
 in an active+clean state :
>    health HEALTH_WARN 1 pgs degraded; 1 pgs recovering; 2 pgs recover=
y_wait; 3 pgs stuck unclean; recovery 7/10140464 degraded (0.000%); 3/5=
070232 unfound (0.000%); noout flag(s) set
>    monmap e2: 3 mons at {ceph-mon-1=3D172.20.1.13:6789/0,ceph-mon-2=3D=
172.20.2.13:6789/0,ceph-mon-3=3D172.17.9.20:6789/0}, election epoch 256=
, quorum 0,1,2 ceph-mon-1,ceph-mon-2,ceph-mon-3
>    osdmap e4439: 6 osds: 6 up, 6 in
>     pgmap v2531184: 11024 pgs: 11019 active+clean, 2 active+recovery_=
wait, 1 active+recovering+degraded+remapped, 2 active+clean+scrubbing+d=
eep; 1291 GB data, 2612 GB used, 19645 GB / 22257 GB avail; 7/10140464 =
degraded (0.000%); 3/5070232 unfound (0.000%)
>    mdsmap e1: 0/0/1 up
>
> Should we open an ticket for this init issue with rados gateway ?
> Version is 0.56.1 upgraded from 0.55.
>
> --
> Yann ROBIN
> YouScribe
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
=20
> in the body of a message to majordomo@vger.kernel.org More majordomo=20
> info at  http://vger.kernel.org/majordomo-info.html
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
=20
> in the body of a message to majordomo@vger.kernel.org More majordomo=20
> info at  http://vger.kernel.org/majordomo-info.html


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
