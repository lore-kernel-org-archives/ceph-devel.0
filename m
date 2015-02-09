From: Noah Watkins <nwatkins@redhat.com>
Subject: Re: Ceph bindings for go & docker
Date: Mon, 9 Feb 2015 13:23:45 -0500 (EST)
Message-ID: <1220716523.14167671.1423506225216.JavaMail.zimbra@redhat.com>
References: <54D8EB16.1090801@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]:42050 "EHLO
	mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933560AbbBISYv convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Feb 2015 13:24:51 -0500
In-Reply-To: <54D8EB16.1090801@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Vincent Batts <vbatts@redhat.com>, Johan Euphrosine <proppy@google.com>

Hi Loic,

This sounds great. The librados bindings have good test converage, but =
I merged a PR for RBD support a couple weeks ago and haven't had time t=
o get it cleaned up and tests written. Do you need support for the AIO =
interface in librbd?

-Noah

----- Original Message -----
=46rom: "Loic Dachary" <loic@dachary.org>
To: "Noah Watkins" <noah.watkins@inktank.com>
Cc: "Ceph Development" <ceph-devel@vger.kernel.org>, "Vincent Batts" <v=
batts@redhat.com>, "Johan Euphrosine" <proppy@google.com>
Sent: Monday, February 9, 2015 9:15:02 AM
Subject: Ceph bindings for go & docker

Hi,

I discovered https://github.com/noahdesu/go-ceph today :-) It would be =
useful in the context of a Ceph volume driver for docker ( see https://=
github.com/docker/docker/issues/10661 & https://github.com/docker/docke=
r/pull/8484 ).=20

Are you a docker user by any chance ?

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
