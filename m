From: Tommi Virtanen <tv@inktank.com>
Subject: Re: Unable to restart Mon after reboot
Date: Tue, 3 Jul 2012 09:44:38 -0700
Message-ID: <CADvuQRFkf8gHOknnj5zyRDBivYttC2Z1CCueZeXH5mnk+11fvQ@mail.gmail.com>
References: <BDAE812E-2659-4025-9B30-2DEC6675B59A@100percentit.com>
 <4FE55567.6080201@inktank.com> <4FE558CB.4010509@inktank.com>
 <F38AD123-3C97-44BD-ABE5-33635AD6D768@100percentit.com> <CADvuQRFcgPOy765-cYSVT1DPjOZ5nPXSb1Lr1Xjt5e3rU7joNw@mail.gmail.com>
 <45F11B42CB5830479EF0E56A27F4E68D7F12ED@exchange1.ad.100it.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:53343 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750759Ab2GCQo6 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Jul 2012 12:44:58 -0400
Received: by pbbrp8 with SMTP id rp8so9489055pbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 03 Jul 2012 09:44:58 -0700 (PDT)
In-Reply-To: <45F11B42CB5830479EF0E56A27F4E68D7F12ED@exchange1.ad.100it.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Blundell <David.Blundell@100percentit.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Jul 3, 2012 at 9:35 AM, David Blundell
<David.Blundell@100percentit.com> wrote:
> We switched to Ubuntu 12.04 for the tests which stopped all btrfs pro=
blems.
>
> We have now spent a week running the iotester corruption tests in KVM=
 instances while live migrating them every 5 minutes (with and without =
cache), running iozone and trying everything we could to corrupt the VM=
s. =C2=A0The tests on 0.47.x all performed flawlessly.

Nice!

> The upgrade to 0.48 went smoothly but since then we have had issues w=
ith slow requests showing up in the ceph logs and disk timeouts wheneve=
r we run iozone in the VMs.
>
> I will wipe the current OSDs and start with fresh a 0.48 installation=
 to see if I can reproduce the problem.

We've seen similar issues with btrfs, and others have reported that
the large metadata btrfs option helps. We're still compiling
information, but as of right now I hear best performance tends to
happen with xfs; however, the lead position tends to shift around a
lot.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
