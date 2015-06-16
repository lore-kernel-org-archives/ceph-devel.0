From: Mike <mike.almateia@gmail.com>
Subject: Re: Move RBD Cache on clients from RAM to SSD.
Date: Tue, 16 Jun 2015 14:55:30 +0300
Message-ID: <55800EB2.3040200@gmail.com>
References: <557FD76C.9070905@gmail.com> <9F993C58-6380-4132-A87F-850A84A397DB@redhat.com> <55800BC5.7020200@gmail.com> <55800CD0.1060003@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:33793 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756284AbbFPLze (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Jun 2015 07:55:34 -0400
Received: by lbbti3 with SMTP id ti3so9165753lbb.1
        for <ceph-devel@vger.kernel.org>; Tue, 16 Jun 2015 04:55:32 -0700 (PDT)
In-Reply-To: <55800CD0.1060003@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>, Sebastien Han <seb@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

16.06.2015 14:47, Mark Nelson =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> As an alternative, would dm-cache or bcache on the client VM be an op=
tion?
>=20
> Mark

I not think it's working witch librbd in usecase with libvirt. This
solution working with kernel rbd module when you can associate rbd bloc=
k
device with bcache device.
I think so.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
