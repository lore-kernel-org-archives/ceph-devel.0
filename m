From: Gregory Farnum <greg@inktank.com>
Subject: Re: ceph status reporting non-existing osd
Date: Wed, 18 Jul 2012 00:18:43 -0700
Message-ID: <9D6CE6A067E543BFBDDD0A29BB2E34F9@inktank.com>
References: <4FFFD9AB.40608@xdel.ru>
 <CAPYLRzgOHf9nMdK5oOrs6++H22iFLYvcbhMQsZtd8Z3OskX=yw@mail.gmail.com>
 <alpine.DEB.2.00.1207131009280.9771@cobra.newdream.net>
 <CABYiri9wEoPs87qUr2MANX_AHB-aHprJBdXV0o4TxeDPj6SrhQ@mail.gmail.com>
 <823856EB9E9B4D1EBB352F93465B742A@inktank.com>
 <CABYiri-D4qPv1nQ4KHkwDS6wrH9gZdSu=b6ePxk61Ks-qx+Ajg@mail.gmail.com>
 <C286CA87975941CD913337EAC9844935@inktank.com>
 <CABYiri9RAYrVaqePQq00J-KK32_Y_pf1c0jHxhJD2ZVBRrxOhA@mail.gmail.com>
 <45F07A6460B34ED5A9C589696933A936@inktank.com>
 <CABYiri_sCkq=7-NFgP6ohT=yZxFJboqgC5es_xDb+ijUZ5hrYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:43381 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752078Ab2GRHSr convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Jul 2012 03:18:47 -0400
Received: by pbbrp8 with SMTP id rp8so2153875pbb.19
        for <ceph-devel@vger.kernel.org>; Wed, 18 Jul 2012 00:18:46 -0700 (PDT)
In-Reply-To: <CABYiri_sCkq=7-NFgP6ohT=yZxFJboqgC5es_xDb+ijUZ5hrYg@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Korolyov <andrey@xdel.ru>
Cc: Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org

On Tuesday, July 17, 2012 at 11:22 PM, Andrey Korolyov wrote:
> On Wed, Jul 18, 2012 at 10:09 AM, Gregory Farnum <greg@inktank.com (m=
ailto:greg@inktank.com)> wrote:
> > On Monday, July 16, 2012 at 11:55 AM, Andrey Korolyov wrote:
> > > On Mon, Jul 16, 2012 at 10:48 PM, Gregory Farnum <greg@inktank.co=
m (mailto:greg@inktank.com)> wrote:
> > > > "ceph pg set_full_ratio 0.95"
> > > > "ceph pg set_nearfull_ratio 0.94"
> > > > =20
> > > > =20
> > > > On Monday, July 16, 2012 at 11:42 AM, Andrey Korolyov wrote:
> > > > =20
> > > > > On Mon, Jul 16, 2012 at 8:12 PM, Gregory Farnum <greg@inktank=
=2Ecom (mailto:greg@inktank.com)> wrote:
> > > > > > On Saturday, July 14, 2012 at 7:20 AM, Andrey Korolyov wrot=
e:
> > > > > > > On Fri, Jul 13, 2012 at 9:09 PM, Sage Weil <sage@inktank.=
com (mailto:sage@inktank.com)> wrote:
> > > > > > > > On Fri, 13 Jul 2012, Gregory Farnum wrote:
> > > > > > > > > On Fri, Jul 13, 2012 at 1:17 AM, Andrey Korolyov <and=
rey@xdel.ru (mailto:andrey@xdel.ru)> wrote:
> > > > > > > > > > Hi,
> > > > > > > > > > =20
> > > > > > > > > > Recently I`ve reduced my test suite from 6 to 4 osd=
s at ~60% usage on
> > > > > > > > > > six-node,
> > > > > > > > > > and I have removed a bunch of rbd objects during re=
covery to avoid
> > > > > > > > > > overfill.
> > > > > > > > > > Right now I`m constantly receiving a warn about nea=
rfull state on
> > > > > > > > > > non-existing osd:
> > > > > > > > > > =20
> > > > > > > > > > health HEALTH_WARN 1 near full osd(s)
> > > > > > > > > > monmap e3: 3 mons at
> > > > > > > > > > {0=3D192.168.10.129:6789/0,1=3D192.168.10.128:6789/=
0,2=3D192.168.10.127:6789/0},
> > > > > > > > > > election epoch 240, quorum 0,1,2 0,1,2
> > > > > > > > > > osdmap e2098: 4 osds: 4 up, 4 in
> > > > > > > > > > pgmap v518696: 464 pgs: 464 active+clean; 61070 MB =
data, 181 GB
> > > > > > > > > > used, 143 GB / 324 GB avail
> > > > > > > > > > mdsmap e181: 1/1/1 up {0=3Da=3Dup:active}
> > > > > > > > > > =20
> > > > > > > > > > HEALTH_WARN 1 near full osd(s)
> > > > > > > > > > osd.4 is near full at 89%
> > > > > > > > > > =20
> > > > > > > > > > Needless to say, osd.4 remains only in ceph.conf, b=
ut not at crushmap.
> > > > > > > > > > Reducing has been done 'on-line', e.g. without rest=
art entire cluster.
> > > > > > > > > =20
> > > > > > > > > =20
> > > > > > > > > =20
> > > > > > > > > =20
> > > > > > > > > =20
> > > > > > > > > =20
> > > > > > > > > =20
> > > > > > > > > =20
> > > > > > > > > =20
> > > > > > > > > Whoops! It looks like Sage has written some patches t=
o fix this, but
> > > > > > > > > for now you should be good if you just update your ra=
tios to a larger
> > > > > > > > > number, and then bring them back down again. :)
> > > > > > > > =20
> > > > > > > > =20
> > > > > > > > =20
> > > > > > > > =20
> > > > > > > > =20
> > > > > > > > =20
> > > > > > > > =20
> > > > > > > > =20
> > > > > > > > =20
> > > > > > > > Restarting ceph-mon should also do the trick.
> > > > > > > > =20
> > > > > > > > Thanks for the bug report!
> > > > > > > > sage
> > > > > > > =20
> > > > > > > =20
> > > > > > > =20
> > > > > > > =20
> > > > > > > =20
> > > > > > > =20
> > > > > > > =20
> > > > > > > =20
> > > > > > > =20
> > > > > > > Should I restart mons simultaneously?
> > > > > > I don't think restarting will actually do the trick for you=
 =E2=80=94 you actually will need to set the ratios again.
> > > > > > =20
> > > > > > > Restarting one by one has no
> > > > > > > effect, same as filling up data pool up to ~95 percent(bt=
w, when I
> > > > > > > deleted this 50Gb file on cephfs, mds was stuck permanent=
ly and usage
> > > > > > > remained same until I dropped and recreated data pool - h=
ope it`s one
> > > > > > > of known posix layer bugs). I also deleted entry from con=
fig, and then
> > > > > > > restarted mons, with no effect. Any suggestions?
> > > > > > =20
> > > > > > =20
> > > > > > =20
> > > > > > =20
> > > > > > =20
> > > > > > =20
> > > > > > =20
> > > > > > I'm not sure what you're asking about here?
> > > > > > -Greg
> > > > > =20
> > > > > =20
> > > > > =20
> > > > > =20
> > > > > =20
> > > > > =20
> > > > > =20
> > > > > Oh, sorry, I have mislooked and thought that you suggested fi=
lling up
> > > > > osds. How do I can set full/nearfull ratios correctly?
> > > > > =20
> > > > > $ceph injectargs '--mon_osd_full_ratio 96'
> > > > > parsed options
> > > > > $ ceph injectargs '--mon_osd_near_full_ratio 94'
> > > > > parsed options
> > > > > =20
> > > > > ceph pg dump | grep 'full'
> > > > > full_ratio 0.95
> > > > > nearfull_ratio 0.85
> > > > > =20
> > > > > Setting parameters in the ceph.conf and then restarting mons =
does not
> > > > > affect ratios either.
> > > > =20
> > > =20
> > > =20
> > > =20
> > > =20
> > > =20
> > > Thanks, it worked, but setting values back result to turn warning=
 back.
> > Hrm. That shouldn't be possible if the OSD has been removed. How di=
d you take it out? It sounds like maybe you just marked it in the OUT s=
tate (and turned it off quite quickly) without actually taking it out o=
f the cluster?
> > -Greg
> =20
> =20
> =20
> As I have did removal, it was definitely not like that - at first
> place, I have marked osds(4 and 5 on same host) out, then rebuilt
> crushmap and then kill osd processes. As I mentioned before, osd.4
> doest not exist in crushmap and therefore it shouldn`t be reported at
> all(theoretically).

Okay, that's what happened =E2=80=94 marking an OSD out in the CRUSH ma=
p means all the data gets moved off it, but that doesn't remove it from=
 all the places where it's registered in the monitor and in the map, fo=
r a couple reasons: =20
1) You might want to mark an OSD out before taking it down, to allow fo=
r more orderly data movement.
2) OSDs can get marked out automatically, but the system shouldn't be a=
ble to forget about them on its own.
3) You might want to remove an OSD from the CRUSH map in the process of=
 placing it somewhere else (perhaps you moved the physical machine to a=
 new location).
etc.

You want to run "ceph osd rm 4 5" and that should unregister both of th=
em from everything[1]. :)
-Greg
[1]: Except for the full lists, which have a bug in the version of code=
 you're running =E2=80=94 remove the OSDs, then adjust the full ratios =
again, and all will be well.

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
