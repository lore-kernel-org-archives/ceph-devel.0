From: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Subject: Re: rgw and the next firefly release
Date: Tue, 3 Mar 2015 10:54:55 -0500 (EST)
Message-ID: <1002770765.15368136.1425398095286.JavaMail.zimbra@redhat.com>
References: <54F19BF7.6030808@dachary.org> <1610756257.12816609.1425142542413.JavaMail.zimbra@redhat.com> <1845838520.13663626.1425312514641.JavaMail.zimbra@redhat.com> <54F49366.9080203@dachary.org> <773298376.13717568.1425316887571.JavaMail.zimbra@redhat.com> <54F5CBDC.5000101@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]:33812 "EHLO
	mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755413AbbCCP4A convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Mar 2015 10:56:00 -0500
In-Reply-To: <54F5CBDC.5000101@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>



----- Original Message -----
> From: "Loic Dachary" <loic@dachary.org>
> To: "Yehuda Sadeh-Weinraub" <yehuda@redhat.com>
> Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
> Sent: Tuesday, March 3, 2015 6:57:32 AM
> Subject: Re: rgw and the next firefly release
>=20
> Hi Yehuda,
>=20
> The rgw suite came back green http://tracker.ceph.com/issues/10641#rg=
w with
> https://github.com/ceph/ceph/tree/firefly-backports which includes th=
e
> requested backports.
>=20
> Do you think it is ready for QE to start their own round of testing ?

Yes.

Thanks,
Yehuda

>=20
> Cheers
>=20
> On 02/03/2015 18:21, Yehuda Sadeh-Weinraub wrote:
> >=20
> >=20
> > ----- Original Message -----
> >> From: "Loic Dachary" <loic@dachary.org>
> >> To: "Yehuda Sadeh-Weinraub" <yehuda@redhat.com>
> >> Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
> >> Sent: Monday, March 2, 2015 8:44:22 AM
> >> Subject: Re: rgw and the next firefly release
> >>
> >> Hi Yehuda,
> >>
> >> On 02/03/2015 17:08, Yehuda Sadeh-Weinraub wrote:
> >>>
> >>>
> >>> ----- Original Message -----
> >>>> From: "Yehuda Sadeh-Weinraub" <yehuda@redhat.com>
> >>>> To: "Loic Dachary" <loic@dachary.org>
> >>>> Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
> >>>> Sent: Saturday, February 28, 2015 8:55:42 AM
> >>>> Subject: Re: rgw and the next firefly release
> >>>>
> >>>>
> >>>>
> >>>> ----- Original Message -----
> >>>>> From: "Loic Dachary" <loic@dachary.org>
> >>>>> To: "Yehuda Sadeh" <yehuda@redhat.com>
> >>>>> Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
> >>>>> Sent: Saturday, February 28, 2015 2:44:07 AM
> >>>>> Subject: rgw and the next firefly release
> >>>>>
> >>>>> Hi Yehuda,
> >>>>>
> >>>>> The rados teuthology suite for the next firefly release as foun=
d in
> >>>>> https://github.com/ceph/ceph/commits/firefly-backports came bac=
k green
> >>>>> http://pulpito.ceph.com/loic-2015-02-27_18:04:18-rgw-firefly-ba=
ckports---basic-multi/.
> >>>>> Do you think it is ready for QE to start their own round of tes=
ting ?
> >>>>>
> >>>>> Cheers
> >>>>
> >>>> I think the following issues need to get in:
> >>>>  - 10978 (fix still hasn't made it upstream, current commit:
> >>>>  b6e43e30b39aed701bb4cdfaa0f6b27c1f207d86)
> >>> it's actually eb13f2d4b60c031f16139f7cc4237c012644dd78. Sent pull=
 request
> >>> #3843.
> >>
> >> Would you like me to cherry-pick this one to firefly and schedule =
a run of
> >> rgw suite with it ?
> >=20
> > Yes. Also, the other ones need to be cherry-picked, all should be i=
n master
> > already.
> >=20
> > Thanks,
> > Yehuda
> >=20
> >>
> >> https://github.com/ceph/ceph/pull/3843
> >>
> >> Cheers
> >>>
> >>>>  - 10965 (fix still hasn't made it upstream, current commits:
> >>>>  f28fe744285117a1715eac0d08911cdb37285103,
> >>>>  caa90225bad9fe5e9c275e6189b3396b4d396e3f)
> >>>>  - 10907 (commit: 986d7554426764a149621ba733c5c075b94e0431)
> >>>>
> >>>>
> >>>> I prepared the top two branches, need to do a sanity check on th=
em
> >>>> first,
> >>>> then I'll send a pull request to master. I think 10978 is critic=
al, the
> >>>> bottom two are important for civetweb and less risky.
> >>>>
> >>>> Yehuda
> >>>> --
> >>>> To unsubscribe from this list: send the line "unsubscribe ceph-d=
evel" in
> >>>> the body of a message to majordomo@vger.kernel.org
> >>>> More majordomo info at  http://vger.kernel.org/majordomo-info.ht=
ml
> >>>>
> >>> --
> >>> To unsubscribe from this list: send the line "unsubscribe ceph-de=
vel" in
> >>> the body of a message to majordomo@vger.kernel.org
> >>> More majordomo info at  http://vger.kernel.org/majordomo-info.htm=
l
> >>>
> >>
> >> --
> >> Lo=C3=AFc Dachary, Artisan Logiciel Libre
> >>
> >>
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >=20
>=20
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>=20
>=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
