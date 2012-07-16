From: Gregory Farnum <greg@inktank.com>
Subject: Re: ceph status reporting non-existing osd
Date: Mon, 16 Jul 2012 11:48:07 -0700
Message-ID: <C286CA87975941CD913337EAC9844935@inktank.com>
References: <4FFFD9AB.40608@xdel.ru>
 <CAPYLRzgOHf9nMdK5oOrs6++H22iFLYvcbhMQsZtd8Z3OskX=yw@mail.gmail.com>
 <alpine.DEB.2.00.1207131009280.9771@cobra.newdream.net>
 <CABYiri9wEoPs87qUr2MANX_AHB-aHprJBdXV0o4TxeDPj6SrhQ@mail.gmail.com>
 <823856EB9E9B4D1EBB352F93465B742A@inktank.com>
 <CABYiri-D4qPv1nQ4KHkwDS6wrH9gZdSu=b6ePxk61Ks-qx+Ajg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:58569 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752133Ab2GPSsM convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Jul 2012 14:48:12 -0400
Received: by gglu4 with SMTP id u4so5345552ggl.19
        for <ceph-devel@vger.kernel.org>; Mon, 16 Jul 2012 11:48:11 -0700 (PDT)
In-Reply-To: <CABYiri-D4qPv1nQ4KHkwDS6wrH9gZdSu=b6ePxk61Ks-qx+Ajg@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Korolyov <andrey@xdel.ru>
Cc: Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org

"ceph pg set_full_ratio 0.95" =20
"ceph pg set_nearfull_ratio 0.94"


On Monday, July 16, 2012 at 11:42 AM, Andrey Korolyov wrote:

> On Mon, Jul 16, 2012 at 8:12 PM, Gregory Farnum <greg@inktank.com (ma=
ilto:greg@inktank.com)> wrote:
> > On Saturday, July 14, 2012 at 7:20 AM, Andrey Korolyov wrote:
> > > On Fri, Jul 13, 2012 at 9:09 PM, Sage Weil <sage@inktank.com (mai=
lto:sage@inktank.com)> wrote:
> > > > On Fri, 13 Jul 2012, Gregory Farnum wrote:
> > > > > On Fri, Jul 13, 2012 at 1:17 AM, Andrey Korolyov <andrey@xdel=
=2Eru (mailto:andrey@xdel.ru)> wrote:
> > > > > > Hi,
> > > > > > =20
> > > > > > Recently I`ve reduced my test suite from 6 to 4 osds at ~60=
% usage on
> > > > > > six-node,
> > > > > > and I have removed a bunch of rbd objects during recovery t=
o avoid
> > > > > > overfill.
> > > > > > Right now I`m constantly receiving a warn about nearfull st=
ate on
> > > > > > non-existing osd:
> > > > > > =20
> > > > > > health HEALTH_WARN 1 near full osd(s)
> > > > > > monmap e3: 3 mons at
> > > > > > {0=3D192.168.10.129:6789/0,1=3D192.168.10.128:6789/0,2=3D19=
2.168.10.127:6789/0},
> > > > > > election epoch 240, quorum 0,1,2 0,1,2
> > > > > > osdmap e2098: 4 osds: 4 up, 4 in
> > > > > > pgmap v518696: 464 pgs: 464 active+clean; 61070 MB data, 18=
1 GB
> > > > > > used, 143 GB / 324 GB avail
> > > > > > mdsmap e181: 1/1/1 up {0=3Da=3Dup:active}
> > > > > > =20
> > > > > > HEALTH_WARN 1 near full osd(s)
> > > > > > osd.4 is near full at 89%
> > > > > > =20
> > > > > > Needless to say, osd.4 remains only in ceph.conf, but not a=
t crushmap.
> > > > > > Reducing has been done 'on-line', e.g. without restart enti=
re cluster.
> > > > > =20
> > > > > =20
> > > > > =20
> > > > > =20
> > > > > =20
> > > > > Whoops! It looks like Sage has written some patches to fix th=
is, but
> > > > > for now you should be good if you just update your ratios to =
a larger
> > > > > number, and then bring them back down again. :)
> > > > =20
> > > > =20
> > > > =20
> > > > =20
> > > > =20
> > > > Restarting ceph-mon should also do the trick.
> > > > =20
> > > > Thanks for the bug report!
> > > > sage
> > > =20
> > > =20
> > > =20
> > > =20
> > > =20
> > > Should I restart mons simultaneously?
> > I don't think restarting will actually do the trick for you =E2=80=94=
 you actually will need to set the ratios again.
> > =20
> > > Restarting one by one has no
> > > effect, same as filling up data pool up to ~95 percent(btw, when =
I
> > > deleted this 50Gb file on cephfs, mds was stuck permanently and u=
sage
> > > remained same until I dropped and recreated data pool - hope it`s=
 one
> > > of known posix layer bugs). I also deleted entry from config, and=
 then
> > > restarted mons, with no effect. Any suggestions?
> > =20
> > =20
> > =20
> > I'm not sure what you're asking about here?
> > -Greg
> =20
> =20
> =20
> Oh, sorry, I have mislooked and thought that you suggested filling up
> osds. How do I can set full/nearfull ratios correctly?
> =20
> $ceph injectargs '--mon_osd_full_ratio 96'
> parsed options
> $ ceph injectargs '--mon_osd_near_full_ratio 94'
> parsed options
> =20
> ceph pg dump | grep 'full'
> full_ratio 0.95
> nearfull_ratio 0.85
> =20
> Setting parameters in the ceph.conf and then restarting mons does not
> affect ratios either.



--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
