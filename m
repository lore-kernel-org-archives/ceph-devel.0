From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Inject configuration change into cluster
Date: Sun, 21 Oct 2012 19:28:38 +0200
Message-ID: <272991F0-2842-4B27-BB5B-194A2EA8F5D5@widodh.nl>
References: <1FC69721-C852-4B56-ACE6-073137C5290D@portal.onet.pl> <5045B928.1050706@widodh.nl> <1BF27E0D85AE8C45A1BB84890DC4BFFB8A7C49@MXMBON05.grupa.onet> <5045CB80.50508@widodh.nl> <alpine.DEB.2.00.1209040832550.13403@cobra.newdream.net> <CAMwB3Tj-9UOG+ax_BtuizUjr-NdCdG5RVRmhr7ntdr6-Cmtdrg@mail.gmail.com> <alpine.DEB.2.00.1209050852250.8916@cobra.newdream.net> <58915F57-D1DA-4BBE-A205-A5063DDCD789@grupaonet.pl> <alpine.DEB.2.00.1209141211010.18057@cobra.newdream.net> <alpine.DEB.2.00.1209181417290.23570@cobra.newdream.net> <2A2CF63C-FE66-4DEA-BE50-08E448286FB4@grupaonet.pl> <CAOLwVUkShQXC+mntj1Q8yqUhmoLA6y+yBTVzsJLOi9rivwCGuA@mail.gmail.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:39974 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932329Ab2JUR2l convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 21 Oct 2012 13:28:41 -0400
In-Reply-To: <CAOLwVUkShQXC+mntj1Q8yqUhmoLA6y+yBTVzsJLOi9rivwCGuA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?utf-8?Q?S=C3=A9bastien_Han?= <han.sebastien@gmail.com>
Cc: =?utf-8?Q?Skowron_S=C5=82awomir?= <slawomir.skowron@grupaonet.pl>, Sage Weil <sage@inktank.com>, =?utf-8?Q?S=C5=82awomir_Skowron?= <szibis@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>





Op 21 okt. 2012 om 19:14 heeft S=C3=A9bastien Han <han.sebastien@gmail.=
com> het volgende geschreven:

> "ceph osd tell 0 injectargs" doesn't seem to propagate the changes
> across all the OSDs. Does this command need to be repeated N times?
> (where N is our number of OSD)

You need to replace 0 with the OSD you want to 'tell' this to.

So you have to repeat this for each OSD.

Wido


> Thanks in advance!
>=20
> On Wed, Sep 19, 2012 at 7:00 AM, Skowron S=C5=82awomir
> <slawomir.skowron@grupaonet.pl> wrote:
>> Ok, thanks, i try this on INT, but on production, i will stay with s=
table release, and wait for merge in next stable.
>>=20
>> Regards
>>=20
>> Slawomir Skowron
>>=20
>> Dnia 18 wrz 2012 o godz. 23:18 "Sage Weil" <sage@inktank.com> napisa=
=C5=82(a):
>>=20
>>> On Fri, 14 Sep 2012, Sage Weil wrote:
>>>> Hi,
>>>>=20
>>>> <On Wed, 5 Sep 2012, Skowron S?awomir wrote:
>>>>> Dnia 5 wrz 2012 o godz. 17:53 "Sage Weil" <sage@inktank.com> napi=
sa?(a):
>>>>>=20
>>>>>> On Wed, 5 Sep 2012, S?awomir Skowron wrote:
>>>>>>> Ok, but in global case, when i use, a chef/puppet or any other,=
 i wish
>>>>>>> to change configuration in ceph.conf, and reload daemon to get =
new
>>>>>>> configuration changes from ceph.conf, this feature would be ver=
y
>>>>>>> helpful in ceph administration.
>>>>>>>=20
>>>>>>> Inject is ok, for testing, or debuging.
>>>>>>=20
>>>>>> Opened http://tracker.newdream.net/issues/3086.  There is alread=
y an issue
>>>>>> open for reloading the config file,
>>>>>> http://tracker.newdream.net/issues/2459.
>>>>>=20
>>>>> Thanks. This is what i mean.
>>>>> Is this feature have a chance, to be implemented in next months ?=
?
>>>>=20
>>>> I pushed a branch, wip-tp, that implements this.  Want to give it =
a spin?
>>>> Just inject the config option change (via the admin socket or inje=
ctargs)
>>>> and it'll resize the thread pool.
>>>=20
>>> This is merged into master and will be in v0.53.
>>>=20
>>> sage
>>>=20
>>>>=20
>>>> sage
>>>>=20
>>>>>=20
>>>>>> sage
>>>>>>=20
>>>>>>>=20
>>>>>>> On Tue, Sep 4, 2012 at 5:34 PM, Sage Weil <sage@inktank.com> wr=
ote:
>>>>>>>> On Tue, 4 Sep 2012, Wido den Hollander wrote:
>>>>>>>>> On 09/04/2012 10:30 AM, Skowron S?awomir wrote:
>>>>>>>>>> Ok, thanks.
>>>>>>>>>>=20
>>>>>>>>>> Number of workers used for recover, or numer of disk threads=
=2E
>>>>>>>>>=20
>>>>>>>>> I think those can be changed while the OSD is running. You co=
uld always give
>>>>>>>>> it a try.
>>>>>>>>=20
>>>>>>>> The thread pool sizes can't currently be adjusted, unfortunate=
ly.  It
>>>>>>>> wouldn't be too difficult to change that...
>>>>>>>>=20
>>>>>>>> sage
>>>>>>>>=20
>>>>>>>>>=20
>>>>>>>>> Wido
>>>>>>>>>=20
>>>>>>>>>> -----Original Message-----
>>>>>>>>>> From: Wido den Hollander [mailto:wido@widodh.nl]
>>>>>>>>>> Sent: Tuesday, September 04, 2012 10:18 AM
>>>>>>>>>> To: Skowron S?awomir
>>>>>>>>>> Cc: ceph-devel@vger.kernel.org
>>>>>>>>>> Subject: Re: Inject configuration change into cluster
>>>>>>>>>>=20
>>>>>>>>>> On 09/04/2012 07:04 AM, Skowron S?awomir wrote:
>>>>>>>>>>> Is there any way now, to inject new configuration change, w=
ithout
>>>>>>>>>>> restarting daemons ??
>>>>>>>>>>=20
>>>>>>>>>> Yes, you can use the injectargs command.
>>>>>>>>>>=20
>>>>>>>>>> $ ceph osd tell 0 injectargs '--debug-osd 20'
>>>>>>>>>>=20
>>>>>>>>>> What do you want to change? Not everything can be changed wh=
ile the OSD is
>>>>>>>>>> running.
>>>>>>>>>>=20
>>>>>>>>>> Wido
>>>>>>>>>>=20
>>>>>>>>>>> Regards
>>>>>>>>>>>=20
>>>>>>>>>>> Slawomir Skowron--
>>>>>>>>>>> To unsubscribe from this list: send the line "unsubscribe c=
eph-devel"
>>>>>>>>>>> in the body of a message to majordomo@vger.kernel.org More =
majordomo
>>>>>>>>>>> info at  http://vger.kernel.org/majordomo-info.html
>>>>>>>>>>=20
>>>>>>>>>> N???????????????r??????y?????????b???X???????v???^???)?{.n??=
?+?????????z???]z???{ay??? ?????,j ??????f?????????h?????????z??? ???w?=
????????
>>>>>>>>>> ?????????j:+v?????????w???j???m???????????? ????????????zZ+?=
??????j"??????!tml=3D
>>>>>>>>>=20
>>>>>>>>> --
>>>>>>>>> To unsubscribe from this list: send the line "unsubscribe cep=
h-devel" in
>>>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info=
=2Ehtml
>>>>>>>> --
>>>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph=
-devel" in
>>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.=
html
>>>>>>>=20
>>>>>>>=20
>>>>>>>=20
>>>>>>> --
>>>>>>> -----
>>>>>>> Pozdrawiam
>>>>>>>=20
>>>>>>> S?awek "sZiBis" Skowron
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>=20
>>>>=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
