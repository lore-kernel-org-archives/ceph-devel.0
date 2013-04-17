From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: Re: ceph and efficient access of distributed resources
Date: Wed, 17 Apr 2013 09:22:46 +0200
Message-ID: <CAJH6TXiNcUcsCbDWQpx-w6hPzGDnZanRH8jwOtC+wgo8fskWUQ@mail.gmail.com>
References: <loom.20130412T055215-88@post.gmane.org>
	<51683184.9010301@inktank.com>
	<CAJH6TXgurT4yUshaH4QOgUKOaB3DqQd1-=HPshp+eH5HB7p3Hg@mail.gmail.com>
	<516C7E55.1050801@inktank.com>
	<516C8168.40402@inktank.com>
	<CAJH6TXhRtWQ1ypEb5JOwzp9T3Nd7A=J_6Dn0M25vXjYMg8j7fQ@mail.gmail.com>
	<516D5DB3.4060800@inktank.com>
	<CAJH6TXiaE-Srrs68JN=mGV2jWh_ofsHVC8zNWaG_BTaaeq0L8g@mail.gmail.com>
	<516DB83B.1010601@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:39548 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757925Ab3DQHWr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Apr 2013 03:22:47 -0400
Received: by mail-wi0-f175.google.com with SMTP id h11so141053wiv.14
        for <ceph-devel@vger.kernel.org>; Wed, 17 Apr 2013 00:22:46 -0700 (PDT)
In-Reply-To: <516DB83B.1010601@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Kampe <mark.kampe@inktank.com>
Cc: Matthias Urlichs <matthias@urlichs.de>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Il giorno 16/apr/2013 22:44, "Mark Kampe" <mark.kampe@inktank.com> ha scritto:
>
> The client does a 12MB read, which (because of the striping)
> gets broken into 3 separate 4MB reads, each of which is sent,
> all in parallel, to 3 distinct OSDs.  The only bottle-neck
> in such an operation is the client-NIC.


Thank you, now it's clear.
