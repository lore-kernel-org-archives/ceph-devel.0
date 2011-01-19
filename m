From: DongJin Lee <dongjin.lee@auckland.ac.nz>
Subject: Re: Ceph on just two nodes being clients - reasonable?
Date: Thu, 20 Jan 2011 00:30:34 +1300
Message-ID: <AANLkTimuBtsHd120=MsAR58H4NuTmzhLauEi8VwEDrmw@mail.gmail.com>
References: <4D36BDF9.4030404@wpkg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2-int.auckland.ac.nz ([130.216.12.41]:64096 "EHLO
	mx2-int.auckland.ac.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753713Ab1ASLao convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Jan 2011 06:30:44 -0500
Received: by qwa26 with SMTP id 26so715991qwa.19
        for <ceph-devel@vger.kernel.org>; Wed, 19 Jan 2011 03:30:34 -0800 (PST)
In-Reply-To: <4D36BDF9.4030404@wpkg.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tomasz Chmielewski <mangoo@wpkg.org>
Cc: ceph-devel@vger.kernel.org

On Wed, Jan 19, 2011 at 11:33 PM, Tomasz Chmielewski <mangoo@wpkg.org> =
wrote:
> Is it reasonable to set up Ceph on two nodes, which are Ceph clients =
at the
> same time?
>
>
> Say, we have two machines:
>
> =A0ceph1 -- ceph2
>
>
> On each of them, Ceph filesystem is mounted in /shared, which is used=
 by
> services like a webserver or a mailserver.
>
> Is it a reasonable approach?

Somehow I could not really run a reliable benchmarking (freezing) when
the ceph-client was sitting on the same machine.
It might've fixed now, but maybe you also need good machines too!
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
