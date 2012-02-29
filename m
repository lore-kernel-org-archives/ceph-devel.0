From: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <slawomir.skowron@gmail.com>
Subject: Re: RadosGW problems with copy in s3
Date: Wed, 29 Feb 2012 14:06:25 +0100
Message-ID: <CAMwB3Tje2tgruL8yP29Q1eYTON5kuS3neetA=6zXed4OriJefg@mail.gmail.com>
References: <CAMwB3ThF2kTWNDJM9zYOVh0ud29nAoib4yTwNRgiJuacDKh=7w@mail.gmail.com>
	<CAC-hyiHSUYv-Mk7RxB-_a8ObePrf9osLRFjj-G2_9Dz6z8v6Vw@mail.gmail.com>
	<CAMwB3ThZ4jPis_Bb9tsf=HTnh3gLd6CNkn2XMr4xo09bO3hEiQ@mail.gmail.com>
	<CAC-hyiHB0aDsEO8ES8pqhcXB38MR1QNZLMB=jyRm2p_Yp7V8Aw@mail.gmail.com>
	<CAC-hyiFL429jjfi7J7fiwoshdRQRq9_1AhECJ+sg2=nV+5NpZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:61686 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754691Ab2B2NG1 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Feb 2012 08:06:27 -0500
Received: by wibhm11 with SMTP id hm11so2671604wib.19
        for <ceph-devel@vger.kernel.org>; Wed, 29 Feb 2012 05:06:25 -0800 (PST)
In-Reply-To: <CAC-hyiFL429jjfi7J7fiwoshdRQRq9_1AhECJ+sg2=nV+5NpZw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehuda.sadeh@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

Ok, it's intentional.

We are checking meta info about files, then, checking md5 of file
content. In parallel, updating object that have change, and then
archiving this objects in another key, and last thing is deleting
objects that expires.

This happens over and over, because, this site is changing many times.

Now i don't have any idea, how to workaround this problem, without
shutdown this app :(

Another question is, why data from radosgw writing almost everything
only on one osd, and copies to 2 others, and only those. Is anyone can
explain this to me ??

/dev/sdu              275G  605M  260G   1% /vol0/data/osd.18
/dev/sdw              275G  608M  260G   1% /vol0/data/osd.21
/dev/sdz              275G  638M  260G   1% /vol0/data/osd.24
/dev/sde              275G  605M  260G   1% /vol0/data/osd.3
/dev/sdr              275G  605M  260G   1% /vol0/data/osd.16
/dev/sdaa             275G  696M  260G   1% /vol0/data/osd.25
/dev/sdp              275G  605M  260G   1% /vol0/data/osd.14
/dev/sdd              275G  605M  260G   1% /vol0/data/osd.2
/dev/sdk              275G  605M  260G   1% /vol0/data/osd.8
/dev/sdh              275G  608M  260G   1% /vol0/data/osd.6
/dev/sds              275G  605M  260G   1% /vol0/data/osd.17
/dev/sdf              275G  638M  260G   1% /vol0/data/osd.4
/dev/sdj              275G  637M  260G   1% /vol0/data/osd.9
/dev/sdc              275G  604M  260G   1% /vol0/data/osd.1
/dev/sdv              275G  2.7G  258G   2% /vol0/data/osd.20
/dev/sdn              275G  607M  260G   1% /vol0/data/osd.12
/dev/sdo              275G  605M  260G   1% /vol0/data/osd.13
/dev/sdg              275G  605M  260G   1% /vol0/data/osd.5
/dev/sdy              275G  633M  260G   1% /vol0/data/osd.23
/dev/sdm              275G  605M  260G   1% /vol0/data/osd.11
/dev/sdx              275G  605M  260G   1% /vol0/data/osd.22
/dev/sdb              275G  608M  260G   1% /vol0/data/osd.0
/dev/sdq              275G  605M  260G   1% /vol0/data/osd.15
/dev/sdl              275G  605M  260G   1% /vol0/data/osd.10
/dev/sdi              275G  605M  260G   1% /vol0/data/osd.7
/dev/sdt              275G  604M  260G   1% /vol0/data/osd.19


2012/2/28 Yehuda Sadeh Weinraub <yehuda.sadeh@dreamhost.com>:
> (resending to list)
>
> On Tue, Feb 28, 2012 at 11:53 AM, S=C5=82awomir Skowron
> <slawomir.skowron@gmail.com> wrote:
>>
>> 2012/2/28 Yehuda Sadeh Weinraub <yehuda.sadeh@dreamhost.com>:
>> > On Tue, Feb 28, 2012 at 3:43 AM, S=C5=82awomir Skowron
>> > <slawomir.skowron@gmail.com> wrote:
>> >> After some parallel copy command via botto for many files everyth=
ing,
>> >> going to slow down, and eventualy got timeout from nginx@radosgw.
>
>
> Note that you're overwriting the same object. Is that intentional?
>
>>
>> Reproduced logs in attachment.
>>
>
> I was able to recreate the issue. The problem is specifically related
> to the fact that you're overwriting the same object from 10s of
> parallel threads. What happens is that our race-detection code (that
> is related to the radosgw atomic object write) detects that the
> underlying object has been written and it needs to reread its header
> before overwriting it. This works well when there are a few writers t=
o
> the same object, but doesn't scale very well. I opened issue #2120 to
> track the issue.

You join this with Tasks #1956, and when this task go to development ??

> Yehuda

--=20
-----
Pozdrawiam

S=C5=82awek "sZiBis" Skowron
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
