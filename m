From: Yann ROBIN <yann.robin@youscribe.com>
Subject: RE: Rados gateway 0.58 crash in RGWProcess::_clear
Date: Mon, 11 Mar 2013 14:24:04 +0000
Message-ID: <367CC0B0FC02EE47BF7482398BD623C55D3CB052@DB3PRD0311MB416.eurprd03.prod.outlook.com>
References: <367CC0B0FC02EE47BF7482398BD623C55D3C74FE@DB3PRD0311MB416.eurprd03.prod.outlook.com>
 <CAC-hyiGuaH0j+QyAy6BP+UQK3wKb6hx+YU3pZpovqrcxoQTbUA@mail.gmail.com>
 <367CC0B0FC02EE47BF7482398BD623C55D3C754C@DB3PRD0311MB416.eurprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from co1ehsobe004.messaging.microsoft.com ([216.32.180.187]:58876
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751319Ab3CKOYJ convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 11 Mar 2013 10:24:09 -0400
In-Reply-To: <367CC0B0FC02EE47BF7482398BD623C55D3C754C@DB3PRD0311MB416.eurprd03.prod.outlook.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

The socket error was due to nginx opening too much connection, thus rea=
ching the limit of open fd for the gateway.

-----Original Message-----
=46rom: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.=
kernel.org] On Behalf Of Yann ROBIN
Sent: lundi 11 mars 2013 00:40
To: Yehuda Sadeh
Cc: ceph-devel@vger.kernel.org
Subject: RE: Rados gateway 0.58 crash in RGWProcess::_clear

The setup is multiple nginx accessing the fastcgi module using tcp sock=
et.
I found a ticket about multiple gateways issue : http://tracker.ceph.co=
m/issues/2804 this may be related.

We'll test with only one nginx to see if we still have the issue.

Thanks,

-----Message d'origine-----
De=A0: yehudasa@gmail.com [mailto:yehudasa@gmail.com] De la part de Yeh=
uda Sadeh Envoy=E9=A0: dimanche 10 mars 2013 23:58 =C0=A0: Yann ROBIN C=
c=A0: ceph-devel@vger.kernel.org Objet=A0: Re: Rados gateway 0.58 crash=
 in RGWProcess::_clear

On Sun, Mar 10, 2013 at 3:48 PM, Yann ROBIN <yann.robin@youscribe.com> =
wrote:
> Hi,
>
> We recently setup a cluster using version 0.58. We did massive parall=
el upload to the gateway and saw the radosgw restarted every 5 to 10 mi=
nutes.
> Here are the debug log :
> https://gist.github.com/kYann/5130775
>
> Small version :
> -2> 2013-03-10 23:20:02.916521 7fc1376ee700  1 =3D=3D=3D=3D=3D=3D req=
 done
> -2> req=3D0x237fc10 http_status=3D200 =3D=3D=3D=3D=3D=3D
>     -1> 2013-03-10 23:20:02.916546 7fc1376ee700  1 RGWProcess::m_tp w=
orker finish
>      0> 2013-03-10 23:20:02.931847 7fc1efa5b780 -1 rgw/rgw_main.cc: I=
n=20
> function 'virtual void RGWProcess::RGWWQ::_clear()' thread
> 7fc1efa5b780 time 2013-03-10 23:20:02.922020
> rgw/rgw_main.cc: 175: FAILED assert(process->m_req_queue.empty())
>
> ceph version 0.58 (ba3f91e7504867a52a83399d60917e3414e8c3e2)
> 1: (RGWRESTMgr_Admin::~RGWRESTMgr_Admin()+0) [0x474910]
> 2: (ThreadPool::stop(bool)+0x1ed) [0x4909bd]
> 3: (RGWProcess::run()+0x3c7) [0x473367]
> 4: (main()+0x8b6) [0x447276]
> 5: (__libc_start_main()+0xed) [0x7fc1ec92276d]
> 6: /usr/bin/radosgw() [0x448871]
>
>

This obviously shouldn't happen. Just note that this code should only b=
e reached either when trying to bring the gateway down, or when there's=
 some error on the fastcgi socket. Which web server are you using? Whic=
h fastcgi module? How did you set up fastcgi?

Thanks,
Yehuda


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n the body of a message to majordomo@vger.kernel.org More majordomo inf=
o at  http://vger.kernel.org/majordomo-info.html


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
