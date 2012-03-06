From: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <szibis@gmail.com>
Subject: Re: RadosGW problems with copy in s3
Date: Tue, 6 Mar 2012 11:08:59 +0100
Message-ID: <CAMwB3Tjftbdh9kxMgxkU9-vEmyxj2X4b4a0o2HC_e=7xXZ6RMw@mail.gmail.com>
References: <CAMwB3ThF2kTWNDJM9zYOVh0ud29nAoib4yTwNRgiJuacDKh=7w@mail.gmail.com>
	<CAC-hyiHSUYv-Mk7RxB-_a8ObePrf9osLRFjj-G2_9Dz6z8v6Vw@mail.gmail.com>
	<CAMwB3ThZ4jPis_Bb9tsf=HTnh3gLd6CNkn2XMr4xo09bO3hEiQ@mail.gmail.com>
	<CAC-hyiHB0aDsEO8ES8pqhcXB38MR1QNZLMB=jyRm2p_Yp7V8Aw@mail.gmail.com>
	<CAC-hyiFL429jjfi7J7fiwoshdRQRq9_1AhECJ+sg2=nV+5NpZw@mail.gmail.com>
	<CAMwB3Tje2tgruL8yP29Q1eYTON5kuS3neetA=6zXed4OriJefg@mail.gmail.com>
	<CAC-hyiHFUAGWJf1MxGS=MBcdsHSYrtpjcPo6di3MOK=S=6Hj0g@mail.gmail.com>
	<CAMwB3TjuDhRfTheJvTKx7yiTy7JSiTp2h795fuNS-mjFeJP=Fg@mail.gmail.com>
	<CAMwB3Tg3e7dKpves54sFag6BTp5PAfYwOgYQ4PHW0gs2oDkTJw@mail.gmail.com>
	<CAC-hyiFkVyUHA1mthYaSVoqxQSrz5g2zo1kmLQAfDanzAxjH1A@mail.gmail.com>
	<-8255131364718062163@unknownmsgid>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:56007 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758022Ab2CFKJB convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Mar 2012 05:09:01 -0500
Received: by wibhm2 with SMTP id hm2so2506308wib.19
        for <ceph-devel@vger.kernel.org>; Tue, 06 Mar 2012 02:08:59 -0800 (PST)
In-Reply-To: <-8255131364718062163@unknownmsgid>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehuda.sadeh@dreamhost.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

2012/3/5 S=C5=82awomir Skowron <szibis@gmail.com>:
> On 5 mar 2012, at 19:59, Yehuda Sadeh Weinraub
> <yehuda.sadeh@dreamhost.com> wrote:
>
>> On Mon, Mar 5, 2012 at 2:23 AM, S=C5=82awomir Skowron
>> <slawomir.skowron@gmail.com> wrote:
>>> 2012/3/1 S=C5=82awomir Skowron <slawomir.skowron@gmail.com>:
>>>> 2012/2/29 Yehuda Sadeh Weinraub <yehuda.sadeh@dreamhost.com>:
>>>>> On Wed, Feb 29, 2012 at 5:06 AM, S=C5=82awomir Skowron
>>>>> <slawomir.skowron@gmail.com> wrote:
>>>>>>
>>>>>> Ok, it's intentional.
>>>>>>
>>>>>> We are checking meta info about files, then, checking md5 of fil=
e
>>>>>> content. In parallel, updating object that have change, and then
>>>>>> archiving this objects in another key, and last thing is deletin=
g
>>>>>> objects that expires.
>>>>>>
>>>>>> This happens over and over, because, this site is changing many =
times.
>>>>>>
>>>>>> Now i don't have any idea, how to workaround this problem, witho=
ut
>>>>>> shutdown this app :(
>>>>>
>>>>> I looked at your osd log again, and there are other things that d=
on't
>>>>> look right. I'll also need you to turn on 'debug osd =3D 20' and =
'debug
>>>>> filestore =3D 20'.
>>>>
>>>> osd.24 almost 10 minutes of log in debug, as above in attachment.
>>>>
>>>>> Other than that, I just pushed a workaround that might improve th=
ings.
>>>>> It's on the wip-rgw-atomic-no-retry branch on github (based on
>>>>> 0.42.2), so you might want to give it a spin and let us know whet=
her
>>>>> it actually improved things.
>>>>
>>>> Ok i will try, and let you know soon.
>>>
>>> Unfortunately, no improvment after upgrade for this version.
>>>
>> It looks like an issue with updating the bucket index, but I'm havin=
g
>> trouble confirming it, as the log provided (of osd.24) doesn't conta=
in
>> any relevant operations. If you could provide a log from the relevan=
t
>> osd it may be very helpful.
>>
>> You can find the relevant osd by looking at an operation that took t=
oo
>> long, and look for a request like the following:
>>
>> 2012-02-28 20:20:10.944859 7fb1affb7700 -- 10.177.64.6:0/1020439 -->
>> 10.177.64.4:6839/7954 -- osd_op(client.65007.0:587 .dir.3 [call
>> rgw.bucket_prepare_op] 7.ccb26a35) v4 -- ?+0 0xf25270 con 0xbcd1c0
>>
>> It would be easiest looking for the reply to that request as it will
>> contain the osd id (search for a line that contains osd_op_reply and
>> the client.65007.0:587 request id).
>>
>> In the mean time, I created issue #2139 for a probable culprit. Havi=
ng
>> the relevant logs will allow us to verify whether you're hitting tha=
t
>> or another issue.
>>
>> Thanks,
>> Yehuda
>
> Ok, because of time difference between as i will try too find this on
> the morning in job. If there will be insufficient verbosity of logs i
> will try too start all OSD in debug, as you write earlier, and then
> generate, the problem again.
> I try to send logs as soon as possible.
>
> Regards
> Slawomir Skowron

All logs from osd.24, osd.62, and osd.36 with osd debug =3D20 and
filestore debug =3D 20 from 2012-03-06 10:25 and more.

http://217.144.195.170/ceph/osd.24.log.tar.gz   (348MB) - machine 1 - r=
ack1
http://217.144.195.170/ceph/osd.36.log.tar.gz   (26MB) - machine 2 - ra=
ck 2
http://217.144.195.170/ceph/osd.62.log.tar.gz   (23MB) - machine3 - rac=
k 3

--=20
-----
Pozdrawiam

S=C5=82awek "sZiBis" Skowron
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
