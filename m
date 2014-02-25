From: Hunter Nield <hunter@acale.ph>
Subject: Re: ceph-standalone
Date: Tue, 25 Feb 2014 10:11:24 +0800
Message-ID: <CAGRK8cxE10daLT8EwWr-_s_NjaWj-D_COPKy3HvwVgO=4qWj9w@mail.gmail.com>
References: <alpine.DEB.2.00.1402231225090.17508@cobra.newdream.net>
 <22A49EE2-BD1A-43C2-BBAB-8DD18CBEA550@inktank.com> <F33D6641-B3D1-4F25-9B7C-2269F2906908@enovance.com>
 <187667BD-58E9-4E75-8A71-872C3EB88095@inktank.com> <CAFMfnwqB6CTEtZibW_uww=k+jxFZxmsix-d5sxR115ZOGR+qpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f42.google.com ([209.85.192.42]:47376 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752563AbaBYCTJ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Feb 2014 21:19:09 -0500
Received: by mail-qg0-f42.google.com with SMTP id q107so17239071qgd.1
        for <ceph-devel@vger.kernel.org>; Mon, 24 Feb 2014 18:19:08 -0800 (PST)
In-Reply-To: <CAFMfnwqB6CTEtZibW_uww=k+jxFZxmsix-d5sxR115ZOGR+qpw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

The packer solution sounds sensible to me as it also would allow the
creation of Docker images.

A basic Docker image has already been started
(https://index.docker.io/u/rochaporto/cephbox/) but it would be quite
useful to have a version that comes from an official maintained
source.

On Tue, Feb 25, 2014 at 7:06 AM, Kyle Bader <kyle.bader@gmail.com> wrot=
e:
>> so that=E2=80=99s great. It=E2=80=99s already almost done. Let us kn=
ow when you have managed updating it.
>>
>> I suppose it would be best if we could offer one image each of the l=
ast 3 Ceph versions (dumpling, emperor and firefly) so people can then =
play with the expected level they are looking for in either test enviro=
nment or production environment.
>>
>> Each of the images would be maintained up to date for the last stabl=
e code base of each version only to reduce time consuming.
>
> This is screaming for us to use packer [1], that way we can easily
> create vbox/kvm/ec2 images from a file that we can stash in git
>
> [1] http://www.packer.io/
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
