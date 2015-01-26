From: Yuri Weinstein <yuri.weinstein@inktank.com>
Subject: Re: upcoming dumpling v0.67.12
Date: Mon, 26 Jan 2015 09:00:00 -0800
Message-ID: <CAJBxG-u=ffbwSkwdtiUM7NSnGdnaXjb_VOmOVfkA8LTX9ANYWg@mail.gmail.com>
References: <54C65F3D.5020200@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:57587 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752905AbbAZRAB convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 26 Jan 2015 12:00:01 -0500
Received: by mail-ob0-f182.google.com with SMTP id gq1so8681800obb.13
        for <ceph-devel@vger.kernel.org>; Mon, 26 Jan 2015 09:00:00 -0800 (PST)
In-Reply-To: <54C65F3D.5020200@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Loic,

Thanks for the update.
I ran upgrade/dumpling last week (and all 42 jobs passed in octo and
sepia) to establish a base line.  And today running another one,
assuming it will pick up the already merged pull requests.

Let me know when you ready for next steps.

Thx
YuriW

On Mon, Jan 26, 2015 at 7:37 AM, Loic Dachary <loic@dachary.org> wrote:
> Hi Yuri,
>
> Here is a short update on the progress of the upcoming dumpling v0.67=
=2E12.
>
> It is tracked with http://tracker.ceph.com/issues/10560. In the inven=
tory part, there is a list of all pull requests that are already merged=
 in the dumpling branch. There only is one pull request waiting to be m=
erged and three issues waiting for backports. While these last three ar=
e being worked on, I started rbd, rgw and rados suites.
>
> I chose to display the inventory by pull request because I figured it=
 would be more convenient to read because sometimes a single pull reque=
st spans multiple issues ( https://github.com/ceph/ceph/pull/2611 for i=
nstance fixes two issues ).
>
> Cheers
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
