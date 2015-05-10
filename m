From: Yuri Weinstein <yweinste@redhat.com>
Subject: Re: Analyzing the nightlies
Date: Sat, 9 May 2015 20:27:51 -0400 (EDT)
Message-ID: <950294072.16669358.1431217671812.JavaMail.zimbra@redhat.com>
References: <554DD3D7.7090407@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:33183 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751658AbbEJA25 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 9 May 2015 20:28:57 -0400
In-Reply-To: <554DD3D7.7090407@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Sage Weil <sweil@redhat.com>

Loic=20

You description on high level is correct.  There are, of cause, more de=
tails when someone actually goes thru the nightlies results.

As far as you question "Is there a time like bug scrubbing or sprint pl=
anning when developers say "Let's analyze QA results and dig bugs" ?" -=
 I surely hope so and do see updates and triages on bugs in the tracker=
, but not 100% sure what exactly our process is, so Sage and developmen=
t leads are better persons to ask this.

Also when you say "What I'm not sure about is if it's best effort ? "  =
- do you have something in mind instead or in addition to what we do no=
w?
( I hope something that can lighten the burden :) )


Thx
YuriW

----- Original Message -----
=46rom: "Loic Dachary" <loic@dachary.org>
To: "Yuri Weinstein" <yweinste@redhat.com>
Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
Sent: Saturday, May 9, 2015 2:31:03 AM
Subject: Analyzing the nightlies

Hi Yuri,

It would be useful to add more information bout how the nightlies are a=
nalyzed at

   http://tracker.ceph.com/projects/ceph-releases/wiki/HOWTO_monitor_th=
e_automated_tests_AKA_nightlies

At this point my understanding is that you look over all of them and yo=
u carry the burden of=20

* sorting out the environmental noise
* creating new bugs for errors for which there is no match in the track=
er
* add a link to the failed job in pre-existing issues found in the trac=
ker (useful to figure out the frequency and helps with debug when there=
 are multiple outputs / logs)

You do so by using tools such as https://github.com/jcsp/scrape/blob/ma=
ster/scrape.py and maybe others and you also format your mail messages =
so that they can be parsed by a program (although such a program does n=
ot exist yet, it could go over all your messages and build a database f=
rom the mails you sent).

In the http://lists.ceph.com/private.cgi/ceph-qa-ceph.com/ archives, I =
see that Greg also regularly goes over the errors and other developers =
also do. What I'm not sure about is if it's best effort ? Is there a ti=
me like bug scrubbing or sprint planning when developers say "Let's ana=
lyze QA results and dig bugs" ?

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
