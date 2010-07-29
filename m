From: Anton VG <anton.vazir@gmail.com>
Subject: Re: Roadmap to production
Date: Thu, 29 Jul 2010 17:31:51 +0500
Message-ID: <AANLkTi=fa7BG-J47Y3V7j0d=Zo9OKXahA50+Wk5icx8U@mail.gmail.com>
References: <i29ckr$lab$1@dough.gmane.org>
	<Pine.LNX.4.64.1007271024060.28672@cobra.newdream.net>
	<i2r4ih$nki$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:38546 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756996Ab0G2Mbw convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Jul 2010 08:31:52 -0400
Received: by pwi5 with SMTP id 5so67293pwi.19
        for <ceph-devel@vger.kernel.org>; Thu, 29 Jul 2010 05:31:52 -0700 (PDT)
In-Reply-To: <i2r4ih$nki$1@dough.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Thomas Mueller <thomas@chaschperli.ch>
Cc: ceph-devel@vger.kernel.org

Also, maybe there should be a small check list for different usage
scenarios, like for example maybe
the most generic usage will be just a file storage, without needs for
snapshotting, dkms support, and other complicated stuff.

works/tested
- file storing and retrieving in ext3/4
- snapshotting works
- dkms
- usage
=2E..

so those who'd need just a plain file store - would not afraid trying a=
nd using.

2010/7/29 Thomas Mueller <thomas@chaschperli.ch>:
> Am Wed, 28 Jul 2010 11:25:40 -0700 schrieb Sage Weil:
>
>> On Thu, 22 Jul 2010, Thomas Mueller wrote:
>>> reading http://ceph.newdream.net/roadmap/ leaves me with some
>>> questions. :)
>>>
>>> * is there some roadmap when CEPH will be official announced
>>> "production ready"
>>
>> These are good questions. =A0:)
>>
>> I've made the Ceph site link directly into the redmine roadmap, wher=
e
>> we'll be maintaining a detailed set of issues (features, bugs) for e=
ach
>> upcoming release along with a target release date. =A0The roadmap no=
w
>> includes a v1.0, which will be something we at least will cautiously
>> deploy in production. =A0I would like to get there (or close to it) =
by the
>> end of the year.
>>
>> I prefer to avoid "production ready" as that is a bit of a subjectiv=
e
>> term. =A0Different people have different stability requirements and
>> expectations. =A0That said, I would like v1.0 to be something I am
>> comfortable encouraging people to use in real (but non-critical)
>> deployments.
>>
>
> answering here the question from another thread because IMHO it fits
> better:
>
>> > what leads me to my other question: when will ceph be considered
>> > "stable"?
>> Soon? =A0 =A0I'd be interested in hearing what you (or anyone else) =
expect
>> from a "stable" v1.0 release.
>
> as storage is a fundamental service there are for sure other "stable"
> demands than for a newsreader/mailclient/whateveruncriticalapp.
>
> I'll give it a try to describe my idea of stable:
>
> - stable means promised features (http://ceph.newdream.net/about/) wo=
rk
> reliable
> - no workarounds needed to use these features
> - (at least) in a series of stable releases (aka "1.x") i can upgrade
> without downtime
> - in a series of stable releases a can do a rolling upgrade
> - in a stable series there no design changes introduced
>
>
>
> - Thomas
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
