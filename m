From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: Ceph behavior in case of network failure
Date: Mon, 30 Jan 2012 09:14:09 -0800
Message-ID: <CAF3hT9A6JZPUdWxbeixdpbCQEuEZfDLzD4EvjASG0+6U3EV_Eg@mail.gmail.com>
References: <loom.20120129T054836-318@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:50448 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751987Ab2A3ROK convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Jan 2012 12:14:10 -0500
Received: by ggnb1 with SMTP id b1so1932206ggn.19
        for <ceph-devel@vger.kernel.org>; Mon, 30 Jan 2012 09:14:09 -0800 (PST)
In-Reply-To: <loom.20120129T054836-318@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Madhusudhan <madhusudhana.u.acharya@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Sat, Jan 28, 2012 at 8:52 PM, Madhusudhan
<madhusudhana.u.acharya@gmail.com> wrote:
> I have configured ceph in centos5.6 after a
> very long fight. Now, i am in the way
> to evaluate the Ceph. Forget me if my
> question looks amateur. If we consider a
> situation where my core switch fails,
> resulting in n/w failure in entire data
> center. What happens to ceph cluster ?
> will it sustain this n/w failure and comes
> online when the n/w is restored ?

Hmmm. If your network breaks horribly, you will probably need to
restart the daemons =97=A0once their communication breaks they'll start
marking each other down and the monitors will probably accept those
reports once the network starts working again. (Actually, maybe we
should update that so the monitors reject sufficiently old reports.)
But it will be a transient effect; restarting your machines will be
enough to restore service. :)
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
