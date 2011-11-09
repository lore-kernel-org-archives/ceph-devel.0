From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: [PATCH 1/4] client: return stripe address replicas
Date: Wed, 9 Nov 2011 13:36:28 -0800
Message-ID: <CAORUGqDjakCO6X-w-gofZWwiJZf65Lfk2VnV0OaDAZiSDATZXQ@mail.gmail.com>
References: <1320806361-1801-1-git-send-email-jayhawk@cs.ucsc.edu> <1320806361-1801-2-git-send-email-jayhawk@cs.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:58044 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751576Ab1KIVgu convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Nov 2011 16:36:50 -0500
Received: by wyh15 with SMTP id 15so2071499wyh.19
        for <ceph-devel@vger.kernel.org>; Wed, 09 Nov 2011 13:36:49 -0800 (PST)
In-Reply-To: <1320806361-1801-2-git-send-email-jayhawk@cs.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Nov 8, 2011 at 18:39, Noah Watkins <jayhawk@cs.ucsc.edu> wrote:
> + =C2=A0/* naddr =3D=3D 0: drop through and return actual size */
> + =C2=A0if (naddr && (address.size() > (unsigned)naddr))

I have to say I'm not completely comfortable with the magicness of
naddr=3D=3D0, mostly because I haven't seen other APIs do it like that.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
