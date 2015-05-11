From: Gregory Farnum <greg@gregs42.com>
Subject: Re: Analyzing the nightlies
Date: Mon, 11 May 2015 15:50:21 -0700
Message-ID: <CAC6JEv_2wHzYeHseRAUx5guizswz2PsGE8wGVL=KpBYiBbkziw@mail.gmail.com>
References: <554DD3D7.7090407@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:32822 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750837AbbEKWuW convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 May 2015 18:50:22 -0400
Received: by iepj10 with SMTP id j10so118012945iep.0
        for <ceph-devel@vger.kernel.org>; Mon, 11 May 2015 15:50:21 -0700 (PDT)
Received: from mail-ig0-f174.google.com (mail-ig0-f174.google.com. [209.85.213.174])
        by mx.google.com with ESMTPSA id f11sm10689142iod.7.2015.05.11.15.50.21
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 May 2015 15:50:21 -0700 (PDT)
Received: by igbsb11 with SMTP id sb11so85887860igb.0
        for <ceph-devel@vger.kernel.org>; Mon, 11 May 2015 15:50:21 -0700 (PDT)
In-Reply-To: <554DD3D7.7090407@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Yuri Weinstein <yweinste@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Sat, May 9, 2015 at 2:31 AM, Loic Dachary <loic@dachary.org> wrote:
> Hi Yuri,
>
> It would be useful to add more information bout how the nightlies are=
 analyzed at
>
>    http://tracker.ceph.com/projects/ceph-releases/wiki/HOWTO_monitor_=
the_automated_tests_AKA_nightlies
>
> At this point my understanding is that you look over all of them and =
you carry the burden of
>
> * sorting out the environmental noise
> * creating new bugs for errors for which there is no match in the tra=
cker
> * add a link to the failed job in pre-existing issues found in the tr=
acker (useful to figure out the frequency and helps with debug when the=
re are multiple outputs / logs)
>
> You do so by using tools such as https://github.com/jcsp/scrape/blob/=
master/scrape.py and maybe others and you also format your mail message=
s so that they can be parsed by a program (although such a program does=
 not exist yet, it could go over all your messages and build a database=
 from the mails you sent).
>
> In the http://lists.ceph.com/private.cgi/ceph-qa-ceph.com/ archives, =
I see that Greg also regularly goes over the errors and other developer=
s also do. What I'm not sure about is if it's best effort ? Is there a =
time like bug scrubbing or sprint planning when developers say "Let's a=
nalyze QA results and dig bugs" ?

I know that Yuri looks at some nightlies but I'm not sure which ones
he's responsible for =E2=80=94 I think it's the upgrade suites?
In general analyzing the nightlies is (unfortunately? maybe
positively) the team lead's responsibility to make happen. Right now I
think that means we each pretty much go over (or ignore) the tests
covering our area as it suits us; I send emails because I find it
convenient but I know Sam mostly just makes bugs. Now that things have
settled down some in the labs I'm planning to sett up a rotation
amongst my team to cover them (it is *not* a small time commitment,
sadly).

The most annoying part of the job is when the lab breaks =E2=80=94 real=
izing
that this means we can or cannot ignore such-and-such a set of
symptoms, making sure that it's not something new in Ceph or the test
that we changed, and then adjudicating responsibility for the fix
between the very nebulous group of people whose fault or
responsibility it might be. (We have a lot of hands in teuthology and
a lot in the lab, not in an entirely overlapping set, and any one of
them can cause breakage.) It's not always clear when I see a batch of
runs failed over the weekend if the problem has been resolved yet or
not. :(
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
