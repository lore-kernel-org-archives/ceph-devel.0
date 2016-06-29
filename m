From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: rbd jewel backports related to mirroring
Date: Wed, 29 Jun 2016 08:43:59 -0400
Message-ID: <CA+aFP1Cp+Up4z7=JoNm+7PwtHXmFc2gfo+sYcEFMQ8pDLzwiLQ@mail.gmail.com>
References: <57738FE7.4060309@dachary.org>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34467 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751767AbcF2MoB convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Jun 2016 08:44:01 -0400
Received: by mail-pf0-f181.google.com with SMTP id h14so17986070pfe.1
        for <ceph-devel@vger.kernel.org>; Wed, 29 Jun 2016 05:44:00 -0700 (PDT)
In-Reply-To: <57738FE7.4060309@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

My usual strategy just involves running "git cherry-pick -x" against
any prior commits associated with the file with the merge conflict (I
usually try to pull in the whole PR instead of just the single commit
causing the merge conflict). These extra cherry-picks will be cleanly
merged away when the PRs are merged into a single branch.  I usually
run "git log --graph --decorate --date=3Drelative --oneline" to see the
associated PRs of prior commits.

On Wed, Jun 29, 2016 at 5:07 AM, Loic Dachary <loic@dachary.org> wrote:
> Hi Jason,
>
> While working on jewel backports I noticed that there are a number of=
 rbd backports ( http://tracker.ceph.com/projects/ceph/issues?per_page=3D=
100&query_id=3D96 ) related to mirroring. At least three of them do not=
 apply cleanly and I suspect they are interdependant. Is there a way to=
 figure out the order in which they should be applied ? If not I'll sor=
t it out anyway, no worries ;-)
>
> Cheers
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre



--=20
Jason
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
