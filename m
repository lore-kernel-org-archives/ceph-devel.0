From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: packaging for RHEL6beta
Date: Tue, 7 Dec 2010 21:23:33 -0800
Message-ID: <AANLkTinLOF0oPjUO3G2UwdEeRRyvU9AipkP1Mc3ADWR4@mail.gmail.com>
References: <AANLkTingoDPDi5xZtywVy5js687+4jmwnz4t+Mt1B0WP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f43.google.com ([209.85.161.43]:41119 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752417Ab0LHFaH convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Dec 2010 00:30:07 -0500
Received: by fxm18 with SMTP id 18so689691fxm.2
        for <ceph-devel@vger.kernel.org>; Tue, 07 Dec 2010 21:30:05 -0800 (PST)
In-Reply-To: <AANLkTingoDPDi5xZtywVy5js687+4jmwnz4t+Mt1B0WP@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brian Chrisman <brchrisman@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Tue, Dec 7, 2010 at 2:43 PM, Brian Chrisman <brchrisman@gmail.com> w=
rote:
> I've built RPMs for RHEL6beta from the spec file in the rc (checked
> out as of Monday) using the provided ceph.spec.
> Thus far I've run into a few issues:
> 1) Version: =A0 =A0 =A0 0.24~rc ... converted to 0.24.rc (doesn't lik=
e the ~ symbol)
> 2) =A0'gui_resources' not getting into BUILDROOT correctly.. I'm
> commenting it out in my spec file for now figuring it's probably
> non-essential?

Hmm. I do see an entry in the %files section for gui_resources. I
guess file a bug if it's not working.

As you may have guessed, you only need this for the GUI, which is non-e=
ssential.

Colin

> 3) /usr/lib/debug/usr/lib64/rados-classes/libcls_rbd.so.1.0.0.debug i=
s
> installed but unpackaged (In spec file I see this is being touched fo=
r
> a purpose that's not clearly apparent to me.. the path is mucked up
> with the usr/lib/debug prepended to usr/lib64.. etc.. so I'm
> commenting that section out too as it builds a separate directory
> structure in what looks like the wrong place.)
> 4) turned off RPATH checking (I'm not an rpm superhero...)
>
> With these caveats, the packages build and install on RHEL6beta.
> Will test a cluster with these packages next.
>
> -Brian
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
