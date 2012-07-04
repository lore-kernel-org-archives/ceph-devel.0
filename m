From: Gregory Farnum <greg@inktank.com>
Subject: Re: OSD doesn't start
Date: Wed, 4 Jul 2012 09:34:04 -0700
Message-ID: <F1FB8F95B3FA4FF19D53AE9F060D88F5@inktank.com>
References: <1563053.ttVafs9Pph@mranderson>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:45239 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752128Ab2GDQeB convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 Jul 2012 12:34:01 -0400
Received: by pbbrp8 with SMTP id rp8so11263098pbb.19
        for <ceph-devel@vger.kernel.org>; Wed, 04 Jul 2012 09:34:01 -0700 (PDT)
In-Reply-To: <1563053.ttVafs9Pph@mranderson>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?utf-8?Q?Sz=C3=A9kelyi_Szabolcs?= <szekelyi@niif.hu>
Cc: ceph-devel@vger.kernel.org

Hrm, it looks like the OSD data directory got a little busted somehow. =
How did you perform your upgrade? (That is, how did you kill your daemo=
ns, in what order, and when did you bring them back up.) =20
-Greg


On Wednesday, July 4, 2012 at 8:31 AM, Sz=C3=A9kelyi Szabolcs wrote:

> Hi,
> =20
> after upgrading to 0.48 "Argonaut", my OSDs won't start up again. Thi=
s problem =20
> might not be related to the upgrade, since the cluster had strange be=
havior =20
> before, too: ceph-fuse was spinning the CPU around 70%, so did the OS=
Ds. This =20
> happened to both of my clusters. Thought that upgrading might solve t=
he =20
> problem, but it just got worse.
> =20
> I've copied the log of the OSD run to http://pastebin.com/XYRtfFMU . =
I've =20
> rebooted all the nodes, but they still don't work.
> =20
> What should I do to resurrect my OSDs?
> =20
> Thanks,
> -- =20
> cc
> =20
> =20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org (mailto:majordomo@=
vger.kernel.org)
> More majordomo info at http://vger.kernel.org/majordomo-info.html



--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
