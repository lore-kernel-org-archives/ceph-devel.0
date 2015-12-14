From: Abhishek Varshney <abhishek.varshney@flipkart.com>
Subject: Re: Stable release HOWTO: hunt for lost page
Date: Mon, 14 Dec 2015 20:10:30 +0530
Message-ID: <CAP3mxSwdrEN72xxCyCsvjkT5DSrk+jw3W2DnQ5sUL1grHZhFBw@mail.gmail.com>
References: <566ED01C.2020306@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:33524 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750801AbbLNOkc convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Dec 2015 09:40:32 -0500
Received: by lbbkw15 with SMTP id kw15so107182197lbb.0
        for <ceph-devel@vger.kernel.org>; Mon, 14 Dec 2015 06:40:31 -0800 (PST)
In-Reply-To: <566ED01C.2020306@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Nathan Cutler <ncutler@suse.cz>, Abhishek L <abhishek.lekshmanan@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

Hi Loic,

I have revived the page at
http://tracker.ceph.com/projects/ceph-releases/wiki/HOWTO_triage_incomi=
ng_backport_pull_requests
from https://web.archive.org with a version cached on 4th October.
Please review it, in case there are any changes to it.

Disabling the page deletion sounds like a good idea.

Thanks
Abhishek

On Mon, Dec 14, 2015 at 7:50 PM, Loic Dachary <loic@dachary.org> wrote:
> Hi,
>
> It looks like we've lost http://tracker.ceph.com/projects/ceph-releas=
es/wiki/HOWTO_triage_incoming_backport_pull_requests . We can re-write =
it, of course, it's not that complex. But looking at the index I can't =
find it ( http://tracker.ceph.com/projects/ceph-releases/wiki/index ) a=
nd the activity backlog ( http://tracker.ceph.com/projects/ceph-release=
s/activity?utf8=3D%E2%9C%93&show_issues=3D1&show_wiki_edits=3D1 ) does =
not show an event when a page is deleted.
>
> I suppose it's an accident and I propose we disable the page deletion=
 feature to avoid such mistakes in the future (pages can be renamed to =
things like REMOVE-ME instead ;-).
>
> What do you think ?
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
