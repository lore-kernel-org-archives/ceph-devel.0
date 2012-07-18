From: Andrey Korolyov <andrey@xdel.ru>
Subject: Re: ceph status reporting non-existing osd
Date: Wed, 18 Jul 2012 11:47:35 +0400
Message-ID: <CABYiri9neTby8heHcw9PsZG0tGgX4nJYrCQiBmE-rKX0X8W3LA@mail.gmail.com>
References: <4FFFD9AB.40608@xdel.ru> <CAPYLRzgOHf9nMdK5oOrs6++H22iFLYvcbhMQsZtd8Z3OskX=yw@mail.gmail.com>
 <alpine.DEB.2.00.1207131009280.9771@cobra.newdream.net> <CABYiri9wEoPs87qUr2MANX_AHB-aHprJBdXV0o4TxeDPj6SrhQ@mail.gmail.com>
 <823856EB9E9B4D1EBB352F93465B742A@inktank.com> <CABYiri-D4qPv1nQ4KHkwDS6wrH9gZdSu=b6ePxk61Ks-qx+Ajg@mail.gmail.com>
 <C286CA87975941CD913337EAC9844935@inktank.com> <CABYiri9RAYrVaqePQq00J-KK32_Y_pf1c0jHxhJD2ZVBRrxOhA@mail.gmail.com>
 <45F07A6460B34ED5A9C589696933A936@inktank.com> <CABYiri_sCkq=7-NFgP6ohT=yZxFJboqgC5es_xDb+ijUZ5hrYg@mail.gmail.com>
 <9D6CE6A067E543BFBDDD0A29BB2E34F9@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:42457 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752023Ab2GRHr5 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Jul 2012 03:47:57 -0400
Received: by wibhm11 with SMTP id hm11so4483098wib.1
        for <ceph-devel@vger.kernel.org>; Wed, 18 Jul 2012 00:47:56 -0700 (PDT)
In-Reply-To: <9D6CE6A067E543BFBDDD0A29BB2E34F9@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org

On Wed, Jul 18, 2012 at 11:18 AM, Gregory Farnum <greg@inktank.com> wro=
te:
> On Tuesday, July 17, 2012 at 11:22 PM, Andrey Korolyov wrote:
>> On Wed, Jul 18, 2012 at 10:09 AM, Gregory Farnum <greg@inktank.com (=
mailto:greg@inktank.com)> wrote:
>> > On Monday, July 16, 2012 at 11:55 AM, Andrey Korolyov wrote:
>> > > On Mon, Jul 16, 2012 at 10:48 PM, Gregory Farnum <greg@inktank.c=
om (mailto:greg@inktank.com)> wrote:
>> > > > "ceph pg set_full_ratio 0.95"
>> > > > "ceph pg set_nearfull_ratio 0.94"
>> > > >
>> > > >
>> > > > On Monday, July 16, 2012 at 11:42 AM, Andrey Korolyov wrote:
>> > > >
>> > > > > On Mon, Jul 16, 2012 at 8:12 PM, Gregory Farnum <greg@inktan=
k.com (mailto:greg@inktank.com)> wrote:
>> > > > > > On Saturday, July 14, 2012 at 7:20 AM, Andrey Korolyov wro=
te:
>> > > > > > > On Fri, Jul 13, 2012 at 9:09 PM, Sage Weil <sage@inktank=
=2Ecom (mailto:sage@inktank.com)> wrote:
>> > > > > > > > On Fri, 13 Jul 2012, Gregory Farnum wrote:
>> > > > > > > > > On Fri, Jul 13, 2012 at 1:17 AM, Andrey Korolyov <an=
drey@xdel.ru (mailto:andrey@xdel.ru)> wrote:
>> > > > > > > > > > Hi,
>> > > > > > > > > >
>> > > > > > > > > > Recently I`ve reduced my test suite from 6 to 4 os=
ds at ~60% usage on
>> > > > > > > > > > six-node,
>> > > > > > > > > > and I have removed a bunch of rbd objects during r=
ecovery to avoid
>> > > > > > > > > > overfill.
>> > > > > > > > > > Right now I`m constantly receiving a warn about ne=
arfull state on
>> > > > > > > > > > non-existing osd:
>> > > > > > > > > >
>> > > > > > > > > > health HEALTH_WARN 1 near full osd(s)
>> > > > > > > > > > monmap e3: 3 mons at
>> > > > > > > > > > {0=3D192.168.10.129:6789/0,1=3D192.168.10.128:6789=
/0,2=3D192.168.10.127:6789/0},
>> > > > > > > > > > election epoch 240, quorum 0,1,2 0,1,2
>> > > > > > > > > > osdmap e2098: 4 osds: 4 up, 4 in
>> > > > > > > > > > pgmap v518696: 464 pgs: 464 active+clean; 61070 MB=
 data, 181 GB
>> > > > > > > > > > used, 143 GB / 324 GB avail
>> > > > > > > > > > mdsmap e181: 1/1/1 up {0=3Da=3Dup:active}
>> > > > > > > > > >
>> > > > > > > > > > HEALTH_WARN 1 near full osd(s)
>> > > > > > > > > > osd.4 is near full at 89%
>> > > > > > > > > >
>> > > > > > > > > > Needless to say, osd.4 remains only in ceph.conf, =
but not at crushmap.
>> > > > > > > > > > Reducing has been done 'on-line', e.g. without res=
tart entire cluster.
>> > > > > > > > >
>> > > > > > > > >
>> > > > > > > > >
>> > > > > > > > >
>> > > > > > > > >
>> > > > > > > > >
>> > > > > > > > >
>> > > > > > > > >
>> > > > > > > > >
>> > > > > > > > > Whoops! It looks like Sage has written some patches =
to fix this, but
>> > > > > > > > > for now you should be good if you just update your r=
atios to a larger
>> > > > > > > > > number, and then bring them back down again. :)
>> > > > > > > >
>> > > > > > > >
>> > > > > > > >
>> > > > > > > >
>> > > > > > > >
>> > > > > > > >
>> > > > > > > >
>> > > > > > > >
>> > > > > > > >
>> > > > > > > > Restarting ceph-mon should also do the trick.
>> > > > > > > >
>> > > > > > > > Thanks for the bug report!
>> > > > > > > > sage
>> > > > > > >
>> > > > > > >
>> > > > > > >
>> > > > > > >
>> > > > > > >
>> > > > > > >
>> > > > > > >
>> > > > > > >
>> > > > > > >
>> > > > > > > Should I restart mons simultaneously?
>> > > > > > I don't think restarting will actually do the trick for yo=
u =E2=80=94 you actually will need to set the ratios again.
>> > > > > >
>> > > > > > > Restarting one by one has no
>> > > > > > > effect, same as filling up data pool up to ~95 percent(b=
tw, when I
>> > > > > > > deleted this 50Gb file on cephfs, mds was stuck permanen=
tly and usage
>> > > > > > > remained same until I dropped and recreated data pool - =
hope it`s one
>> > > > > > > of known posix layer bugs). I also deleted entry from co=
nfig, and then
>> > > > > > > restarted mons, with no effect. Any suggestions?
>> > > > > >
>> > > > > >
>> > > > > >
>> > > > > >
>> > > > > >
>> > > > > >
>> > > > > >
>> > > > > > I'm not sure what you're asking about here?
>> > > > > > -Greg
>> > > > >
>> > > > >
>> > > > >
>> > > > >
>> > > > >
>> > > > >
>> > > > >
>> > > > > Oh, sorry, I have mislooked and thought that you suggested f=
illing up
>> > > > > osds. How do I can set full/nearfull ratios correctly?
>> > > > >
>> > > > > $ceph injectargs '--mon_osd_full_ratio 96'
>> > > > > parsed options
>> > > > > $ ceph injectargs '--mon_osd_near_full_ratio 94'
>> > > > > parsed options
>> > > > >
>> > > > > ceph pg dump | grep 'full'
>> > > > > full_ratio 0.95
>> > > > > nearfull_ratio 0.85
>> > > > >
>> > > > > Setting parameters in the ceph.conf and then restarting mons=
 does not
>> > > > > affect ratios either.
>> > > >
>> > >
>> > >
>> > >
>> > >
>> > >
>> > > Thanks, it worked, but setting values back result to turn warnin=
g back.
>> > Hrm. That shouldn't be possible if the OSD has been removed. How d=
id you take it out? It sounds like maybe you just marked it in the OUT =
state (and turned it off quite quickly) without actually taking it out =
of the cluster?
>> > -Greg
>>
>>
>>
>> As I have did removal, it was definitely not like that - at first
>> place, I have marked osds(4 and 5 on same host) out, then rebuilt
>> crushmap and then kill osd processes. As I mentioned before, osd.4
>> doest not exist in crushmap and therefore it shouldn`t be reported a=
t
>> all(theoretically).
>
> Okay, that's what happened =E2=80=94 marking an OSD out in the CRUSH =
map means all the data gets moved off it, but that doesn't remove it fr=
om all the places where it's registered in the monitor and in the map, =
for a couple reasons:
> 1) You might want to mark an OSD out before taking it down, to allow =
for more orderly data movement.
> 2) OSDs can get marked out automatically, but the system shouldn't be=
 able to forget about them on its own.
> 3) You might want to remove an OSD from the CRUSH map in the process =
of placing it somewhere else (perhaps you moved the physical machine to=
 a new location).
> etc.
>
> You want to run "ceph osd rm 4 5" and that should unregister both of =
them from everything[1]. :)
> -Greg
> [1]: Except for the full lists, which have a bug in the version of co=
de you're running =E2=80=94 remove the OSDs, then adjust the full ratio=
s again, and all will be well.
>

$ ceph osd rm 4
osd.4 does not exist
$ ceph -s
   health HEALTH_WARN 1 near full osd(s)
   monmap e3: 3 mons at
{0=3D192.168.10.129:6789/0,1=3D192.168.10.128:6789/0,2=3D192.168.10.127=
:6789/0},
election epoch 58, quorum 0,1,2 0,1,2
   osdmap e2198: 4 osds: 4 up, 4 in
    pgmap v586056: 464 pgs: 464 active+clean; 66645 MB data, 231 GB
used, 95877 MB / 324 GB avail
   mdsmap e207: 1/1/1 up {0=3Da=3Dup:active}

$ ceph health detail
HEALTH_WARN 1 near full osd(s)
osd.4 is near full at 89%

$ ceph osd dump
=2E...
max_osd 4
osd.0 up   in  weight 1 up_from 2183 up_thru 2187 down_at 2172
last_clean_interval [2136,2171) 192.168.10.128:6800/4030
192.168.10.128:6801/4030 192.168.10.128:6802/4030 exists,up
68b3deec-e80a-48b7-9c29-1b98f5de4f62
osd.1 up   in  weight 1 up_from 2136 up_thru 2186 down_at 2135
last_clean_interval [2115,2134) 192.168.10.129:6800/2980
192.168.10.129:6801/2980 192.168.10.129:6802/2980 exists,up
b2a26fe9-aaa8-445f-be1f-fa7d2a283b57
osd.2 up   in  weight 1 up_from 2181 up_thru 2187 down_at 2172
last_clean_interval [2136,2171) 192.168.10.128:6803/4128
192.168.10.128:6804/4128 192.168.10.128:6805/4128 exists,up
378d367a-f7fb-4892-9ec9-db8ffdd2eb20
osd.3 up   in  weight 1 up_from 2136 up_thru 2186 down_at 2135
last_clean_interval [2115,2134) 192.168.10.129:6803/3069
192.168.10.129:6804/3069 192.168.10.129:6805/3069 exists,up
faf8eda8-55fc-4a0e-899f-47dbd32b81b8
=2E...
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
