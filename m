From: Sage Weil <sage@newdream.net>
Subject: RE: chooseleaf may cause some unnecessary pg migrations
Date: Wed, 14 Oct 2015 05:18:28 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1510140518120.6589@cobra.newdream.net>
References: <FF8D83DAE5DF57468726B79904321E06046B73@H3CMLB12-EX.srv.huawei-3com.com> <CAANLjFpOPXCL0FEkejzR+hBYcH1=Wajvz-12v+XPZT3buA2z2A@mail.gmail.com> <FF8D83DAE5DF57468726B79904321E0604720C@H3CMLB12-EX.srv.huawei-3com.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49383 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751478AbbJNMS3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Oct 2015 08:18:29 -0400
In-Reply-To: <FF8D83DAE5DF57468726B79904321E0604720C@H3CMLB12-EX.srv.huawei-3com.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xusangdi <xu.sangdi@h3c.com>
Cc: Robert LeBlanc <robert@leblancnet.us>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 14 Oct 2015, Xusangdi wrote:
> Straw2. But I had also run the same test for straw alg, which generated 
> quite similar results.

This post explains the current behavior:

http://marc.info/?l=ceph-devel&m=143862308610881&w=2

sage

> 
> > -----Original Message-----
> > From: Robert LeBlanc [mailto:robert@leblancnet.us]
> > Sent: Tuesday, October 13, 2015 10:21 PM
> > To: xusangdi 11976 (RD)
> > Cc: sweil@redhat.com; ceph-devel@vger.kernel.org
> > Subject: Re: chooseleaf may cause some unnecessary pg migrations
> > 
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA256
> > 
> > Are you testing with straw or straw2?
> > - ----------------
> > Robert LeBlanc
> > PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
> > 
> > 
> > On Tue, Oct 13, 2015 at 2:22 AM, Xusangdi  wrote:
> > > Hi Sage,
> > >
> > > Recently when I was learning about the crush rules I noticed that the step chooseleaf may cause
> > some unnecessary pg migrations when OSDs are outed.
> > > For example, for a cluster of 4 hosts with 2 OSDs each, after host1(osd.2, osd.3) is down, the
> > mapping differences would be like this:
> > > pgid    before <-> after        diff    diff_num
> > > 0.1e    [5, 1, 2] <-> [5, 1, 7]         [2]     1
> > > 0.1f    [0, 7, 3] <-> [0, 7, 4]         [3]     1
> > > 0.1a    [0, 4, 3] <-> [0, 4, 6]         [3]     1
> > > 0.5     [6, 3, 1] <-> [6, 0, 5]         [1, 3]  2
> > > 0.4     [5, 6, 2] <-> [5, 6, 0]         [2]     1
> > > 0.7     [3, 7, 0] <-> [7, 0, 4]         [3]     1
> > > 0.6     [2, 1, 7] <-> [0, 7, 4]         [1, 2]  2
> > > 0.9     [3, 4, 0] <-> [5, 0, 7]         [3, 4]  2
> > > 0.15    [2, 6, 1] <-> [6, 0, 5]         [1, 2]  2
> > > 0.14    [3, 6, 5] <-> [7, 4, 1]         [3, 5, 6]       3
> > > 0.17    [0, 5, 2] <-> [0, 5, 6]         [2]     1
> > > 0.16    [0, 4, 2] <-> [0, 4, 7]         [2]     1
> > > 0.11    [4, 7, 2] <-> [4, 7, 1]         [2]     1
> > > 0.10    [0, 3, 6] <-> [0, 7, 4]         [3, 6]  2
> > > 0.13    [1, 7, 3] <-> [1, 7, 4]         [3]     1
> > > 0.a     [0, 2, 7] <-> [0, 7, 4]         [2]     1
> > > 0.c     [5, 0, 3] <-> [5, 0, 6]         [3]     1
> > > 0.b     [2, 5, 7] <-> [4, 7, 0]         [2, 5]  2
> > > 0.18    [7, 2, 4] <-> [7, 4, 0]         [2]     1
> > > 0.f     [2, 7, 5] <-> [6, 4, 0]         [2, 5, 7]       3
> > > Changed pg ratio: 30 / 32
> > >
> > > I tried to change the code (please see https://github.com/ceph/ceph/pull/6242) and after the
> > modification the result would be like this:
> > > pgid    before <-> after        diff    diff_num
> > > 0.1e    [5, 0, 3] <-> [5, 0, 7]         [3]     1
> > > 0.1f    [0, 6, 3] <-> [0, 6, 4]         [3]     1
> > > 0.1a    [0, 5, 2] <-> [0, 5, 6]         [2]     1
> > > 0.5     [6, 3, 0] <-> [6, 0, 5]         [3]     1
> > > 0.4     [5, 7, 2] <-> [5, 7, 0]         [2]     1
> > > 0.7     [3, 7, 1] <-> [7, 1, 5]         [3]     1
> > > 0.6     [2, 0, 7] <-> [0, 7, 4]         [2]     1
> > > 0.9     [3, 5, 1] <-> [5, 1, 7]         [3]     1
> > > 0.15    [2, 6, 1] <-> [6, 1, 4]         [2]     1
> > > 0.14    [3, 7, 5] <-> [7, 5, 1]         [3]     1
> > > 0.17    [0, 4, 3] <-> [0, 4, 6]         [3]     1
> > > 0.16    [0, 4, 3] <-> [0, 4, 6]         [3]     1
> > > 0.11    [4, 6, 3] <-> [4, 6, 0]         [3]     1
> > > 0.10    [0, 3, 6] <-> [0, 6, 5]         [3]     1
> > > 0.13    [1, 7, 3] <-> [1, 7, 5]         [3]     1
> > > 0.a     [0, 3, 6] <-> [0, 6, 5]         [3]     1
> > > 0.c     [5, 0, 3] <-> [5, 0, 6]         [3]     1
> > > 0.b     [2, 4, 6] <-> [4, 6, 1]         [2]     1
> > > 0.18    [7, 3, 5] <-> [7, 5, 1]         [3]     1
> > > 0.f     [2, 6, 5] <-> [6, 5, 1]         [2]     1
> > > Changed pg ratio: 20 / 32
> > >
> > > Currently the only defect I can see from the change is that the chance for a given pg to successfully
> > choose required available OSDs might be a bit lower compared with before. However, I believe it will
> > cause problems only when the cluster is pretty small and degraded. And in that case, we can still make
> > it workable by tuning some of the crushmap parameters such as chooseleaf_tries.
> > >
> > > Anyway I'm not sure if it would raise any other issues, could you please review it and maybe give me
> > some suggestions? Thank you!
> > >
> > > ----------
> > > Best regards,
> > > Sangdi
> > >
> > > ----------------------------------------------------------------------
> > > ---------------------------------------------------------------
> > > ????????????????????????????????????????
> > > ????????????????????????????????????????
> > > ????????????????????????????????????????
> > > ???
> > > This e-mail and its attachments contain confidential information from
> > > H3C, which is intended only for the person or entity whose address is
> > > listed above. Any use of the information contained herein in any way
> > > (including, but not limited to, total or partial disclosure,
> > > reproduction, or dissemination) by persons other than the intended
> > > recipient(s) is prohibited. If you receive this e-mail in error,
> > > please notify the sender by phone or email immediately and delete it!
> > 
> > -----BEGIN PGP SIGNATURE-----
> > Version: Mailvelope v1.2.0
> > Comment: https://www.mailvelope.com
> > 
> > wsFcBAEBCAAQBQJWHRM4CRDmVDuy+mK58QAARVMP/jhhtyRsiUXw4kl2ikso
> > F8CiAwPuGRMvFSa2CXqzvaHnNjiy8Q4uR8o0KgcR04eiLGPUeahjyAQ73+8k
> > geryb9ymjoDFjkKX2n7YxCHy/MnB5HayNIuUPi+KUFzpradx1v7S54XL2DHm
> > mDRR2DDeou9H6WcIqknRh4e6fc1a70E2CbpKr9qu7AiNiEfRZzXod//joavW
> > h0MkYC0Ug41UG64R9QTCJOKp+wSjri+IUgSSrs3WPYXb5W1jZPFIhsFkigws
> > VgitZTv3+rO5ZyHbtCR+3yNI5isU18Lhf+Dr01MExUuyCQQz6zODXV0W+xgP
> > wsMSe8ZXXr84a/8MKoP90mr2pNiiasMwWrcZ/klQ9J4AIqh8DJEHJeAWf+4N
> > pYWTiRFbq3NZzIUjTBqtP/AliKvCTDQhVP3E8hK1qYg4Gv0gQ0Zu76F5c5/p
> > rj9HTZa+o8rSQM0TDuiqKSMEJUcuMt/TScWmQNZF1GTb3HSx6LW6H+aOkLuE
> > N0Fi+rkYupxXC3P3HnU35GMzlum//j/svIFkLOA5V5abVAttcxrGg9jpebUO
> > i3f4DR6e86RNLMaakNoybYlK9J+7j3JjKydBTqkDn9sKBeMaE/oW21Ft99/z
> > eJDLf+8xGt02tV512mPDw8SWJZUws3/B4qc4yrkYUe2aWBeHrE7vIX8ZgC1M
> > icrE
> > =/pQd
> > -----END PGP SIGNATURE-----
> N?????r??y??????X???v???)?{.n?????z?]z????ay?????j??f???h??????w??????j:+v???w????????????zZ+???????j"????i
