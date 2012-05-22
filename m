From: Jerker Nyberg <jerker@Update.UU.SE>
Subject: Re: Designing a cluster guide
Date: Tue, 22 May 2012 11:04:34 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1205220852290.15565@Psilocybe.Update.UU.SE>
References: <4FB75BAD.3080709@profihost.ag> <8423c457-a8bb-4d26-a643-9573a8bb11a5@mailpro>
 <CAMvP8PDRUTO8M0=4MvjDtEtUM7aKePOWvGRFiJA1onu4VgXHPw@mail.gmail.com>
 <CAMwB3TicLaW54wAyZZ=-V7nY-DX0igU8XDh+ZRw_WuK0juH15A@mail.gmail.com>
 <7111C6286D862F43B94FD6291D8989158644DD@EX01.onqtel.local>
 <CAPYLRzgyyW5N894X1T=-gNyRdPmu-+VDr0=NuuLVEs93nGJZbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-293463789-1943731892-1337669890=:15565"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from Psilocybe.Update.UU.SE ([130.238.19.25]:41068 "EHLO
	Psilocybe.Update.UU.SE" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757034Ab2EVJOT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 May 2012 05:14:19 -0400
Received: from localhost (localhost [127.0.0.1])
	by Psilocybe.Update.UU.SE (Postfix) with ESMTP id A31DA3006E
	for <ceph-devel@vger.kernel.org>; Tue, 22 May 2012 11:04:34 +0200 (CEST)
In-Reply-To: <CAPYLRzgyyW5N894X1T=-gNyRdPmu-+VDr0=NuuLVEs93nGJZbw@mail.gmail.com>
Content-ID: <Pine.LNX.4.64.1205220858200.15565@Psilocybe.Update.UU.SE>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---293463789-1943731892-1337669890=:15565
Content-Type: TEXT/PLAIN; CHARSET=iso-8859-1; FORMAT=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <Pine.LNX.4.64.1205220858201.15565@Psilocybe.Update.UU.SE>

On Mon, 21 May 2012, Gregory Farnum wrote:

> This one  the write is considered "safe" once it is on-disk on all
> OSDs currently responsible for hosting the object.

Is it possible to configure the client to consider the write successful 
when the data is hitting RAM on all the OSDs but not yet committed to 
disk?

Also, the IBM zFS research file system is talking about cooperative cache 
and Lustre about a collaborative cache. Do you have any thoughts of this 
regarding Ceph?

Regards,
Jerker Nyberg, Uppsala, Sweden.
---293463789-1943731892-1337669890=:15565--
