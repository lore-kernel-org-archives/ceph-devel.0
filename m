From: John Spray <john.spray@redhat.com>
Subject: Re: Installing Ceph without root privilege
Date: Fri, 31 Jul 2015 11:09:05 +0100
Message-ID: <55BB4941.5000004@redhat.com>
References: <2C711032-0C8E-4490-85B2-2D7B89DCA153@m.titech.ac.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43343 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751029AbbGaKJI (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 31 Jul 2015 06:09:08 -0400
In-Reply-To: <2C711032-0C8E-4490-85B2-2D7B89DCA153@m.titech.ac.jp>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Piyawath Boukom <boukom.p.aa@m.titech.ac.jp>, ceph-devel@vger.kernel.org

On 31/07/15 07:10, Piyawath Boukom wrote:
> Dear Ceph-dev team,
>
> My name is Piyawath. I=E2=80=99m trying to set up Ceph on university=E2=
=80=99s machine.
>
> Unfortunately, I am able to install/set up it in user mode (not root)=
, including creating Ceph user and other processes. Is it possible to d=
o set up without root privilege ?
>
> I=E2=80=99m quite new in this field, please forgive me if I ignorantl=
y asked you.

Hi,

I guess if you're installing as non-root then you probably just want=20
something to experiment with a bit?

The easiest thing may be to compile from source:
http://ceph.com/docs/next/install/build-ceph/

=2E..and then create a temporary "vstart" cluster:
http://ceph.com/docs/next/dev/quick_guide/

This is not at all suitable for putting any real data in, but will let=20
you play around a bit with the ceph command line etc.  If you need a=20
more realistic system I would suggest asking your administrator for a=20
way to create virtual machines, so that you can have root in the virtua=
l=20
machines and install packages there.

John
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
