From: Henning Verbeek <hankipanky@gmail.com>
Subject: Re: Cuttlefish installation on debian 6.0 squeeze depends on cryptsetup-bin
Date: Wed, 8 May 2013 20:25:04 +0200
Message-ID: <CAOVDbHY+F-SqNeOva9A7Xf-fZ4uFzwUVddQG_5MD+aywS+HEfA@mail.gmail.com>
References: <CAOVDbHa2qS7-O1AyyQSPRcnb8DSrGxf_iKzBWUDkJLVf+uAuSA@mail.gmail.com>
	<6ADBB999-4C42-4B7F-ACDE-831589FF3F41@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:34118 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757848Ab3EHSZF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 8 May 2013 14:25:05 -0400
Received: by mail-wi0-f179.google.com with SMTP id l13so2231497wie.12
        for <ceph-devel@vger.kernel.org>; Wed, 08 May 2013 11:25:04 -0700 (PDT)
In-Reply-To: <6ADBB999-4C42-4B7F-ACDE-831589FF3F41@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gary Lowell <gary.lowell@inktank.com>
Cc: ceph-devel@vger.kernel.org

Awesome!

The squeeze / wheezy question came up on IRC before, too. I'll upgrade
to wheezy as soon as I can; but my hosts are running Proxmox KVM
virtualisation, and right now they are based on squeeze (although
today Proxmox released an RC of the new version, based on wheezy and
cuttlefish...).

I guess it just puzzled me that the package was supported on squeeze
but was not installable. I'm happy that I could contribute something,
even if it's tiny :) Ceph and you guys rock!

Cheers,
Henning


On Wed, May 8, 2013 at 5:39 PM, Gary Lowell <gary.lowell@inktank.com> wrote:
>
> Thanks for letting us know.  I'll incorporate Wido's fix.
>
> Cheers,
> Gary
>
> On May 8, 2013, at 1:09 AM, Henning Verbeek wrote:
>
> > Dear ceph developers,
> >
> > I just tried to upgrade my ceph installation from bobtail to
> > cuttlefish on a debian 6.0 squeeze installation. The installation of
> > package 'ceph' failed due to missing package 'cryptsetup-bin':
> >
> >  $ sudo apt-get -y install ceph
> >  Reading package lists... Done
> >  Building dependency tree
> >  Reading state information... Done
> >  Some packages could not be installed. This may mean that you have
> >  requested an impossible situation or if you are using the unstable
> >  distribution that some required packages have not yet been created
> >  or been moved out of Incoming.
> >  The following information may help to resolve the situation:
> >
> >  The following packages have unmet dependencies:
> >   ceph : Depends: cryptsetup-bin but it is not installable
> >          Recommends: ceph-mds but it is not going to be installed
> >  E: Broken packages
> >
> > Package 'cryptsetup-bin' is available only from wheezy onwards:
> > http://packages.debian.org/search?keywords=cryptsetup-bin
> >
> > On squeeze, the package is called 'cryptsetup'.
> >
> > Can I suggest that the dependency be changed for the squeeze packages?
> > Thank you.
> >
> > Cheers,
> > Henning
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



--
My other signature is a regular expression.
http://www.pray4snow.de
