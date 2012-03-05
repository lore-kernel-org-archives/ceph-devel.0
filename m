From: Yehuda Sadeh Weinraub <yehuda.sadeh@dreamhost.com>
Subject: Re: RadosGW problems with copy in s3
Date: Mon, 5 Mar 2012 10:59:31 -0800
Message-ID: <CAC-hyiFkVyUHA1mthYaSVoqxQSrz5g2zo1kmLQAfDanzAxjH1A@mail.gmail.com>
References: <CAMwB3ThF2kTWNDJM9zYOVh0ud29nAoib4yTwNRgiJuacDKh=7w@mail.gmail.com>
	<CAC-hyiHSUYv-Mk7RxB-_a8ObePrf9osLRFjj-G2_9Dz6z8v6Vw@mail.gmail.com>
	<CAMwB3ThZ4jPis_Bb9tsf=HTnh3gLd6CNkn2XMr4xo09bO3hEiQ@mail.gmail.com>
	<CAC-hyiHB0aDsEO8ES8pqhcXB38MR1QNZLMB=jyRm2p_Yp7V8Aw@mail.gmail.com>
	<CAC-hyiFL429jjfi7J7fiwoshdRQRq9_1AhECJ+sg2=nV+5NpZw@mail.gmail.com>
	<CAMwB3Tje2tgruL8yP29Q1eYTON5kuS3neetA=6zXed4OriJefg@mail.gmail.com>
	<CAC-hyiHFUAGWJf1MxGS=MBcdsHSYrtpjcPo6di3MOK=S=6Hj0g@mail.gmail.com>
	<CAMwB3TjuDhRfTheJvTKx7yiTy7JSiTp2h795fuNS-mjFeJP=Fg@mail.gmail.com>
	<CAMwB3Tg3e7dKpves54sFag6BTp5PAfYwOgYQ4PHW0gs2oDkTJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:58868 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757443Ab2CES7c convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Mar 2012 13:59:32 -0500
Received: by bkcik5 with SMTP id ik5so3490682bkc.19
        for <ceph-devel@vger.kernel.org>; Mon, 05 Mar 2012 10:59:31 -0800 (PST)
In-Reply-To: <CAMwB3Tg3e7dKpves54sFag6BTp5PAfYwOgYQ4PHW0gs2oDkTJw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <slawomir.skowron@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Mon, Mar 5, 2012 at 2:23 AM, S=C5=82awomir Skowron
<slawomir.skowron@gmail.com> wrote:
> 2012/3/1 S=C5=82awomir Skowron <slawomir.skowron@gmail.com>:
>> 2012/2/29 Yehuda Sadeh Weinraub <yehuda.sadeh@dreamhost.com>:
>>> On Wed, Feb 29, 2012 at 5:06 AM, S=C5=82awomir Skowron
>>> <slawomir.skowron@gmail.com> wrote:
>>>>
>>>> Ok, it's intentional.
>>>>
>>>> We are checking meta info about files, then, checking md5 of file
>>>> content. In parallel, updating object that have change, and then
>>>> archiving this objects in another key, and last thing is deleting
>>>> objects that expires.
>>>>
>>>> This happens over and over, because, this site is changing many ti=
mes.
>>>>
>>>> Now i don't have any idea, how to workaround this problem, without
>>>> shutdown this app :(
>>>
>>> I looked at your osd log again, and there are other things that don=
't
>>> look right. I'll also need you to turn on 'debug osd =3D 20' and 'd=
ebug
>>> filestore =3D 20'.
>>
>> osd.24 almost 10 minutes of log in debug, as above in attachment.
>>
>>> Other than that, I just pushed a workaround that might improve thin=
gs.
>>> It's on the wip-rgw-atomic-no-retry branch on github (based on
>>> 0.42.2), so you might want to give it a spin and let us know whethe=
r
>>> it actually improved things.
>>
>> Ok i will try, and let you know soon.
>
> Unfortunately, no improvment after upgrade for this version.
>
It looks like an issue with updating the bucket index, but I'm having
trouble confirming it, as the log provided (of osd.24) doesn't contain
any relevant operations. If you could provide a log from the relevant
osd it may be very helpful.

You can find the relevant osd by looking at an operation that took too
long, and look for a request like the following:

2012-02-28 20:20:10.944859 7fb1affb7700 -- 10.177.64.6:0/1020439 -->
10.177.64.4:6839/7954 -- osd_op(client.65007.0:587 .dir.3 [call
rgw.bucket_prepare_op] 7.ccb26a35) v4 -- ?+0 0xf25270 con 0xbcd1c0

It would be easiest looking for the reply to that request as it will
contain the osd id (search for a line that contains osd_op_reply and
the client.65007.0:587 request id).

In the mean time, I created issue #2139 for a probable culprit. Having
the relevant logs will allow us to verify whether you're hitting that
or another issue.

Thanks,
Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
