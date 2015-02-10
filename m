From: John Spray <john.spray@redhat.com>
Subject: Re: Ceph bindings for go & docker
Date: Tue, 10 Feb 2015 11:25:37 +0000
Message-ID: <CAGd4Wr1QvyZZQ+ioymX_hirNzdRj__Yn8SLSuNrd03AQT3cy3w@mail.gmail.com>
References: <54D8EB16.1090801@dachary.org>
	<1220716523.14167671.1423506225216.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f51.google.com ([209.85.215.51]:39620 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750801AbbBJLZi convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Feb 2015 06:25:38 -0500
Received: by labgq15 with SMTP id gq15so19489286lab.6
        for <ceph-devel@vger.kernel.org>; Tue, 10 Feb 2015 03:25:37 -0800 (PST)
In-Reply-To: <1220716523.14167671.1423506225216.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <nwatkins@redhat.com>
Cc: Loic Dachary <loic@dachary.org>, Ceph Development <ceph-devel@vger.kernel.org>, Vincent Batts <vbatts@redhat.com>, Johan Euphrosine <proppy@google.com>

It would also be pretty interesting to do a CephFS driver here using
subdirs as volumes.  Just a thought, if anyone writes the RBD driver
they could put "rbd" in the name so that we can disambiguate them in
future?

Cheers,
John

On Mon, Feb 9, 2015 at 6:23 PM, Noah Watkins <nwatkins@redhat.com> wrot=
e:
> Hi Loic,
>
> This sounds great. The librados bindings have good test converage, bu=
t I merged a PR for RBD support a couple weeks ago and haven't had time=
 to get it cleaned up and tests written. Do you need support for the AI=
O interface in librbd?
>
> -Noah
>
> ----- Original Message -----
> From: "Loic Dachary" <loic@dachary.org>
> To: "Noah Watkins" <noah.watkins@inktank.com>
> Cc: "Ceph Development" <ceph-devel@vger.kernel.org>, "Vincent Batts" =
<vbatts@redhat.com>, "Johan Euphrosine" <proppy@google.com>
> Sent: Monday, February 9, 2015 9:15:02 AM
> Subject: Ceph bindings for go & docker
>
> Hi,
>
> I discovered https://github.com/noahdesu/go-ceph today :-) It would b=
e useful in the context of a Ceph volume driver for docker ( see https:=
//github.com/docker/docker/issues/10661 & https://github.com/docker/doc=
ker/pull/8484 ).
>
> Are you a docker user by any chance ?
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
