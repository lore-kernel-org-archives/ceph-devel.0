From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: RBD image name constraints
Date: Tue, 12 Apr 2016 15:23:10 +0200
Message-ID: <CAOi1vP-7Xdcy7SAwuwTbjE=YuQy-toLW_tLXYNDsEnM-sDrB=w@mail.gmail.com>
References: <5707A2C4.3030102@corp.ovh.com>
	<20160408202919.GA8043@gmail.com>
	<570B6436.9040109@corp.ovh.com>
	<20160411093703.GA17959@gmail.com>
	<1377018242.49644766.1460384950765.JavaMail.zimbra@redhat.com>
	<CAOi1vP9a1qtB0RjbEuoj=Lwy99h32KRh6OArGQO-xzAZpOndUA@mail.gmail.com>
	<570CEACA.9020104@corp.ovh.com>
	<1738732185.2918.160e133c-ee3f-4c6e-9b8b-e4d468651d78.open-xchange@ox.pcextreme.nl>
	<842665427.50033069.1460466113899.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f51.google.com ([209.85.215.51]:36430 "EHLO
	mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933298AbcDLNXM convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Apr 2016 09:23:12 -0400
Received: by mail-lf0-f51.google.com with SMTP id g184so24858186lfb.3
        for <ceph-devel@vger.kernel.org>; Tue, 12 Apr 2016 06:23:11 -0700 (PDT)
In-Reply-To: <842665427.50033069.1460466113899.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jason Dillaman <dillaman@redhat.com>
Cc: Wido den Hollander <wido@42on.com>, =?UTF-8?B?QmFydMWCb21pZWogxZp3acSZY2tp?= <bartlomiej.swiecki@corp.ovh.com>, Mykola Golub <mgolub@mirantis.com>, Josh Durgin <jdurgin@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Apr 12, 2016 at 3:01 PM, Jason Dillaman <dillaman@redhat.com> w=
rote:
>> > Op 12 april 2016 om 14:32 schreef Bart=C5=82omiej =C5=9Awi=C4=99ck=
i
>> > <bartlomiej.swiecki@corp.ovh.com>:
>> >
>> >
>> >
>> > On 04/11/2016 05:08 PM, Ilya Dryomov wrote:
>> > > On Mon, Apr 11, 2016 at 4:29 PM, Jason Dillaman <dillaman@redhat=
=2Ecom>
>> > > wrote:
>> > >
>> > >> It would probably make sense to relax it for non-create operati=
ons and
>> > >> use
>> > >> a strict regex for create/clone/import/rename operations.
>> > > I think it would also make sense to start enforcing a limit on t=
he
>> > > length of the image name on create/clone/etc.  I'm not pushing f=
or it
>> > > to be 96 chars (although I do believe it'd be sensible), just th=
at we
>> > > don't want it to be RADOS - strlen("rbd_id.").
>> > >
>> > > Thanks,
>> > >
>> > >                  Ilya
>> > Sounds like a good plan to me, maybe we should also consider allow=
ed
>> > character set? Non-ascii or control characters make little sense h=
ere too.
>> >
>>
>> Seems like a sane thing to me:
>>
>> a-z, A-Z, 0-9, -, _ and . are the characters you want to allow in a =
image's
>> name. I can't think of anything more.
>>
>> Wido
>>
>> > Regards,
>> > Bartek
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> All of this sounds good to me -- we should circulate a proposal in ce=
ph-users before making any change.  Assuming we can reach a plan that d=
oesn't break someone's Ceph deployment, this could be included as part =
of the Kraken-release.
>
> Ilya -- just so that I am clear, is the current kernel limitation 96 =
characters minus the "rbd_id."-prefix (format 2) or ".rbd"-suffix (form=
at 1)?

It's 100 chars for a RADOS object name, including any prefixes and
suffixes.  So 96 chars (matches RBD_MAX_IMAGE_NAME_SIZE) for a format 1
image and 93 chars for a format 2 image.  It's a pity it didn't get
updated when format 2 support got merged...

Thanks,

                Ilya
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
