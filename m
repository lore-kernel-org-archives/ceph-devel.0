From: Samuel Just <sam.just@inktank.com>
Subject: Re: Separating Peering from PG
Date: Fri, 21 Jun 2013 09:38:33 -0700
Message-ID: <CA+4uBUYTieHXeOWQXtqvRg6jX-fS1cedt74H2-v36FZhSwqo0A@mail.gmail.com>
References: <51C4570F.70206@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ve0-f174.google.com ([209.85.128.174]:62769 "EHLO
	mail-ve0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161432Ab3FUQid convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 21 Jun 2013 12:38:33 -0400
Received: by mail-ve0-f174.google.com with SMTP id oz10so6499080veb.5
        for <ceph-devel@vger.kernel.org>; Fri, 21 Jun 2013 09:38:33 -0700 (PDT)
In-Reply-To: <51C4570F.70206@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Sage Weil <sage@inktank.com>, Ceph Development <ceph-devel@vger.kernel.org>

I'm not sure I understand, by PG::RecoveryStats, do you mean PG::Recove=
ryState?
-Sam

On Fri, Jun 21, 2013 at 6:37 AM, Loic Dachary <loic@dachary.org> wrote:
> Hi Sage,
>
> In order to move the PG peering code out of PG.{cc,h} (which is the n=
ext step in refactoring PGs as suggested by Sam http://pad.ceph.com/p/E=
rasure_encoding_as_a_storage_backend ) I think it would be sensible to:
>
> * Move PG::RecoveryStats in PGRecoveryStat.{cc,h}
> * Create PGInterface : an abstract base class for PG enumerating all =
PG methods used by PGRecoveryStats
> * Move Peering states / methods out of PGRecoveryStat.{cc,h} and into=
 PGPeering.{cc,h}
> * Write tests for PGPeering.{cc,h}, using a fixture derived from PGIn=
terface
>
> Because this approach not only moves the peering out of PG.{cc,h} but=
 also the rest of the state logic, I would like to know if this seems s=
ensible to you. Also, introducing an abstract base class to help isolat=
e the PG interface and facilitate writing fixtures has not been discuss=
ed yet.
>
> Cheers
>
> --
> Lo=EFc Dachary, Artisan Logiciel Libre
> All that is necessary for the triumph of evil is that good people do =
nothing.
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
