From: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <szibis@gmail.com>
Subject: Re: Inject configuration change into cluster
Date: Mon, 17 Sep 2012 08:36:09 +0200
Message-ID: <CAMwB3TgAYd1UNqpsmBbub-vK05Lu5Jn2JH=+_dW-PGY7Q9YsHA@mail.gmail.com>
References: <1FC69721-C852-4B56-ACE6-073137C5290D@portal.onet.pl>
	<5045B928.1050706@widodh.nl>
	<1BF27E0D85AE8C45A1BB84890DC4BFFB8A7C49@MXMBON05.grupa.onet>
	<5045CB80.50508@widodh.nl>
	<alpine.DEB.2.00.1209040832550.13403@cobra.newdream.net>
	<CAMwB3Tj-9UOG+ax_BtuizUjr-NdCdG5RVRmhr7ntdr6-Cmtdrg@mail.gmail.com>
	<alpine.DEB.2.00.1209050852250.8916@cobra.newdream.net>
	<58915F57-D1DA-4BBE-A205-A5063DDCD789@grupaonet.pl>
	<alpine.DEB.2.00.1209141211010.18057@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:34394 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751302Ab2IQGgK convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 17 Sep 2012 02:36:10 -0400
Received: by qaas11 with SMTP id s11so1312017qaa.19
        for <ceph-devel@vger.kernel.org>; Sun, 16 Sep 2012 23:36:09 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1209141211010.18057@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: =?ISO-8859-2?Q?Skowron_S=B3awomir?= <slawomir.skowron@grupaonet.pl>, Wido den Hollander <wido@widodh.nl>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Ok, i will try, but i have all day meeting today, and tomorrow.

One more question, is there any way to check configuration not from
ceph.conf, but from running daemon in cluster ??

On Fri, Sep 14, 2012 at 9:12 PM, Sage Weil <sage@inktank.com> wrote:
> Hi,
>
> <On Wed, 5 Sep 2012, Skowron S?awomir wrote:
>> Dnia 5 wrz 2012 o godz. 17:53 "Sage Weil" <sage@inktank.com> napisa?=
(a):
>>
>> > On Wed, 5 Sep 2012, S?awomir Skowron wrote:
>> >> Ok, but in global case, when i use, a chef/puppet or any other, i=
 wish
>> >> to change configuration in ceph.conf, and reload daemon to get ne=
w
>> >> configuration changes from ceph.conf, this feature would be very
>> >> helpful in ceph administration.
>> >>
>> >> Inject is ok, for testing, or debuging.
>> >
>> > Opened http://tracker.newdream.net/issues/3086.  There is already =
an issue
>> > open for reloading the config file,
>> > http://tracker.newdream.net/issues/2459.
>> >
>>
>> Thanks. This is what i mean.
>> Is this feature have a chance, to be implemented in next months ??
>
> I pushed a branch, wip-tp, that implements this.  Want to give it a s=
pin?
> Just inject the config option change (via the admin socket or injecta=
rgs)
> and it'll resize the thread pool.
>
> sage
>
>>
>> > sage
>> >
>> >>
>> >> On Tue, Sep 4, 2012 at 5:34 PM, Sage Weil <sage@inktank.com> wrot=
e:
>> >>> On Tue, 4 Sep 2012, Wido den Hollander wrote:
>> >>>> On 09/04/2012 10:30 AM, Skowron S?awomir wrote:
>> >>>>> Ok, thanks.
>> >>>>>
>> >>>>> Number of workers used for recover, or numer of disk threads.
>> >>>>>
>> >>>>
>> >>>> I think those can be changed while the OSD is running. You coul=
d always give
>> >>>> it a try.
>> >>>
>> >>> The thread pool sizes can't currently be adjusted, unfortunately=
=2E  It
>> >>> wouldn't be too difficult to change that...
>> >>>
>> >>> sage
>> >>>
>> >>>>
>> >>>> Wido
>> >>>>
>> >>>>> -----Original Message-----
>> >>>>> From: Wido den Hollander [mailto:wido@widodh.nl]
>> >>>>> Sent: Tuesday, September 04, 2012 10:18 AM
>> >>>>> To: Skowron S?awomir
>> >>>>> Cc: ceph-devel@vger.kernel.org
>> >>>>> Subject: Re: Inject configuration change into cluster
>> >>>>>
>> >>>>> On 09/04/2012 07:04 AM, Skowron S?awomir wrote:
>> >>>>>> Is there any way now, to inject new configuration change, wit=
hout
>> >>>>>> restarting daemons ??
>> >>>>>>
>> >>>>>
>> >>>>> Yes, you can use the injectargs command.
>> >>>>>
>> >>>>> $ ceph osd tell 0 injectargs '--debug-osd 20'
>> >>>>>
>> >>>>> What do you want to change? Not everything can be changed whil=
e the OSD is
>> >>>>> running.
>> >>>>>
>> >>>>> Wido
>> >>>>>
>> >>>>>> Regards
>> >>>>>>
>> >>>>>> Slawomir Skowron--
>> >>>>>> To unsubscribe from this list: send the line "unsubscribe cep=
h-devel"
>> >>>>>> in the body of a message to majordomo@vger.kernel.org More ma=
jordomo
>> >>>>>> info at  http://vger.kernel.org/majordomo-info.html
>> >>>>>>
>> >>>>>
>> >>>>> N???????????????r??????y?????????b???X???????v???^???)?{.n???+=
?????????z???]z???{ay??? ?????,j ??????f?????????h?????????z??? ???w???=
??????
>> >>>>> ?????????j:+v?????????w???j???m???????????? ????????????zZ+???=
????j"??????!tml=3D
>> >>>>>
>> >>>>
>> >>>> --
>> >>>> To unsubscribe from this list: send the line "unsubscribe ceph-=
devel" in
>> >>>> the body of a message to majordomo@vger.kernel.org
>> >>>> More majordomo info at  http://vger.kernel.org/majordomo-info.h=
tml
>> >>>>
>> >>>>
>> >>> --
>> >>> To unsubscribe from this list: send the line "unsubscribe ceph-d=
evel" in
>> >>> the body of a message to majordomo@vger.kernel.org
>> >>> More majordomo info at  http://vger.kernel.org/majordomo-info.ht=
ml
>> >>
>> >>
>> >>
>> >> --
>> >> -----
>> >> Pozdrawiam
>> >>
>> >> S?awek "sZiBis" Skowron
>> >>
>> >>
>>



--=20
-----
Pozdrawiam

S=B3awek "sZiBis" Skowron
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
