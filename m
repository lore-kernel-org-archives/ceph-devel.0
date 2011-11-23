From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: Why Ceph's aggregate write throughput does not scale with the
 number of osd nodes
Date: Wed, 23 Nov 2011 10:53:17 -0800
Message-ID: <CAF3hT9AqbhPDrBmeymTvBO_FZp5FF2VmwyPeh_cQFFgsi-L96A@mail.gmail.com>
References: <CAND_vCaQU5hFk++6mMnS7MwnAoY2_c-xxe3pEbjJsGQuAsaeiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:65343 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751892Ab1KWSxS convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Nov 2011 13:53:18 -0500
Received: by mail-iy0-f174.google.com with SMTP id e36so1977483iag.19
        for <ceph-devel@vger.kernel.org>; Wed, 23 Nov 2011 10:53:17 -0800 (PST)
In-Reply-To: <CAND_vCaQU5hFk++6mMnS7MwnAoY2_c-xxe3pEbjJsGQuAsaeiQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xiaofei Du <xiaofei.du008@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Wed, Nov 23, 2011 at 10:38 AM, Xiaofei Du <xiaofei.du008@gmail.com> =
wrote:
> I searched online. saw=A0Bug #538 and=A0Tasks #584=A0may related to m=
y
> problem. What's the status of this problem? I first used version 0.34=
=2E
> Then I tried a newer version which is 0.37. But the problem still
> exists. Is there anyone who knows this problem and how to solve this?
> Thanks a lot. and Happy Thanksgiving
Can you give us more details about the problem you're seeing? We've
got a pile of new hardware being installed now that we will soon be
doing large-scale testing on so we'll run into any problems. But if
you're seeing scaling issues it'd be good to know something more than
that they're related to two old bugs...
:)
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
