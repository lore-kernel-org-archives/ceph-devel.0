From: Fyodor Ustinov <ufm@ufm.su>
Subject: Re: Kernel 3.0.0 + ext4 + ceph == ...
Date: Sun, 31 Jul 2011 20:32:58 +0300
Message-ID: <4E3591CA.7010109@ufm.su>
References: <4E33D101.1050504@ufm.su>	<9BF9E529-C532-4A94-8362-93C2D1B778DB@mit.edu> <4E3432FC.9030204@ufm.su>	<20110730165001.GI7361@thunk.org>	<Pine.LNX.4.64.1107301016120.23447@cobra.newdream.net>	<20110730221900.GK7361@thunk.org>	<Pine.LNX.4.64.1107302149430.23447@cobra.newdream.net>	<4E353D9E.5080802@ufm.su> <Pine.LNX.4.64.1107310951550.2348@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ufm.su ([77.120.103.19]:52862 "EHLO mail.ufm.su"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751818Ab1GaRdD (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 31 Jul 2011 13:33:03 -0400
In-Reply-To: <Pine.LNX.4.64.1107310951550.2348@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Ted Ts'o <tytso@mit.edu>, ceph-devel@vger.kernel.org

On 07/31/2011 08:04 PM, Sage Weil wrote:
>
> Hrm, I was hoping it wouldn't be a setattrs call.  The below will tel=
l us
> what xattrs it is setting, but sadly you'll need to reproduce the who=
le
> thing again.  The above is only telling us the size of the last xattr=
 of
> the set.

ok, until hour or two I do it.

WBR,
=46yodor.

P.S. muttered under his breath: "=D1=8F =D1=83=D0=B6=D0=B5 =D0=BB=D0=B5=
=D1=82 15 =D0=BA=D0=B0=D0=BA =D0=BD=D0=B5 =D0=BF=D1=80=D0=BE=D0=B3=D1=80=
=D0=B0=D0=BC=D0=BC=D0=B8=D1=81=D1=82. =D0=AF=20
=D0=BF=D1=80=D0=BE=D1=81=D1=82=D0=BE=D0=B9 =D1=81=D0=B8=D1=81=D1=82=D0=B5=
=D0=BC=D0=BD=D1=8B=D0=B9 =D0=B0=D0=B4=D0=BC=D0=B8=D0=BD=D0=B8=D1=81=D1=82=
=D1=80=D0=B0=D1=82=D0=BE=D1=80. =D0=9D=D1=83 =D0=B7=D0=B0 =D1=87=D1=82=D0=
=BE =D0=BC=D0=BD=D0=B5 =D1=8D=D1=82=D0=BE =D0=B2=D1=81=D1=91 =D0=BE=D0=BF=
=D1=8F=D1=82=D1=8C?"

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
