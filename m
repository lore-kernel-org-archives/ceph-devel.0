From: Tommi Virtanen <tv@inktank.com>
Subject: Re: Journal too small
Date: Thu, 17 May 2012 10:00:10 -0700
Message-ID: <CADvuQREq_EZHBshxEyWQTFoBnTYy1j_VvW6yUwVXXk1ddBM+NA@mail.gmail.com>
References: <201205171259.55967.karol.jurak@gmail.com> <Pine.LNX.4.64.1205170901100.7019@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:57803 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751366Ab2EQRAd convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 May 2012 13:00:33 -0400
Received: by dady13 with SMTP id y13so2662469dad.19
        for <ceph-devel@vger.kernel.org>; Thu, 17 May 2012 10:00:32 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1205170901100.7019@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Karol Jurak <karol.jurak@gmail.com>, ceph-devel@vger.kernel.org

On Thu, May 17, 2012 at 9:01 AM, Sage Weil <sage@inktank.com> wrote:
>> 2012-05-12 13:31:04.034144 7f491061d700 =C2=A01 journal check_for_fu=
ll at
>> 863363072 : JOURNAL FULL 863363072 >=3D 1048571903 (max_size 1048576=
000
>> start 863363072)
>> 2012-05-12 13:31:04.034680 7f491061d700 =C2=A00 journal JOURNAL TOO =
SMALL: item
>> 1693745152 > journal 1048571904 (usable)

> The osds tolerate the full journal. =C2=A0There will be a big latency=
 spike,
> but they'll recover without risking data. =C2=A0You should definitely=
 increase
> the journal size if this happens regulary, though.

I propose for your merging pleasure:
https://github.com/ceph/ceph/commits/journal-too-small
https://github.com/ceph/ceph/commit/62db60bede8b187e25acb715f6616d2ce7c=
fc97f
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
