From: Mark Nelson <mnelson@redhat.com>
Subject: Re: Move RBD Cache on clients from RAM to SSD.
Date: Tue, 16 Jun 2015 06:47:28 -0500
Message-ID: <55800CD0.1060003@redhat.com>
References: <557FD76C.9070905@gmail.com> <9F993C58-6380-4132-A87F-850A84A397DB@redhat.com> <55800BC5.7020200@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51002 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752124AbbFPLra (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 16 Jun 2015 07:47:30 -0400
In-Reply-To: <55800BC5.7020200@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mike <mike.almateia@gmail.com>, Sebastien Han <seb@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

As an alternative, would dm-cache or bcache on the client VM be an opti=
on?

Mark

On 06/16/2015 06:43 AM, Mike wrote:
> 16.06.2015 12:54, Sebastien Han =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> This is not possible at the moment but long ago a BP was register to=
 allow a multiple backend functionality. (can=E2=80=99t find it anymore=
)
>> Unfortunately I don=E2=80=99t think this BP got much attention :/
>
> Thanks for answer. It's sad, that this feature not interesting anyone=
=2E
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
