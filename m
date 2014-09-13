From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: [ceph-users] OpTracker optimization
Date: Sat, 13 Sep 2014 11:00:42 +0200 (CEST)
Message-ID: <0b0459cc-3a8b-485f-9c69-d64c92d6c3dd@mailpro>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F2783E75D@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:49521 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751765AbaIMJAw convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 13 Sep 2014 05:00:52 -0400
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F2783E75D@SACMBXIP02.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: Sage Weil <sweil@redhat.com>, ceph-devel@vger.kernel.org, ceph-users@lists.ceph.com, Samuel Just <sam.just@inktank.com>

Hi,
as ceph user, It could be wonderfull to have it for Giant,
optracker performance impact is really huge (See my ssd benchmark on ce=
ph user mailing)

Regards,

Alexandre Derumier

----- Mail original -----=20

De: "Somnath Roy" <Somnath.Roy@sandisk.com>=20
=C3=80: "Samuel Just" <sam.just@inktank.com>=20
Cc: "Sage Weil" <sweil@redhat.com>, ceph-devel@vger.kernel.org, ceph-us=
ers@lists.ceph.com=20
Envoy=C3=A9: Samedi 13 Septembre 2014 10:03:52=20
Objet: Re: [ceph-users] OpTracker optimization=20

Sam/Sage,=20
I saw Giant is forked off today. We need the pull request (https://gith=
ub.com/ceph/ceph/pull/2440) to be in Giant. So, could you please merge =
this into Giant when it will be ready ?=20

Thanks & Regards=20
Somnath=20

-----Original Message-----=20
=46rom: Samuel Just [mailto:sam.just@inktank.com]=20
Sent: Thursday, September 11, 2014 11:31 AM=20
To: Somnath Roy=20
Cc: Sage Weil; ceph-devel@vger.kernel.org; ceph-users@lists.ceph.com=20
Subject: Re: OpTracker optimization=20

Just added it to wip-sam-testing.=20
-Sam=20

On Thu, Sep 11, 2014 at 11:30 AM, Somnath Roy <Somnath.Roy@sandisk.com>=
 wrote:=20
> Sam/Sage,=20
> I have addressed all of your comments and pushed the changes to the s=
ame pull request.=20
>=20
> https://github.com/ceph/ceph/pull/2440=20
>=20
> Thanks & Regards=20
> Somnath=20
>=20
> -----Original Message-----=20
> From: Sage Weil [mailto:sweil@redhat.com]=20
> Sent: Wednesday, September 10, 2014 8:33 PM=20
> To: Somnath Roy=20
> Cc: Samuel Just; ceph-devel@vger.kernel.org; ceph-users@lists.ceph.co=
m=20
> Subject: RE: OpTracker optimization=20
>=20
> I had two substantiative comments on the first patch and then some tr=
ivial=20
> whitespace nits. Otherwise looks good!=20
>=20
> tahnks-=20
> sage=20
>=20
> On Thu, 11 Sep 2014, Somnath Roy wrote:=20
>=20
>> Sam/Sage,=20
>> I have incorporated all of your comments. Please have a look at the =
same pull request.=20
>>=20
>> https://github.com/ceph/ceph/pull/2440=20
>>=20
>> Thanks & Regards=20
>> Somnath=20
>>=20
>> -----Original Message-----=20
>> From: Samuel Just [mailto:sam.just@inktank.com]=20
>> Sent: Wednesday, September 10, 2014 3:25 PM=20
>> To: Somnath Roy=20
>> Cc: Sage Weil (sweil@redhat.com); ceph-devel@vger.kernel.org;=20
>> ceph-users@lists.ceph.com=20
>> Subject: Re: OpTracker optimization=20
>>=20
>> Oh, I changed my mind, your approach is fine. I was unclear.=20
>> Currently, I just need you to address the other comments.=20
>> -Sam=20
>>=20
>> On Wed, Sep 10, 2014 at 3:13 PM, Somnath Roy <Somnath.Roy@sandisk.co=
m> wrote:=20
>> > As I understand, you want me to implement the following.=20
>> >=20
>> > 1. Keep this implementation one sharded optracker for the ios goin=
g through ms_dispatch path.=20
>> >=20
>> > 2. Additionally, for ios going through ms_fast_dispatch, you want=20
>> > me to implement optracker (without internal shard) per opwq shard=20
>> >=20
>> > Am I right ?=20
>> >=20
>> > Thanks & Regards=20
>> > Somnath=20
>> >=20
>> > -----Original Message-----=20
>> > From: Samuel Just [mailto:sam.just@inktank.com]=20
>> > Sent: Wednesday, September 10, 2014 3:08 PM=20
>> > To: Somnath Roy=20
>> > Cc: Sage Weil (sweil@redhat.com); ceph-devel@vger.kernel.org;=20
>> > ceph-users@lists.ceph.com=20
>> > Subject: Re: OpTracker optimization=20
>> >=20
>> > I don't quite understand.=20
>> > -Sam=20
>> >=20
>> > On Wed, Sep 10, 2014 at 2:38 PM, Somnath Roy <Somnath.Roy@sandisk.=
com> wrote:=20
>> >> Thanks Sam.=20
>> >> So, you want me to go with optracker/shadedopWq , right ?=20
>> >>=20
>> >> Regards=20
>> >> Somnath=20
>> >>=20
>> >> -----Original Message-----=20
>> >> From: Samuel Just [mailto:sam.just@inktank.com]=20
>> >> Sent: Wednesday, September 10, 2014 2:36 PM=20
>> >> To: Somnath Roy=20
>> >> Cc: Sage Weil (sweil@redhat.com); ceph-devel@vger.kernel.org;=20
>> >> ceph-users@lists.ceph.com=20
>> >> Subject: Re: OpTracker optimization=20
>> >>=20
>> >> Responded with cosmetic nonsense. Once you've got that and the ot=
her comments addressed, I can put it in wip-sam-testing.=20
>> >> -Sam=20
>> >>=20
>> >> On Wed, Sep 10, 2014 at 1:30 PM, Somnath Roy <Somnath.Roy@sandisk=
=2Ecom> wrote:=20
>> >>> Thanks Sam..I responded back :-)=20
>> >>>=20
>> >>> -----Original Message-----=20
>> >>> From: ceph-devel-owner@vger.kernel.org=20
>> >>> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Samuel=20
>> >>> Just=20
>> >>> Sent: Wednesday, September 10, 2014 11:17 AM=20
>> >>> To: Somnath Roy=20
>> >>> Cc: Sage Weil (sweil@redhat.com); ceph-devel@vger.kernel.org;=20
>> >>> ceph-users@lists.ceph.com=20
>> >>> Subject: Re: OpTracker optimization=20
>> >>>=20
>> >>> Added a comment about the approach.=20
>> >>> -Sam=20
>> >>>=20
>> >>> On Tue, Sep 9, 2014 at 1:33 PM, Somnath Roy <Somnath.Roy@sandisk=
=2Ecom> wrote:=20
>> >>>> Hi Sam/Sage,=20
>> >>>>=20
>> >>>> As we discussed earlier, enabling the present OpTracker code=20
>> >>>> degrading performance severely. For example, in my setup a=20
>> >>>> single OSD node with=20
>> >>>> 10 clients is reaching ~103K read iops with io served from=20
>> >>>> memory while optracking is disabled but enabling optracker it i=
s reduced to ~39K iops.=20
>> >>>> Probably, running OSD without enabling OpTracker is not an=20
>> >>>> option for many of Ceph users.=20
>> >>>>=20
>> >>>> Now, by sharding the Optracker:: ops_in_flight_lock (thus xlist=
=20
>> >>>> ops_in_flight) and removing some other bottlenecks I am able to=
=20
>> >>>> match the performance of OpTracking enabled OSD with OpTracking=
=20
>> >>>> disabled, but with the expense of ~1 extra cpu core.=20
>> >>>>=20
>> >>>> In this process I have also fixed the following tracker.=20
>> >>>>=20
>> >>>>=20
>> >>>>=20
>> >>>> http://tracker.ceph.com/issues/9384=20
>> >>>>=20
>> >>>>=20
>> >>>>=20
>> >>>> and probably http://tracker.ceph.com/issues/8885 too.=20
>> >>>>=20
>> >>>>=20
>> >>>>=20
>> >>>> I have created following pull request for the same. Please revi=
ew it.=20
>> >>>>=20
>> >>>>=20
>> >>>>=20
>> >>>> https://github.com/ceph/ceph/pull/2440=20
>> >>>>=20
>> >>>>=20
>> >>>>=20
>> >>>> Thanks & Regards=20
>> >>>>=20
>> >>>> Somnath=20
>> >>>>=20
>> >>>>=20
>> >>>>=20
>> >>>>=20
>> >>>> ________________________________=20
>> >>>>=20
>> >>>> PLEASE NOTE: The information contained in this electronic mail=20
>> >>>> message is intended only for the use of the designated=20
>> >>>> recipient(s) named above. If the reader of this message is not=20
>> >>>> the intended recipient, you are hereby notified that you have=20
>> >>>> received this message in error and that any review,=20
>> >>>> dissemination, distribution, or copying of this message is=20
>> >>>> strictly prohibited. If you have received this communication in=
=20
>> >>>> error, please notify the sender by telephone or e-mail (as show=
n=20
>> >>>> above) immediately and destroy any and all copies of this messa=
ge in your possession (whether hard copies or electronically stored cop=
ies).=20
>> >>>>=20
>> >>> --=20
>> >>> To unsubscribe from this list: send the line "unsubscribe ceph-d=
evel"=20
>> >>> in the body of a message to majordomo@vger.kernel.org More=20
>> >>> majordomo info at http://vger.kernel.org/majordomo-info.html=20
>> >>>=20
>> >>> ________________________________=20
>> >>>=20
>> >>> PLEASE NOTE: The information contained in this electronic mail m=
essage is intended only for the use of the designated recipient(s) name=
d above. If the reader of this message is not the intended recipient, y=
ou are hereby notified that you have received this message in error and=
 that any review, dissemination, distribution, or copying of this messa=
ge is strictly prohibited. If you have received this communication in e=
rror, please notify the sender by telephone or e-mail (as shown above) =
immediately and destroy any and all copies of this message in your poss=
ession (whether hard copies or electronically stored copies).=20
>> >>>=20
>>=20
_______________________________________________=20
ceph-users mailing list=20
ceph-users@lists.ceph.com=20
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
