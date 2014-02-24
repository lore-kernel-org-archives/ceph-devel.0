From: Kyle Bader <kyle.bader@gmail.com>
Subject: Re: ceph-standalone
Date: Mon, 24 Feb 2014 15:06:59 -0800
Message-ID: <CAFMfnwqB6CTEtZibW_uww=k+jxFZxmsix-d5sxR115ZOGR+qpw@mail.gmail.com>
References: <alpine.DEB.2.00.1402231225090.17508@cobra.newdream.net>
	<22A49EE2-BD1A-43C2-BBAB-8DD18CBEA550@inktank.com>
	<F33D6641-B3D1-4F25-9B7C-2269F2906908@enovance.com>
	<187667BD-58E9-4E75-8A71-872C3EB88095@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f175.google.com ([209.85.216.175]:64393 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753097AbaBXXOX convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Feb 2014 18:14:23 -0500
Received: by mail-qc0-f175.google.com with SMTP id e16so2881582qcx.6
        for <ceph-devel@vger.kernel.org>; Mon, 24 Feb 2014 15:14:23 -0800 (PST)
In-Reply-To: <187667BD-58E9-4E75-8A71-872C3EB88095@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

> so that=E2=80=99s great. It=E2=80=99s already almost done. Let us kno=
w when you have managed updating it.
>
> I suppose it would be best if we could offer one image each of the la=
st 3 Ceph versions (dumpling, emperor and firefly) so people can then p=
lay with the expected level they are looking for in either test environ=
ment or production environment.
>
> Each of the images would be maintained up to date for the last stable=
 code base of each version only to reduce time consuming.

This is screaming for us to use packer [1], that way we can easily
create vbox/kvm/ec2 images from a file that we can stash in git

[1] http://www.packer.io/
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
