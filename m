From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: read performance not perfect
Date: Fri, 5 Aug 2011 12:35:20 -0700
Message-ID: <CAF3hT9A5k3-vfbjn=WGJv_ghvoOd0Rd9kLC-6i5Op05xcLpYOA@mail.gmail.com>
References: <CABAwU-YJ8DFjphavMQ+NjqPU7=fFBtwsEMzE7xT1G8gp4LywSA@mail.gmail.com>
	<Pine.LNX.4.64.1107181012540.22215@cobra.newdream.net>
	<CABAwU-YKmEC=umFLzDb-ykPbzQ9s3sKoUmQbkumExrXEwyveNA@mail.gmail.com>
	<Pine.LNX.4.64.1108040846500.17151@cobra.newdream.net>
	<loom.20110804T213454-854@post.gmane.org>
	<Pine.LNX.4.64.1108041252230.26398@cobra.newdream.net>
	<4E3B2D78.5060605@ufm.su>
	<Pine.LNX.4.64.1108041825230.29841@cobra.newdream.net>
	<4E3B8F0E.20606@ufm.su>
	<Pine.LNX.4.64.1108050905350.12301@cobra.newdream.net>
	<4E3C44DC.9090906@ufm.su>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:62926 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753200Ab1HETfV convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Aug 2011 15:35:21 -0400
Received: by gya6 with SMTP id 6so376153gya.19
        for <ceph-devel@vger.kernel.org>; Fri, 05 Aug 2011 12:35:21 -0700 (PDT)
In-Reply-To: <4E3C44DC.9090906@ufm.su>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fyodor Ustinov <ufm@ufm.su>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

On Fri, Aug 5, 2011 at 12:30 PM, Fyodor Ustinov <ufm@ufm.su> wrote:
> On 08/05/2011 07:07 PM, Sage Weil wrote:
>>
>> This is the problem. =A0The readahead patches in the master branch o=
f
>> git://ceph.newdream.net/git/ceph-client.git. =A0They're not upstream=
 yet.
>> Sorry that wasn't clear!
>
> http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux.git;a=3Dco=
mmit;h=3De9852227431a0ed6ceda064f33e4218757acab6c
> - it's not this patch?
Nope, that patch essentially just adjusted a preference setting. The
full set of patches are much more extensive.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
