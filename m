From: Loic Dachary <loic@dachary.org>
Subject: Re: rbd jewel backports related to mirroring
Date: Wed, 29 Jun 2016 15:04:03 +0200
Message-ID: <5773C743.1090206@dachary.org>
References: <57738FE7.4060309@dachary.org>
 <CA+aFP1Cp+Up4z7=JoNm+7PwtHXmFc2gfo+sYcEFMQ8pDLzwiLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:34175 "EHLO
	slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751962AbcF2NNI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Jun 2016 09:13:08 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	by slow1-d.mail.gandi.net (Postfix) with ESMTP id 69BD54B6D14
	for <ceph-devel@vger.kernel.org>; Wed, 29 Jun 2016 15:04:39 +0200 (CEST)
In-Reply-To: <CA+aFP1Cp+Up4z7=JoNm+7PwtHXmFc2gfo+sYcEFMQ8pDLzwiLQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: dillaman@redhat.com
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Thanks for the hint, I'll try that.

On 29/06/2016 14:43, Jason Dillaman wrote:
> My usual strategy just involves running "git cherry-pick -x" against
> any prior commits associated with the file with the merge conflict (I
> usually try to pull in the whole PR instead of just the single commit
> causing the merge conflict). These extra cherry-picks will be cleanly
> merged away when the PRs are merged into a single branch.  I usually
> run "git log --graph --decorate --date=3Drelative --oneline" to see t=
he
> associated PRs of prior commits.
>=20
> On Wed, Jun 29, 2016 at 5:07 AM, Loic Dachary <loic@dachary.org> wrot=
e:
>> Hi Jason,
>>
>> While working on jewel backports I noticed that there are a number o=
f rbd backports ( http://tracker.ceph.com/projects/ceph/issues?per_page=
=3D100&query_id=3D96 ) related to mirroring. At least three of them do =
not apply cleanly and I suspect they are interdependant. Is there a way=
 to figure out the order in which they should be applied ? If not I'll =
sort it out anyway, no worries ;-)
>>
>> Cheers
>> --
>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>=20
>=20
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
