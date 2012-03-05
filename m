From: Henry C Chang <henry.cy.chang@gmail.com>
Subject: Re: PG state issue
Date: Mon, 5 Mar 2012 17:18:26 +0800
Message-ID: <CANExM-Nb48s1ASTRuV1daSe3X1PhLfxza6+zUJNGShGL+tSLiA@mail.gmail.com>
References: <CANExM-MJ6eSifymHe-aSwwyPkBaTSbLUVZGHVwvrcUFGpNopoA@mail.gmail.com>
	<Pine.LNX.4.64.1203010810330.30824@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:58503 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756423Ab2CEJS1 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Mar 2012 04:18:27 -0500
Received: by wejx9 with SMTP id x9so2187726wej.19
        for <ceph-devel@vger.kernel.org>; Mon, 05 Mar 2012 01:18:26 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.1203010810330.30824@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Sage,

I just tested v0.43. All pgs are shown active+degraded now. However,
is it possible to show the number (or percentage) of degraded objects
as in the earlier version?

Henry

=E5=9C=A8 2012=E5=B9=B43=E6=9C=882=E6=97=A5=E4=B8=8A=E5=8D=8812:14=EF=BC=
=8CSage Weil <sage@newdream.net> =E5=AF=AB=E9=81=93=EF=BC=9A
> Hi Henry, Wido,
>
> On Thu, 1 Mar 2012, Henry C Chang wrote:
>> With version 0.42, I found that the pg's state is not in "degrade" a=
ny
>> more if the number of osds is smaller than that of the replication.
>> For example, if I create a cluster of one osd with replication 2, al=
l
>> pgs are in active+clean state. (The pgs were in active+clean+degrade
>> state in the earlier versions.)
>
> The PG states were tweaked a fair bit for v0.43:
>
> - new 'recovering' state means we are actively recovering the PG (no
> =C2=A0longer implied by lack of 'clean')
> - 'remapped' means we have temporarily remapped a pg to a specific se=
t of
> =C2=A0OSDs (other than what CRUSH gives us)
> - 'clean' specifically means we have the right number of replicas and
> =C2=A0aren't remapped.
>
> ...and the 'degraded' thing you are seeing is fixed. =C2=A0This is al=
l in place
> in the 'next' or 'master' branches.
>
>> I think it should be a bug in terms of cluster status although it do=
es
>> not cause any other problems to me so far.
>
> Yeah, it's simply a matter of how the internal state is displayed/rep=
orted
> to the moitor.
>
> sage
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
