From: Douglas Fuller <dfuller@redhat.com>
Subject: Re: [PATCHv2 0/3] rbd: header read/refresh improvements
Date: Sun, 26 Apr 2015 11:07:05 -0400
Message-ID: <E52372BD-69F7-4D41-B9AF-BEEBFE2FF9B0@redhat.com>
References: <cover.1429881439.git.dfuller@redhat.com> <553C85D6.3010407@ieee.org> <CAOi1vP_s5d1jL0pppedF_PsjkX9qnU772GHDDZXR6HR6C+1ioQ@mail.gmail.com> <CD78243E-DADC-49D1-A23F-4E4880045A30@redhat.com> <553CF887.6000803@ieee.org>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54300 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751850AbbDZPHL convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 26 Apr 2015 11:07:11 -0400
In-Reply-To: <553CF887.6000803@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>
Cc: Ilya Dryomov <idryomov@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>


>> I=E2=80=99d really like a solution to this, but I don=E2=80=99t thin=
k one is
>> available given the constraints.
>=20
> Now that I know I understand it, I will at least provide
> some review comments on the patches.  I'll also think about
> it a little.  My instinct says there should be no need to
> make the copies, but the devil will be in the details.

Yeah, it seems like it should be simpler. To fix it, I think we would h=
ave to either commit a layering violation (decode the call ops=E2=80=99=
 response sizes in the message receive flow) or change the interface to=
 osd_client (don=E2=80=99t provide preallocated pagevecs for call respo=
nse data even though that=E2=80=99s what=E2=80=99s done for other types=
 of ops). I=E2=80=99m the new guy, though, so it=E2=80=99s certainly po=
ssible I=E2=80=99m missing something.

>> I was told that the preferred way to proceed for now was to avoid
>> changing the osd_client interface and to handle this case in
>> osd_client instead of the messaging layer. Given those constraints,
>> it was agreed in the standups and on #ceph-devel that it should be
>> done this way.
>=20
> Sorry, I haven't been keeping up with all the activity on the
> mailing list.  I pay closest attention to patches to the kernel
> code.

Well, this was worked out mainly in the standups and on IRC. There wasn=
=E2=80=99t a mailing list discussion on it. Having said that, the atten=
tion to the patch is certainly appreciated.

> OK, well I'll go look at that code path again to see if I
> can
> come up with any bright ideas.

Thanks very much.

-Doug--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
