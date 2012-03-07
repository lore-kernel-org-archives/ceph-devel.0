From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: Performance test on Ceph cluster
Date: Wed, 7 Mar 2012 10:09:18 -0800
Message-ID: <CAORUGqBSM2_H1Th6gSkyHVC4YoxwJZUaeiWMN3iS0ap9NvmFjw@mail.gmail.com>
References: <loom.20120222T102830-526@post.gmane.org> <loom.20120224T062854-915@post.gmane.org>
 <CAORUGqCJY3Q8uDJLoTeoHPiu9_YpOmE07_ivp28z4L9u0ieRxg@mail.gmail.com>
 <4352803.opIYE8Xzll@pc10> <4F5746FD.6090508@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:56611 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757000Ab2CGSJi convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Mar 2012 13:09:38 -0500
Received: by pbcun15 with SMTP id un15so751725pbc.19
        for <ceph-devel@vger.kernel.org>; Wed, 07 Mar 2012 10:09:38 -0800 (PST)
In-Reply-To: <4F5746FD.6090508@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: Guido Winkelmann <guido-ceph@thisisnotatest.de>, ceph-devel@vger.kernel.org

On Wed, Mar 7, 2012 at 03:31, Wido den Hollander <wido@widodh.nl> wrote=
:
> You should take a look at:
>
> * public_addr
> * cluster_addr
> * public_network
> * cluster_network
>
> (From: src/common/config_opts.h)
>
> [osd]
> =C2=A0cluster network =3D 192.168.0.0/16
> =C2=A0public network =3D 172.16.0.0/16
>
> [osd.1]
> =C2=A0cluster addr =3D 192.168.0.1
> =C2=A0public addr =3D 172.16.0.1
>
> I haven't played with those options, but that should do it (I think)

You don't need both "addr" and "network", just one will do.

The "network" variant was added so you don't need any per-node
configuration entries (making it easier to add/remove nodes). It'll
look for the IP addresses the server has, find one that matches that
subnet, and bind to that one.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
