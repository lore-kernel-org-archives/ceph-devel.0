From: Douglas Fuller <dfuller@redhat.com>
Subject: Re: [PATCHv2 0/3] rbd: header read/refresh improvements
Date: Thu, 7 May 2015 12:48:54 -0400
Message-ID: <8092EB6A-5983-4297-A333-E33C155FBD3A@redhat.com>
References: <cover.1429881439.git.dfuller@redhat.com> <553C85D6.3010407@ieee.org> <CAOi1vP_s5d1jL0pppedF_PsjkX9qnU772GHDDZXR6HR6C+1ioQ@mail.gmail.com> <CD78243E-DADC-49D1-A23F-4E4880045A30@redhat.com> <553CF887.6000803@ieee.org> <E52372BD-69F7-4D41-B9AF-BEEBFE2FF9B0@redhat.com> <alpine.DEB.2.00.1504262110090.5458@cobra.newdream.net> <DAE9CF5D-1D64-4A73-9469-DA2EDC00F69D@redhat.com> <553DBDAE.7080603@ieee.org> <554B84BA.9000501@ieee.org>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53680 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750780AbbEGQs4 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 May 2015 12:48:56 -0400
In-Reply-To: <554B84BA.9000501@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>
Cc: Sage Weil <sage@newdream.net>, Ilya Dryomov <idryomov@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

Alex,

Thanks for circling back.

We should prioritize correctness and accuracy over promptness here; thi=
s isn=92t a critical feature and I=92d like my first submission to rece=
ive a thorough review.

Thanks,
=97Doug

> On May 7, 2015, at 11:28 AM, Alex Elder <elder@ieee.org> wrote:
>=20
> On 04/26/2015 11:40 PM, Alex Elder wrote:
>> On 04/26/2015 11:35 PM, Douglas Fuller wrote:
>>> This solution just feels hacky and inefficient, so I think there is=
 a
>>> desire to feel like we at least tried to come up something simpler
>>> and more efficient before proceeding.
>>=20
>> Right.  And somehow more fitting with the existing code, if
>> that's possible.  There are a few things in this proposal
>> that are just special case code, and it would be nice to
>> avoid that.
>>=20
>> I'm sorry I've been too busy today to get back to this.  I spent
>> a lot of time on Saturday getting ramped back up on this code
>> so I could provide a decent review...
>>=20
>> I'm going to at least look at the code (error on a read op)
>> before going to bed, so I at least know what the problem is.
>> I'll try to have something to say (even if it's "I've got
>> nothing") in the next day or two.
>>=20
>>                    -Alex
>=20
> It's been a week and a half since I sent this.  I don't
> expect to be able to contribute anything for at least a
> few more days.
>=20
> If adding this functionality is something you need quickly,
> I don't want you to be waiting for me.
>=20
> If you can wait, I will gladly review it and offer my
> suggestions for a better way (if I can think of one...).
>=20
> But if not, you should just proceed with what you have
> if it solves the problem.
>=20
> I just don't want to keep you waiting.
>=20
> 					-Alex

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
