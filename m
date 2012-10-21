From: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>
Subject: Re: Inject configuration change into cluster
Date: Sun, 21 Oct 2012 21:33:16 +0200
Message-ID: <CAOLwVUnZP2UKkLzR9rhfSFaHfEAOpZKyDrvNQ65N+af-VzJwmA@mail.gmail.com>
References: <1FC69721-C852-4B56-ACE6-073137C5290D@portal.onet.pl>
 <5045B928.1050706@widodh.nl> <1BF27E0D85AE8C45A1BB84890DC4BFFB8A7C49@MXMBON05.grupa.onet>
 <5045CB80.50508@widodh.nl> <alpine.DEB.2.00.1209040832550.13403@cobra.newdream.net>
 <CAMwB3Tj-9UOG+ax_BtuizUjr-NdCdG5RVRmhr7ntdr6-Cmtdrg@mail.gmail.com>
 <alpine.DEB.2.00.1209050852250.8916@cobra.newdream.net> <58915F57-D1DA-4BBE-A205-A5063DDCD789@grupaonet.pl>
 <alpine.DEB.2.00.1209141211010.18057@cobra.newdream.net> <alpine.DEB.2.00.1209181417290.23570@cobra.newdream.net>
 <2A2CF63C-FE66-4DEA-BE50-08E448286FB4@grupaonet.pl> <CAOLwVUkShQXC+mntj1Q8yqUhmoLA6y+yBTVzsJLOi9rivwCGuA@mail.gmail.com>
 <272991F0-2842-4B27-BB5B-194A2EA8F5D5@widodh.nl> <CAOLwVUkpd1vPVur+4VWHiADSirhTxvEGCjaV+J5ZQE108TghPQ@mail.gmail.com>
 <CAC-hyiEDqbRe_yzyOkZkssgrzxQgZXjXtMaOaCBsFBTiTZFdNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:36943 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754341Ab2JUTdi convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 21 Oct 2012 15:33:38 -0400
Received: by mail-la0-f46.google.com with SMTP id h6so1203306lag.19
        for <ceph-devel@vger.kernel.org>; Sun, 21 Oct 2012 12:33:37 -0700 (PDT)
In-Reply-To: <CAC-hyiEDqbRe_yzyOkZkssgrzxQgZXjXtMaOaCBsFBTiTZFdNA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: Wido den Hollander <wido@widodh.nl>, =?ISO-8859-2?Q?Skowron_S=B3awomir?= <slawomir.skowron@grupaonet.pl>, Sage Weil <sage@inktank.com>, =?ISO-8859-2?Q?S=B3awomir_Skowron?= <szibis@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Thanks guys ;)


On Sun, Oct 21, 2012 at 8:51 PM, Yehuda Sadeh <yehuda@inktank.com> wrot=
e:
> ceph osd tell \* injectargs ..
>
> On Sun, Oct 21, 2012 at 10:42 AM, S=C3=A9bastien Han <han.sebastien@g=
mail.com> wrote:
>>
>> > You need to replace 0 with the OSD you want to 'tell' this to.
>> Yes I know...  Btw why should I want to tell something to a specific
>> OSD and not all of them? In this context, I want to apply the change=
s
>> on every OSDs.
>>
>> > So you have to repeat this for each OSD.
>> That's what I was looking for :)
>>
>> Dank u!
>>
>> On Sun, Oct 21, 2012 at 7:28 PM, Wido den Hollander <wido@widodh.nl>=
 wrote:
>> >
>> >
>> >
>> >
>> > Op 21 okt. 2012 om 19:14 heeft S=C3=A9bastien Han <han.sebastien@g=
mail.com> het volgende geschreven:
>> >
>> >> "ceph osd tell 0 injectargs" doesn't seem to propagate the change=
s
>> >> across all the OSDs. Does this command need to be repeated N time=
s?
>> >> (where N is our number of OSD)
>> >
>> > You need to replace 0 with the OSD you want to 'tell' this to.
>> >
>> > So you have to repeat this for each OSD.
>> >
>> > Wido
>> >
>> >
>> >> Thanks in advance!
>> >>
>> >> On Wed, Sep 19, 2012 at 7:00 AM, Skowron S=C5=82awomir
>> >> <slawomir.skowron@grupaonet.pl> wrote:
>> >>> Ok, thanks, i try this on INT, but on production, i will stay wi=
th stable release, and wait for merge in next stable.
>> >>>
>> >>> Regards
>> >>>
>> >>> Slawomir Skowron
>> >>>
>> >>> Dnia 18 wrz 2012 o godz. 23:18 "Sage Weil" <sage@inktank.com> na=
pisa=C5=82(a):
>> >>>
>> >>>> On Fri, 14 Sep 2012, Sage Weil wrote:
>> >>>>> Hi,
>> >>>>>
>> >>>>> <On Wed, 5 Sep 2012, Skowron S?awomir wrote:
>> >>>>>> Dnia 5 wrz 2012 o godz. 17:53 "Sage Weil" <sage@inktank.com> =
napisa?(a):
>> >>>>>>
>> >>>>>>> On Wed, 5 Sep 2012, S?awomir Skowron wrote:
>> >>>>>>>> Ok, but in global case, when i use, a chef/puppet or any ot=
her, i wish
>> >>>>>>>> to change configuration in ceph.conf, and reload daemon to =
get new
>> >>>>>>>> configuration changes from ceph.conf, this feature would be=
 very
>> >>>>>>>> helpful in ceph administration.
>> >>>>>>>>
>> >>>>>>>> Inject is ok, for testing, or debuging.
>> >>>>>>>
>> >>>>>>> Opened http://tracker.newdream.net/issues/3086.  There is al=
ready an issue
>> >>>>>>> open for reloading the config file,
>> >>>>>>> http://tracker.newdream.net/issues/2459.
>> >>>>>>
>> >>>>>> Thanks. This is what i mean.
>> >>>>>> Is this feature have a chance, to be implemented in next mont=
hs ??
>> >>>>>
>> >>>>> I pushed a branch, wip-tp, that implements this.  Want to give=
 it a spin?
>> >>>>> Just inject the config option change (via the admin socket or =
injectargs)
>> >>>>> and it'll resize the thread pool.
>> >>>>
>> >>>> This is merged into master and will be in v0.53.
>> >>>>
>> >>>> sage
>> >>>>
>> >>>>>
>> >>>>> sage
>> >>>>>
>> >>>>>>
>> >>>>>>> sage
>> >>>>>>>
>> >>>>>>>>
>> >>>>>>>> On Tue, Sep 4, 2012 at 5:34 PM, Sage Weil <sage@inktank.com=
> wrote:
>> >>>>>>>>> On Tue, 4 Sep 2012, Wido den Hollander wrote:
>> >>>>>>>>>> On 09/04/2012 10:30 AM, Skowron S?awomir wrote:
>> >>>>>>>>>>> Ok, thanks.
>> >>>>>>>>>>>
>> >>>>>>>>>>> Number of workers used for recover, or numer of disk thr=
eads.
>> >>>>>>>>>>
>> >>>>>>>>>> I think those can be changed while the OSD is running. Yo=
u could always give
>> >>>>>>>>>> it a try.
>> >>>>>>>>>
>> >>>>>>>>> The thread pool sizes can't currently be adjusted, unfortu=
nately.  It
>> >>>>>>>>> wouldn't be too difficult to change that...
>> >>>>>>>>>
>> >>>>>>>>> sage
>> >>>>>>>>>
>> >>>>>>>>>>
>> >>>>>>>>>> Wido
>> >>>>>>>>>>
>> >>>>>>>>>>> -----Original Message-----
>> >>>>>>>>>>> From: Wido den Hollander [mailto:wido@widodh.nl]
>> >>>>>>>>>>> Sent: Tuesday, September 04, 2012 10:18 AM
>> >>>>>>>>>>> To: Skowron S?awomir
>> >>>>>>>>>>> Cc: ceph-devel@vger.kernel.org
>> >>>>>>>>>>> Subject: Re: Inject configuration change into cluster
>> >>>>>>>>>>>
>> >>>>>>>>>>> On 09/04/2012 07:04 AM, Skowron S?awomir wrote:
>> >>>>>>>>>>>> Is there any way now, to inject new configuration chang=
e, without
>> >>>>>>>>>>>> restarting daemons ??
>> >>>>>>>>>>>
>> >>>>>>>>>>> Yes, you can use the injectargs command.
>> >>>>>>>>>>>
>> >>>>>>>>>>> $ ceph osd tell 0 injectargs '--debug-osd 20'
>> >>>>>>>>>>>
>> >>>>>>>>>>> What do you want to change? Not everything can be change=
d while the OSD is
>> >>>>>>>>>>> running.
>> >>>>>>>>>>>
>> >>>>>>>>>>> Wido
>> >>>>>>>>>>>
>> >>>>>>>>>>>> Regards
>> >>>>>>>>>>>>
>> >>>>>>>>>>>> Slawomir Skowron--
>> >>>>>>>>>>>> To unsubscribe from this list: send the line "unsubscri=
be ceph-devel"
>> >>>>>>>>>>>> in the body of a message to majordomo@vger.kernel.org M=
ore majordomo
>> >>>>>>>>>>>> info at  http://vger.kernel.org/majordomo-info.html
>> >>>>>>>>>>>
>> >>>>>>>>>>> N???????????????r??????y?????????b???X???????v???^???)?{=
=2En???+?????????z???]z???{ay??? ?????,j ??????f?????????h?????????z???=
 ???w?????????
>> >>>>>>>>>>> ?????????j:+v?????????w???j???m???????????? ????????????=
zZ+???????j"??????!tml=3D
>> >>>>>>>>>>
>> >>>>>>>>>> --
>> >>>>>>>>>> To unsubscribe from this list: send the line "unsubscribe=
 ceph-devel" in
>> >>>>>>>>>> the body of a message to majordomo@vger.kernel.org
>> >>>>>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-=
info.html
>> >>>>>>>>> --
>> >>>>>>>>> To unsubscribe from this list: send the line "unsubscribe =
ceph-devel" in
>> >>>>>>>>> the body of a message to majordomo@vger.kernel.org
>> >>>>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-i=
nfo.html
>> >>>>>>>>
>> >>>>>>>>
>> >>>>>>>>
>> >>>>>>>> --
>> >>>>>>>> -----
>> >>>>>>>> Pozdrawiam
>> >>>>>>>>
>> >>>>>>>> S?awek "sZiBis" Skowron
>> >>>>> --
>> >>>>> To unsubscribe from this list: send the line "unsubscribe ceph=
-devel" in
>> >>>>> the body of a message to majordomo@vger.kernel.org
>> >>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.=
html
>> >>>>>
>> >>>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
