From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: packaging for RHEL6beta
Date: Thu, 9 Dec 2010 14:45:24 -0800
Message-ID: <AANLkTi=nO6wLVr7grvN=MH24EyNEY6vjowvy-3VA6iZi@mail.gmail.com>
References: <AANLkTingoDPDi5xZtywVy5js687+4jmwnz4t+Mt1B0WP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f43.google.com ([209.85.161.43]:53402 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752114Ab0LIWpZ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Dec 2010 17:45:25 -0500
Received: by fxm18 with SMTP id 18so3052211fxm.2
        for <ceph-devel@vger.kernel.org>; Thu, 09 Dec 2010 14:45:24 -0800 (PST)
In-Reply-To: <AANLkTingoDPDi5xZtywVy5js687+4jmwnz4t+Mt1B0WP@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brian Chrisman <brchrisman@gmail.com>
Cc: ceph-devel@vger.kernel.org

#2 is fixed now.
Also added dependencies for the GUI.

Colin


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
