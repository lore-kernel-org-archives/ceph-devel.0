From: Roald van Loon <roaldvanloon@gmail.com>
Subject: Re: subdir-objects
Date: Mon, 9 Sep 2013 13:47:22 +0200
Message-ID: <CAN04cT75xpt2iGpEmsfXYTeCfttyPAmnagvQVa59ZzwowX0Dfw@mail.gmail.com>
References: <CAN04cT5zbp2oe9QvcbnQ4W=7ByA1UybzPEGGWvngjLogsqFaWA@mail.gmail.com>
	<CA+Hcz5-uxiNMQiNXKfbETiQG0D6-nUrbV5oGpmMqn8oWi4DwGw@mail.gmail.com>
	<alpine.DEB.2.00.1308211340020.28981@cobra.newdream.net>
	<CAN04cT74h7QjWhOCQqc3e7HM__qaw+BrbaCy3NW_ZzC1xzX4Kg@mail.gmail.com>
	<CA+Hcz59qJgWY2gukY8h-=c_HXj5Dxj-UCEHrEnBXZKEckWEgJg@mail.gmail.com>
	<CAN04cT6FOspeq0NEN798ChLAJUuXsV2cFnzDLbQVNj0=pO6PPw@mail.gmail.com>
	<CA+Hcz5_JRZVWn6iohEyy7iTnHTGH=tbqd+MrxaDwWbD_p3V_cQ@mail.gmail.com>
	<CA+Hcz5-BgMzomAeGna8bMGjMv4Y2MsknBaSrmHEQHB-0-yFzCQ@mail.gmail.com>
	<CAN04cT4P4ELASm1VoxmHKaje8DHiCpB-bSyMWugjOo19k6j4hg@mail.gmail.com>
	<alpine.DEB.2.00.1309071335580.8602@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:43655 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752271Ab3IILrX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Sep 2013 07:47:23 -0400
Received: by mail-ob0-f182.google.com with SMTP id wo10so5715355obc.41
        for <ceph-devel@vger.kernel.org>; Mon, 09 Sep 2013 04:47:23 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1309071335580.8602@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Noah Watkins <noah.watkins@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sat, Sep 7, 2013 at 10:39 PM, Sage Weil <sage@inktank.com> wrote:
> I'm particularly keen on doing what we can to reduce build time.  I also
> agree there is a fair bit of tree restructuring that needs to be done.
> (For example, libcommon.la is huge and includes lots of stuff that most
> targets don't actually need; breaking this into smaller pieces would
> probably help.)

I've made some notes while cleaning up the automake stuff. It's on the
wiki as a blueprint now so people can contribute and hopefully it will
start a discussion about this;

http://wiki.ceph.com/01Planning/02Blueprints/Emperor/Source_tree_restructuring

Feel free to add/comment!

Roald
