From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: SUSE install/config issue...
Date: Mon, 27 Dec 2010 15:30:37 -0800
Message-ID: <AANLkTikqntKK1sWbt-bVOQYviNZxpL6bGkysyeKvhFKS@mail.gmail.com>
References: <1293491636.12960.8.camel@hermosa.morreale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:54569 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751495Ab0L0Xaj convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Dec 2010 18:30:39 -0500
Received: by fxm20 with SMTP id 20so9421658fxm.19
        for <ceph-devel@vger.kernel.org>; Mon, 27 Dec 2010 15:30:37 -0800 (PST)
In-Reply-To: <1293491636.12960.8.camel@hermosa.morreale.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: pmorreale@novell.com
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Peter,

The cfuse binary is part of ceph. Normally, it would be installed by
make install. Try re-running configure and make, making sure to
specify ./configure --with-fuse

Also, you might want to consider using the kernel client, since its
performance is higher.

P.S. I just changed the "installing on SuSE" wiki page to recommend
configure --with-fuse, since it also recommends cfuse.

cheers,
Colin


On Mon, Dec 27, 2010 at 3:13 PM, Peter W. Morreale <pmorreale@novell.co=
m> wrote:
>
> I'm attempting to install ceph for the first time on openSUSE 11.2,
> using the packages out of factory. =A0I used the wiki page:
> http://ceph.newdream.net/wiki/Installing_on_SuSE under the "Complex
> System" part. =A0All appears to be fine other than I cannot seem to f=
ind
> the 'cfuse' comand/script. =A0A find of root failed to locate it as w=
ell.
>
>
> Where do I find the 'cfuse' command/script?
>
> Thx
> -PWM
>
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
