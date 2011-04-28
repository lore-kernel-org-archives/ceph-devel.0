From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: libceph API
Date: Thu, 28 Apr 2011 11:27:27 -0700
Message-ID: <BANLkTimYqRs_FxtgLAi1Qac7dYcmN_i-rg@mail.gmail.com>
References: <BANLkTim22eFcMzxL0sB4GRpUZfu7FL3x4A@mail.gmail.com>
	<Pine.LNX.4.64.1104202200100.26241@cobra.newdream.net>
	<BANLkTi=DB7sqb9aHmigGiQZWzFAp-jugAA@mail.gmail.com>
	<BANLkTik6+NewTgWodk01NceXVmZW1qpfAg@mail.gmail.com>
	<BANLkTi=w+vwA1Xx0qUx0QXsB8+=nJ0=U+g@mail.gmail.com>
	<20110427192827.GA6405@dreamer>
	<BANLkTi=g1tJTAuQDm4VaMNhj-f72DTKDrA@mail.gmail.com>
	<Pine.LNX.4.64.1104281022200.1187@cobra.newdream.net>
	<BANLkTinJpnMj0ryhFF1ucVjkPs5NeZ1taQ@mail.gmail.com>
	<Pine.LNX.4.64.1104281047060.1187@cobra.newdream.net>
	<BANLkTikVT0oSB2kcdXrZN58d_BybLY97BA@mail.gmail.com>
	<BANLkTin5eMEyQb=KWL0T5ah1cQ0N0hDARQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:57493 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755650Ab1D1S13 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Apr 2011 14:27:29 -0400
Received: by bwz15 with SMTP id 15so2528572bwz.19
        for <ceph-devel@vger.kernel.org>; Thu, 28 Apr 2011 11:27:27 -0700 (PDT)
In-Reply-To: <BANLkTin5eMEyQb=KWL0T5ah1cQ0N0hDARQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin McCabe <cmccabe@alumni.cmu.edu>
Cc: Sage Weil <sage@newdream.net>, Tommi Virtanen <tommi.virtanen@dreamhost.com>, Brian Chrisman <brchrisman@gmail.com>, ceph-devel@vger.kernel.org

On Thu, Apr 28, 2011 at 11:24 AM, Yehuda Sadeh Weinraub
<yehudasa@gmail.com> wrote:
>>
>> What do you guys think of changing struct ceph_mount_t to struct
>> ceph_mount_info_t?
>>
> I personally don't like sticking a _t prefix to a struct. It's either
> a typedef or a struct.
>
Ahrm.. *postfix*
