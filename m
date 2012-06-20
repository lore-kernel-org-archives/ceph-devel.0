From: Oliver Francke <Oliver.Francke@filoo.de>
Subject: Re: 0.48 imminent
Date: Wed, 20 Jun 2012 10:40:27 +0200
Message-ID: <4FE18C7B.8060109@filoo.de>
References: <Pine.LNX.4.64.1206180951570.11790@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-3.de-punkt.de ([93.190.64.33]:33445 "EHLO
	mail-3.de-punkt.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753365Ab2FTIka (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Jun 2012 04:40:30 -0400
In-Reply-To: <Pine.LNX.4.64.1206180951570.11790@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

Hi *,

upgraded all instances to:

     0.47.2-508-g95ac5ba

kernel on OSDs is 3.4.[23]. Running fine with workload from our=20
test-setup with 8 VMs on 2 nodes and even more evil write/verify tests.

So far, so very good... Hope others in the same boat with qemu/RBD can=20
contribute same reports...

Kind reg's,

Oliver.

On 06/18/2012 06:55 PM, Sage Weil wrote:
> v0.48 is essentially ready, but we'd like to test it for a few more d=
ays
> before release.  If you are interested in helping out, it's the 'next=
'
> branch of ceph.git.
>
> A few notes:
>
>   - There is a disk-format change in this release.  The first time yo=
u
>     start ceph-osd it will do a slowish conversion, and you won't be =
able
>     to downgrade.
>
>   - This will form the basis of our first named 'stable' release.  If=
 you
>     care what we name it, go vote at
>
> 	http://bit.ly/LROUnL
>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--=20

Oliver Francke

filoo GmbH
Moltkestra=DFe 25a
33330 G=FCtersloh
HRB4355 AG G=FCtersloh

Gesch=E4ftsf=FChrer: S.Grewing | J.Rehp=F6hler | C.Kunz

=46olgen Sie uns auf Twitter: http://twitter.com/filoogmbh

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
