From: Henry C Chang <henry.cy.chang@gmail.com>
Subject: Re: pg in creating state can't be removed?
Date: Fri, 6 Apr 2012 22:41:53 +0800
Message-ID: <CANExM-O7JbiJqx71mifL51=xuutsTrBKWW4ttuE7vt6uNzpFDA@mail.gmail.com>
References: <CANExM-N3DQsBzG+sLoj8x3Gs4tAdRGOXu=n0Evr5yfEfq1jF=A@mail.gmail.com>
	<Pine.LNX.4.64.1204050819110.2059@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:50587 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754159Ab2DFOly convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Apr 2012 10:41:54 -0400
Received: by iagz16 with SMTP id z16so3171978iag.19
        for <ceph-devel@vger.kernel.org>; Fri, 06 Apr 2012 07:41:53 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1204050819110.2059@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Ahh...I was testing with v0.39. I re-tested it with the latest release
and have no such problem.
Sorry for the noise.

Henry

=E5=9C=A8 2012=E5=B9=B44=E6=9C=885=E6=97=A5=E4=B8=8B=E5=8D=8811:20=EF=BC=
=8CSage Weil <sage@newdream.net> =E5=AF=AB=E9=81=93=EF=BC=9A
> On Thu, 5 Apr 2012, Henry C Chang wrote:
>> Hi folks,
>>
>> I created a pool without adding any osds to it in the crushmap. As
>> expected, all pgs remains in creating state since no osds take care =
of
>> them.
>>
>> However, I do expect that this pool should be able to be removed.
>> Currently, removing such a pool hangs forever as the pg removal has =
to
>> wait until the pg have been created. Does my expectation make sense?
>
> Yeah. =C2=A0I seem to remember the pg removal code cleaning up stuff =
in the
> monitor's PGMap, but I'm also pretty sure this scenario was never tes=
ted.
>
> Do you see where it is waiting for PG creation? =C2=A0I don't think i=
t should
> need to do that, since it's going to be thrown out anyway.
>
> sage
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
