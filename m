From: Tommi Virtanen <tv@inktank.com>
Subject: Re: rbd locking and handling broken clients
Date: Wed, 13 Jun 2012 16:14:44 -0700
Message-ID: <CADvuQRHfWX--PnBfQOqW8aMkj8rFyLeVtfj+EMTpa-V52juhSA@mail.gmail.com>
References: <CAPYLRzhWkma7rrR=ATQTFmq_pwizeJ+SDi3efMEU9gTYPqAY3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:54636 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754717Ab2FMXPE convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Jun 2012 19:15:04 -0400
Received: by pbbrp8 with SMTP id rp8so2943002pbb.19
        for <ceph-devel@vger.kernel.org>; Wed, 13 Jun 2012 16:15:04 -0700 (PDT)
In-Reply-To: <CAPYLRzhWkma7rrR=ATQTFmq_pwizeJ+SDi3efMEU9gTYPqAY3g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: ceph-devel@vger.kernel.org, mandell@pistoncloud.com

On Wed, Jun 13, 2012 at 10:40 AM, Gregory Farnum <greg@inktank.com> wro=
te:
> 2) Client fencing. See http://tracker.newdream.net/issues/2531. There
> is an existing "blacklist" functionality in the OSDs/OSDMap, where yo=
u
> can specify an "entity_addr_t" (consisting of an IP, a port, and a
> nonce =E2=80=94 so essentially unique per-process) which is not allow=
ed to
> communicate with the cluster any longer. The problem with this is tha=
t

Does that work even after a TCP connection close & re-establish, where
the client now has a new source port address? (Perhaps the port is 0
for clients?)
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
