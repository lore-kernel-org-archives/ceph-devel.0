From: Noah Watkins <noahwatkins@gmail.com>
Subject: Re: [PATCH] wrong unix timestamp calculation in hadoop lib
Date: Fri, 13 Jan 2012 13:58:17 -0800
Message-ID: <CAB2gnbU+S6_t25_8vHYTn5TPOZ1VHwBRjnYj4oaee6OoWVmF0w@mail.gmail.com>
References: <1326467544-19913-1-git-send-email-octo47@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:58171 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753432Ab2AMV6S convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 13 Jan 2012 16:58:18 -0500
Received: by wibhm14 with SMTP id hm14so731908wib.19
        for <ceph-devel@vger.kernel.org>; Fri, 13 Jan 2012 13:58:17 -0800 (PST)
In-Reply-To: <1326467544-19913-1-git-send-email-octo47@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Stepachev <octo47@gmail.com>
Cc: ceph-devel@vger.kernel.org, Andrey Stepachev <octo@yandex-team.ru>

On Fri, Jan 13, 2012 at 07:12, Andrey Stepachev <octo47@gmail.com> wrot=
e:
> From: Andrey Stepachev <octo@yandex-team.ru>
>
> Hadoop always see wrong dates due of wrong timestamp calculation.
> Possibly fixes #1666.

Using coarse-grained timestamps might mask the problem in 1666. But it
would only work in certain circumstances such as when clock sync skew
is sufficiently small, and I think edge conditions would continue to
exist. A more robust solution is probably needed for #1666 :(

> Signed-off-by: Andrey Stepachev <octo@yandex-team.ru>
>
> ---
> =C2=A0src/client/hadoop/CephFSInterface.cc | =C2=A0 =C2=A08 ++++----
> =C2=A01 files changed, 4 insertions(+), 4 deletions(-)
>
> - =C2=A0long long java_mtime(st.st_mtime);
> + =C2=A0long long java_mtime(st.st_mtim.tv_sec);

mtime vs mtim: the later is non-portable?
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
