From: Greg Farnum <greg@inktank.com>
Subject: Re: ceph osd crush add - uknown command crush
Date: Tue, 22 May 2012 13:27:50 -0700
Message-ID: <271B7E7C4B014BFE86FC17F9AF863BD8@inktank.com>
References: <CAMwB3TjS_r-U55py7WPu1RZmNob78nodB6a=i9sb1sx3mxvXDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:34128 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753440Ab2EVU1z convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 May 2012 16:27:55 -0400
Received: by dady13 with SMTP id y13so8728051dad.19
        for <ceph-devel@vger.kernel.org>; Tue, 22 May 2012 13:27:55 -0700 (PDT)
In-Reply-To: <CAMwB3TjS_r-U55py7WPu1RZmNob78nodB6a=i9sb1sx3mxvXDw@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?utf-8?Q?S=C5=82awomir_Skowron?= <szibis@gmail.com>
Cc: ceph-devel@vger.kernel.org, Sage Weil <sage@inktank.com>

On Tuesday, May 22, 2012 at 1:15 PM, S=C5=82awomir Skowron wrote:
> /usr/bin/ceph -v
> ceph version 0.47.1 (commit:f5a9404445e2ed5ec2ee828aa53d73d4a002f7a5)
> =20
> root@obs-10-177-66-4:/# /usr/bin/ceph osd crush add 1 osd.1 1.0
> pool=3Ddefault rack=3Dunknownrack host=3Dobs-10-177-66-4
> root@obs-10-177-66-4:/# unknown command crush
> =20
> Something has changed (there is no change in doc) or it's bug ??
Gah, something changed.

Use "ceph osd crush set=E2=80=A6" =20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
