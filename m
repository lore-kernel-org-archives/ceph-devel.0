From: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <szibis@gmail.com>
Subject: Re: Inject configuration change into cluster
Date: Wed, 5 Sep 2012 12:37:11 +0200
Message-ID: <CAMwB3Tj-9UOG+ax_BtuizUjr-NdCdG5RVRmhr7ntdr6-Cmtdrg@mail.gmail.com>
References: <1FC69721-C852-4B56-ACE6-073137C5290D@portal.onet.pl>
	<5045B928.1050706@widodh.nl>
	<1BF27E0D85AE8C45A1BB84890DC4BFFB8A7C49@MXMBON05.grupa.onet>
	<5045CB80.50508@widodh.nl>
	<alpine.DEB.2.00.1209040832550.13403@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:41414 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758110Ab2IEKhL convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Sep 2012 06:37:11 -0400
Received: by qaas11 with SMTP id s11so4409613qaa.19
        for <ceph-devel@vger.kernel.org>; Wed, 05 Sep 2012 03:37:11 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1209040832550.13403@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Wido den Hollander <wido@widodh.nl>, =?ISO-8859-2?Q?Skowron_S=B3awomir?= <slawomir.skowron@grupaonet.pl>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Ok, but in global case, when i use, a chef/puppet or any other, i wish
to change configuration in ceph.conf, and reload daemon to get new
configuration changes from ceph.conf, this feature would be very
helpful in ceph administration.

Inject is ok, for testing, or debuging.

On Tue, Sep 4, 2012 at 5:34 PM, Sage Weil <sage@inktank.com> wrote:
> On Tue, 4 Sep 2012, Wido den Hollander wrote:
>> On 09/04/2012 10:30 AM, Skowron S?awomir wrote:
>> > Ok, thanks.
>> >
>> > Number of workers used for recover, or numer of disk threads.
>> >
>>
>> I think those can be changed while the OSD is running. You could alw=
ays give
>> it a try.
>
> The thread pool sizes can't currently be adjusted, unfortunately.  It
> wouldn't be too difficult to change that...
>
> sage
>
>>
>> Wido
>>
>> > -----Original Message-----
>> > From: Wido den Hollander [mailto:wido@widodh.nl]
>> > Sent: Tuesday, September 04, 2012 10:18 AM
>> > To: Skowron S?awomir
>> > Cc: ceph-devel@vger.kernel.org
>> > Subject: Re: Inject configuration change into cluster
>> >
>> > On 09/04/2012 07:04 AM, Skowron S?awomir wrote:
>> > > Is there any way now, to inject new configuration change, withou=
t
>> > > restarting daemons ??
>> > >
>> >
>> > Yes, you can use the injectargs command.
>> >
>> > $ ceph osd tell 0 injectargs '--debug-osd 20'
>> >
>> > What do you want to change? Not everything can be changed while th=
e OSD is
>> > running.
>> >
>> > Wido
>> >
>> > > Regards
>> > >
>> > > Slawomir Skowron--
>> > > To unsubscribe from this list: send the line "unsubscribe ceph-d=
evel"
>> > > in the body of a message to majordomo@vger.kernel.org More major=
domo
>> > > info at  http://vger.kernel.org/majordomo-info.html
>> > >
>> >
>> > N???????????????r??????y?????????b???X???????v???^???)?{.n???+????=
?????z???]z???{ay??? ?????,j ??????f?????????h?????????z??? ???w???????=
??
>> > ?????????j:+v?????????w???j???m???????????? ????????????zZ+???????=
j"??????!tml=3D
>> >
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
-----
Pozdrawiam

S=B3awek "sZiBis" Skowron
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
