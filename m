From: kefu chai <tchaikov@gmail.com>
Subject: Re: adding "{mds,mon} metadata" asok command
Date: Thu, 26 Mar 2015 02:18:11 +0800
Message-ID: <CAJE9aONdmGTxFohaDgbSK6dZNKqDhCmjOo0Du=ZZyzzCy3W4UQ@mail.gmail.com>
References: <CAJE9aOP2g4=Pw-oGY4m90aXayc=Kx_GP8yLC+tTkSE62V6ObuQ@mail.gmail.com>
	<alpine.DEB.2.00.1503200628150.7043@cobra.newdream.net>
	<550FE53B.9050407@gmail.com>
	<550FEC6A.1030208@redhat.com>
	<alpine.DEB.2.00.1503230656560.6964@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:35114 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752135AbbCYSSM convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Mar 2015 14:18:12 -0400
Received: by igcau2 with SMTP id au2so108874695igc.0
        for <ceph-devel@vger.kernel.org>; Wed, 25 Mar 2015 11:18:11 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1503230656560.6964@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: John Spray <john.spray@redhat.com>, Joao Eduardo Luis <jecluis@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Mar 23, 2015 at 9:58 PM, Sage Weil <sage@newdream.net> wrote:
> On Mon, 23 Mar 2015, John Spray wrote:
>> On 23/03/2015 10:04, Joao Eduardo Luis wrote:
>> > I agree.  And I don't think we need a new service for this, and I =
also don't
>> > think we need to write stuff to the store.  We can generate this i=
nformation
>> > when the monitor hits 'bootstrap()' and share it with the rest of =
the quorum
>> > once an election finishes, and always keep it in memory (unless th=
ere's some
>> > information that needs to be persisted, but I was under the impres=
sion that
>> > was not the case).

thanks Jo=C3=A3o. yes, i will have another map in DataHealthService for=
 the
metadata. and update it in the way we update the health data. but will
only send the MMonUpdateMetadata when the service bootstraps itself.
and i will see if we can/need to remove the mon in the metadata map
after it is removed from the quorum.

>>
>> Just to clarify, you mean we don't need to write the mon metadata to=
 the
>> store, but we'd still want to persist the MDS/OSD metadata - right?
>
> I think we definitely still want to persist those (as we already do
> persist the OSD metadata).

agreed, that's also my impression.

>
> Since we're reporting on running daemons we could get that without
> persisting the mon metadata.  I think the question is whether we want=
 to
> report on the last known running instance.  I forget whether 'osd
> metadata' includes OSDs that are down... if so, we may as well do
> the same for mons too and persist that.

yes, "osd metadata" also includes OSDs that are down, except for the
ones explicitly removed using "osd rm".

>
> sage



--=20
Regards
Kefu Chai
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
