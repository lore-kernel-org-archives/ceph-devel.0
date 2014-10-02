From: Patrick McGarry <patrick@inktank.com>
Subject: Re: [ceph-users] Ceph Developer Summit: Hammer
Date: Thu, 2 Oct 2014 16:00:21 -0700
Message-ID: <CAP8Oy=J90nuAyY5+1V9gUGYFLYyRnq5wVE6rZruFfOS98RAJiA@mail.gmail.com>
References: <alpine.DEB.2.00.1410011331070.31126@cobra.newdream.net>
	<e480c990-30f4-428e-b508-6248ae65a96d@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f182.google.com ([209.85.220.182]:47881 "EHLO
	mail-vc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751953AbaJBXAW convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Oct 2014 19:00:22 -0400
Received: by mail-vc0-f182.google.com with SMTP id la4so72089vcb.27
        for <ceph-devel@vger.kernel.org>; Thu, 02 Oct 2014 16:00:21 -0700 (PDT)
In-Reply-To: <e480c990-30f4-428e-b508-6248ae65a96d@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: Sage Weil <sweil@redhat.com>, Ceph-User <ceph-users@ceph.com>, Ceph Devel <ceph-devel@vger.kernel.org>

Hey Alexandre,

Sounds like work has started on this (under the title "RBD Mirroring")
and is continuing in Hammer.  I have updated the title and moved it to
Hammer so there will be a design discussion at CDS.  Thanks!

https://wiki.ceph.com/Planning/Blueprints/Hammer/RBD%3A_Mirroring


Best Regards,

Patrick McGarry
Director Ceph Community || Red Hat
http://ceph.com  ||  http://community.redhat.com
@scuttlemonkey || @ceph


On Wed, Oct 1, 2014 at 4:47 PM, Alexandre DERUMIER <aderumier@odiso.com=
> wrote:
> Hi,
>
> any news about this blueprint ?
>
> https://wiki.ceph.com/Planning/Blueprints/Giant/rbd%3A_journaling
>
>
> Regards,
>
> Alexandre
> ----- Mail original -----
>
> De: "Sage Weil" <sweil@redhat.com>
> =C0: "Patrick McGarry" <patrick@inktank.com>
> Cc: "Ceph-User" <ceph-users@ceph.com>, ceph-devel@vger.kernel.org
> Envoy=E9: Mercredi 1 Octobre 2014 22:32:30
> Objet: Re: [ceph-users] Ceph Developer Summit: Hammer
>
> [adding ceph-devel]
>
>> On Tue, Sep 30, 2014 at 5:30 PM, Yann Dupont <yd@objoo.org> wrote:
>> >
>> > Le 30/09/2014 22:55, Patrick McGarry a ?crit :
>> >>
>> >> Hey cephers,
>> >>
>> >> The schedule and call for blueprints is now up for our next CDS a=
s we
>> >> aim for the Hammer release:
>> >>
>> >> http://ceph.com/community/ceph-developer-summit-hammer/
>> >>
>> >> If you have any work that you plan on submitting through the end =
of
>> >> the year, please fill out a Blueprint (the big red button) as soo=
n as
>> >> possible. Each blueprint will get a planning session with Sage an=
d
>> >> the community to make sure all work is well coordinated and plann=
ed.
>> >>
>> >> If you have questions, or would like my help on the Blueprint pro=
cess,
>> >> please don't hesitate to contact me. Thanks!
>> >>
>> > Hi patrick (and other cephers)
>> > Before making any new blueprint, I was reviewing some past ones, i=
n
>> > particular :
>> >
>> > https://wiki.ceph.com/Planning/Blueprints/Giant/librados%3A_suppor=
t_parallel_reads
>> > (I made some comments yesterday)
>
> Not implemented
>
>> > and even an older one (somewhat related):
>> >
>> > https://wiki.ceph.com/Planning/Blueprints/Emperor/librados%2F%2Fob=
jecter%3A_smarter_localized_reads
>
> Implemented!
>
>> > Is there a way to know if those blueprints are implemented, or in =
active
>> > developpement ? In case of postponed blueprints, is there a way to=
 promote
>> > them again, to get consideration for hammer ?
>
> Hmm, Patrick, I think what we've done in the past is to move the
> still-useful blueprints to the sideboard? You probably already asked =
me
> to do that... :)
>
> sage
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
