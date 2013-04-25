From: Gregory Farnum <greg@inktank.com>
Subject: Re: OSD abstract class
Date: Thu, 25 Apr 2013 09:45:02 -0700
Message-ID: <CAPYLRzirdWRaAEDP7UrrgV-AGcj3KoEoHOtC+A7DFYJD7BQbCA@mail.gmail.com>
References: <5178E6AE.6060609@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f172.google.com ([74.125.82.172]:61809 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758579Ab3DYQpE convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Apr 2013 12:45:04 -0400
Received: by mail-we0-f172.google.com with SMTP id r3so2736695wey.31
        for <ceph-devel@vger.kernel.org>; Thu, 25 Apr 2013 09:45:02 -0700 (PDT)
In-Reply-To: <5178E6AE.6060609@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Apr 25, 2013 at 1:17 AM, Loic Dachary <loic@dachary.org> wrote:
> Hi,
>
> In the context of the implementation of
>
> http://wiki.ceph.com/01Planning/02Blueprints/Dumpling/Erasure_encodin=
g_as_a_storage_backend
>
> I'm preparing tests to assert that the modifications that will be mad=
e to the existing PG and ReplicatedPG will not introduce regressions. U=
nless I'm mistaken, there are no unit tests or functional tests for PG =
or ReplicatedPG at the moment. I thought that it might be useful to add=
 an abstract OSD class from which OSD is derived, to allow a test to de=
rive from it to implement synthetic behavior.
>
>
> I gave it a try and it passes make check successfully. It is a little=
 hairy because I commented out the code instead of removing it to help =
with rebasing.
>
> https://github.com/dachary/ceph/commit/a9eb690a3537c3f844b47e76cde048=
b084e314eb
>
> I'll now try to use it to implement some tests for ReplicatedPG.
>
> I would very much appreciate if someone has an advice on the best way=
 to proceed. Even if it's to say : "you're crazy, don't go there ! you'=
re wasting your time, there is a much simpler way !" ;-)

What's your plot here? The OSD is fairly large to be doing unit tests
on (although it's not insensible) =97 but if we want to form a new PG i=
t
might be best to start out by making abstract PG implementations.
That'll be a bit easier since I believe I they only access the
OSDService now, and not the OSD proper.
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
