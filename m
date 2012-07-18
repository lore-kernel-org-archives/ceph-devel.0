From: Gregory Farnum <greg@inktank.com>
Subject: Re: ceph status reporting non-existing osd
Date: Tue, 17 Jul 2012 23:09:04 -0700
Message-ID: <45F07A6460B34ED5A9C589696933A936@inktank.com>
References: <4FFFD9AB.40608@xdel.ru>
 <CAPYLRzgOHf9nMdK5oOrs6++H22iFLYvcbhMQsZtd8Z3OskX=yw@mail.gmail.com>
 <alpine.DEB.2.00.1207131009280.9771@cobra.newdream.net>
 <CABYiri9wEoPs87qUr2MANX_AHB-aHprJBdXV0o4TxeDPj6SrhQ@mail.gmail.com>
 <823856EB9E9B4D1EBB352F93465B742A@inktank.com>
 <CABYiri-D4qPv1nQ4KHkwDS6wrH9gZdSu=b6ePxk61Ks-qx+Ajg@mail.gmail.com>
 <C286CA87975941CD913337EAC9844935@inktank.com>
 <CABYiri9RAYrVaqePQq00J-KK32_Y_pf1c0jHxhJD2ZVBRrxOhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:56026 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751675Ab2GRGJI convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Jul 2012 02:09:08 -0400
Received: by pbbrp8 with SMTP id rp8so2063723pbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 17 Jul 2012 23:09:08 -0700 (PDT)
In-Reply-To: <CABYiri9RAYrVaqePQq00J-KK32_Y_pf1c0jHxhJD2ZVBRrxOhA@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Korolyov <andrey@xdel.ru>
Cc: Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org

On Monday, July 16, 2012 at 11:55 AM, Andrey Korolyov wrote:
> On Mon, Jul 16, 2012 at 10:48 PM, Gregory Farnum <greg@inktank.com (m=
ailto:greg@inktank.com)> wrote:
> > "ceph pg set_full_ratio 0.95"
> > "ceph pg set_nearfull_ratio 0.94"
> > =20
> > =20
> > On Monday, July 16, 2012 at 11:42 AM, Andrey Korolyov wrote:
> > =20
> > > On Mon, Jul 16, 2012 at 8:12 PM, Gregory Farnum <greg@inktank.com=
 (mailto:greg@inktank.com)> wrote:
> > > > On Saturday, July 14, 2012 at 7:20 AM, Andrey Korolyov wrote:
> > > > > On Fri, Jul 13, 2012 at 9:09 PM, Sage Weil <sage@inktank.com =
(mailto:sage@inktank.com)> wrote:
> > > > > > On Fri, 13 Jul 2012, Gregory Farnum wrote:
> > > > > > > On Fri, Jul 13, 2012 at 1:17 AM, Andrey Korolyov <andrey@=
xdel.ru (mailto:andrey@xdel.ru)> wrote:
> > > > > > > > Hi,
> > > > > > > > =20
> > > > > > > > Recently I`ve reduced my test suite from 6 to 4 osds at=
 ~60% usage on
> > > > > > > > six-node,
> > > > > > > > and I have removed a bunch of rbd objects during recove=
ry to avoid
> > > > > > > > overfill.
> > > > > > > > Right now I`m constantly receiving a warn about nearful=
l state on
> > > > > > > > non-existing osd:
> > > > > > > > =20
> > > > > > > > health HEALTH_WARN 1 near full osd(s)
> > > > > > > > monmap e3: 3 mons at
> > > > > > > > {0=3D192.168.10.129:6789/0,1=3D192.168.10.128:6789/0,2=3D=
192.168.10.127:6789/0},
> > > > > > > > election epoch 240, quorum 0,1,2 0,1,2
> > > > > > > > osdmap e2098: 4 osds: 4 up, 4 in
> > > > > > > > pgmap v518696: 464 pgs: 464 active+clean; 61070 MB data=
, 181 GB
> > > > > > > > used, 143 GB / 324 GB avail
> > > > > > > > mdsmap e181: 1/1/1 up {0=3Da=3Dup:active}
> > > > > > > > =20
> > > > > > > > HEALTH_WARN 1 near full osd(s)
> > > > > > > > osd.4 is near full at 89%
> > > > > > > > =20
> > > > > > > > Needless to say, osd.4 remains only in ceph.conf, but n=
ot at crushmap.
> > > > > > > > Reducing has been done 'on-line', e.g. without restart =
entire cluster.
> > > > > > > =20
> > > > > > > =20
> > > > > > > =20
> > > > > > > =20
> > > > > > > =20
> > > > > > > =20
> > > > > > > =20
> > > > > > > Whoops! It looks like Sage has written some patches to fi=
x this, but
> > > > > > > for now you should be good if you just update your ratios=
 to a larger
> > > > > > > number, and then bring them back down again. :)
> > > > > > =20
> > > > > > =20
> > > > > > =20
> > > > > > =20
> > > > > > =20
> > > > > > =20
> > > > > > =20
> > > > > > Restarting ceph-mon should also do the trick.
> > > > > > =20
> > > > > > Thanks for the bug report!
> > > > > > sage
> > > > > =20
> > > > > =20
> > > > > =20
> > > > > =20
> > > > > =20
> > > > > =20
> > > > > =20
> > > > > Should I restart mons simultaneously?
> > > > I don't think restarting will actually do the trick for you =E2=
=80=94 you actually will need to set the ratios again.
> > > > =20
> > > > > Restarting one by one has no
> > > > > effect, same as filling up data pool up to ~95 percent(btw, w=
hen I
> > > > > deleted this 50Gb file on cephfs, mds was stuck permanently a=
nd usage
> > > > > remained same until I dropped and recreated data pool - hope =
it`s one
> > > > > of known posix layer bugs). I also deleted entry from config,=
 and then
> > > > > restarted mons, with no effect. Any suggestions?
> > > > =20
> > > > =20
> > > > =20
> > > > =20
> > > > =20
> > > > I'm not sure what you're asking about here?
> > > > -Greg
> > > =20
> > > =20
> > > =20
> > > =20
> > > =20
> > > Oh, sorry, I have mislooked and thought that you suggested fillin=
g up
> > > osds. How do I can set full/nearfull ratios correctly?
> > > =20
> > > $ceph injectargs '--mon_osd_full_ratio 96'
> > > parsed options
> > > $ ceph injectargs '--mon_osd_near_full_ratio 94'
> > > parsed options
> > > =20
> > > ceph pg dump | grep 'full'
> > > full_ratio 0.95
> > > nearfull_ratio 0.85
> > > =20
> > > Setting parameters in the ceph.conf and then restarting mons does=
 not
> > > affect ratios either.
> > =20
> =20
> =20
> =20
> Thanks, it worked, but setting values back result to turn warning bac=
k. =20
Hrm. That shouldn't be possible if the OSD has been removed. How did yo=
u take it out? It sounds like maybe you just marked it in the OUT state=
 (and turned it off quite quickly) without actually taking it out of th=
e cluster? =20
-Greg

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
