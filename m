From: Gregory Farnum <greg@inktank.com>
Subject: Re: [RFC] Inline data support for Ceph
Date: Mon, 25 Feb 2013 14:22:01 -0800
Message-ID: <CAPYLRzjoNJNhtn1v7nCnvmh5uPBwvOG3a50Uu+HyCVBu38+PzA@mail.gmail.com>
References: <tencent_135BE907506ADB755BF2E58C@qq.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qe0-f54.google.com ([209.85.128.54]:33091 "EHLO
	mail-qe0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932676Ab3BYWWD convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Feb 2013 17:22:03 -0500
Received: by mail-qe0-f54.google.com with SMTP id k5so1796359qej.41
        for <ceph-devel@vger.kernel.org>; Mon, 25 Feb 2013 14:22:02 -0800 (PST)
In-Reply-To: <tencent_135BE907506ADB755BF2E58C@qq.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?GB2312?B?zfTA6A==?= <wangli@kylinos.com.cn>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Feb 22, 2013 at 8:17 PM, =CD=F4=C0=E8 <wangli@kylinos.com.cn> w=
rote:
> Hi there,
>    We have a team working on Ceph optimization, for the purpose of in=
tegrating with OpenStack.
>    Currently, Ceph could make use of the inline data feature implemen=
ted in the local file system, such as btrfs. However, we think it maybe=
 better to implement inline data at a higher level, i.e, let Ceph aware=
=2E Since it could save the client the calculation of object location a=
nd communication with the OSDs. It hopefully will receive a good IO spe=
edup for small files, with a slightly heavier load for MDS.
>     We have worked out a plan to do it, and the job is ongoing, and w=
e are wondering the community 's response to this job and its fate for =
inclusion, comments are appreciated.

I'd love to hear more details about this, since it presumably involves
some protocol changes to let the MDS handle file data, as well as the
client logic to update that correctly! :)
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
